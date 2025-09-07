#include <iostream>
#include <cstdlib>   // for system()
#include <string>
#include <limits>
#include <vector>
#include <unordered_map>

// Try to use <filesystem>, fallback to <experimental/filesystem>
#if __has_include(<filesystem>)
    #include <filesystem>
    namespace fs = std::filesystem;
#elif __has_include(<experimental/filesystem>)
    #include <experimental/filesystem>
    namespace fs = std::experimental::filesystem;
#else
    #error "No filesystem support on this compiler."
#endif

#ifdef _WIN32
    #define CLEAR "cls"
#else
    #define CLEAR "clear"
#endif

// === ANSI Color Codes ===
namespace Color {
    const std::string reset   = "\033[0m";
    const std::string red     = "\033[31m";
    const std::string green   = "\033[32m";
    const std::string yellow  = "\033[33m";
    const std::string blue    = "\033[34m";
    const std::string magenta = "\033[35m";
    const std::string cyan    = "\033[36m";
    const std::string bold    = "\033[1m";
}

// === Command Maps ===
#ifdef _WIN32
std::unordered_map<std::string, std::string> commandMap = {
    {".py",   "python \"{file}\""},
    {".js",   "node \"{file}\""},
    {".coffee", "coffee \"{file}\""},
    {".c",    "gcc \"{file}\" -o temp.exe && temp.exe"},
    {".cpp",  "g++ \"{file}\" -o temp.exe && temp.exe"},
    {".cs",   "csc \"{file}\" && {basename}.exe"},
    {".rs",   "rustc \"{file}\" -o temp.exe && temp.exe"},
    {".go",   "go run \"{file}\""}
};
#else
std::unordered_map<std::string, std::string> commandMap = {
    {".py",   "python3 \"{file}\""},
    {".js",   "node \"{file}\""},
    {".coffee", "coffee \"{file}\""},
    {".c",    "gcc \"{file}\" -o temp && ./temp"},
    {".cpp",  "g++ \"{file}\" -o temp && ./temp"},
    {".cs",   "mcs \"{file}\" && mono {basename}.exe"},
    {".rs",   "rustc \"{file}\" -o temp && ./temp"},
    {".go",   "go run \"{file}\""}
};
#endif

// === Helper: replace placeholders ===
std::string expandCommand(const std::string& templateCmd, const std::string& filename) {
    std::string cmd = templateCmd;
    std::string basename = fs::path(filename).stem().string();

    size_t pos = cmd.find("{file}");
    if (pos != std::string::npos) cmd.replace(pos, 6, filename);

    pos = cmd.find("{basename}");
    if (pos != std::string::npos) cmd.replace(pos, 10, basename);

    return cmd;
}

// === Pause until Enter is pressed ===
void pressEnterToContinue() {
    std::cout << "\n" << Color::yellow << "Press Enter to continue..." << Color::reset;
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}

// === Scan current directory for supported files ===
std::vector<std::string> getSupportedFiles() {
    std::vector<std::string> files;
    for (const auto& entry : fs::directory_iterator(".")) {
        if (entry.is_regular_file()) {
            std::string ext = entry.path().extension().string();
            if (commandMap.find(ext) != commandMap.end()) {
                files.push_back(entry.path().filename().string());
            }
        }
    }
    return files;
}

// === Safe integer input ===
int getIntInput(const std::string& prompt) {
    int value;
    while (true) {
        std::cout << prompt;
        if (std::cin >> value) {
            std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
            return value;
        } else {
            std::cin.clear();
            std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
            std::cout << Color::red << "Invalid input. Try again.\n" << Color::reset;
        }
    }
}

// === Run file based on extension, cleanup temp binaries ===
void runFile(const std::string& filename) {
    std::string ext = fs::path(filename).extension().string();
    std::string basename = fs::path(filename).stem().string();

    auto it = commandMap.find(ext);
    if (it == commandMap.end()) {
        std::cout << Color::red << "Unsupported file type: " << ext << Color::reset << "\n";
        return;
    }

    std::string cmd = expandCommand(it->second, filename);
    std::cout << Color::blue << "Running: " << cmd << Color::reset << "\n";

    int result = system(cmd.c_str());
    if (result != 0) {
        std::cout << Color::red << "Execution failed (code " << result << ")." << Color::reset << "\n";
    }

    // === Cleanup Section ===
#ifdef _WIN32
    std::vector<std::string> tempFiles = {
        "temp.exe",                   // from C/C++/Rust
        basename + ".exe"             // from C#
    };
#else
    std::vector<std::string> tempFiles = {
        "temp", "temp.exe",           // from C/C++/Rust
        basename + ".exe"             // from Mono (C#)
    };
#endif

    for (const auto& f : tempFiles) {
        if (fs::exists(f)) {
            try {
                fs::remove(f);
                std::cout << Color::green << "[Cleaned up] " << f << Color::reset << "\n";
            } catch (...) {
                std::cout << Color::red << "[Failed to delete] " << f << Color::reset << "\n";
            }
        }
    }
}

int main() {
    while (true) {
        system(CLEAR);
        std::cout << Color::cyan << Color::bold
        << "——⟪LycanDev Code Dashboard⟫——"
        << Color::reset << "\n";

        auto files = getSupportedFiles();

        std::cout << "\n" << Color::green << "Program List:" << Color::reset << "\n";
        std::cout << Color::yellow << "0" << Color::reset << " - Exit\n";

        for (size_t i = 0; i < files.size(); ++i) {
            std::cout << Color::yellow << (i + 1) << Color::reset
        << " - " << files[i] << "\n";
        }

        std::cout << Color::yellow << (files.size() + 1) << Color::reset
        << " - Terminal\n";

        int Program = getIntInput("\nEnter a program number: ");

        if (Program == 0) {
            std::cout << Color::magenta << "Exiting dashboard. Goodbye!\n" << Color::reset;
            return 0;
        }
        else if (Program >= 1 && Program <= (int)files.size()) {
            std::string file = files[Program - 1];
            runFile(file);
            pressEnterToContinue();
        }
        else if (Program == (int)files.size() + 1) {
#ifdef _WIN32
            system("cmd.exe");
#else
            const char* shell = std::getenv("SHELL");
            system(shell ? shell : "bash");
#endif
            pressEnterToContinue();
        }
        else {
            std::cout << Color::red << "Invalid program number\n" << Color::reset;
            pressEnterToContinue();
        }
    }
    return 0;
}
