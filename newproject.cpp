#include <iostream>
#include <cstdlib>   // for system()
#include <string>
#include <limits>
#include <vector>

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

// Helper function to pause until Enter is pressed
void pressEnterToContinue() {
    std::cout << "\nPress Enter to continue...";
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}

// Scan current directory for Python scripts
std::vector<std::string> getPythonScripts() {
    std::vector<std::string> scripts;
    for (const auto& entry : fs::directory_iterator(".")) {
        if (entry.is_regular_file() && entry.path().extension() == ".py") {
            scripts.push_back(entry.path().filename().string());
        }
    }
    return scripts;
}

int main() {
    while (true) {
        system(CLEAR);
        std::cout << "LycanDev Code Dashboard\n";

        // Load Python scripts dynamically
        auto scripts = getPythonScripts();

        std::cout << "\nProgram List:\n";
        std::cout << "0 - Exit\n";

        // Display Python scripts dynamically (starting at option 1)
        for (size_t i = 0; i < scripts.size(); ++i) {
            std::cout << (i + 1) << " - " << scripts[i] << "\n";
        }

        // Terminal is always the last option
        std::cout << (scripts.size() + 1) << " - Terminal\n";

        // Get input
        int Program;
        std::cout << "\nEnter a program number: ";
        std::cin >> Program;
        std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');

        if (Program == 0) {
            std::cout << "Exiting dashboard. Goodbye!\n";
            return 0;
        }

        // Python script options
        if (Program >= 1 && Program <= (int)scripts.size()) {
            std::string script = scripts[Program - 1];
            std::cout << "Running " << script << "...\n";

            std::string command = "python3 \"" + script + "\"";
            system(command.c_str());

            pressEnterToContinue();
        }
        // Terminal option
        else if (Program == (int)scripts.size() + 1) {
            system(CLEAR);
            std::cout << "You selected Terminal (type 'exit' to return)\n";
            system("bash");
            while (true) {
                std::cout << "$ ";
                std::string command;
                std::getline(std::cin, command);

                if (command == "exit") break;
                if (!command.empty()) system(command.c_str());
            }
            // no pause here
        }
        // Invalid option
        else {
            std::cout << "Invalid program number\n";
            pressEnterToContinue();
        }
    }
    
    return 0;
}
