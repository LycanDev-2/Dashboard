#include <iostream>
#include <cstdlib>   // for system()
#include <string>    // for std::string
#include <limits>    // for std::numeric_limits

// Helper function to pause until Enter is pressed
void pressEnterToContinue() {
    std::cout << "\nPress Enter to continue...";
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}

int main() {
    while (true) {
        system("clear"); // Clear screen at the start of each loop
        std::cout << "LycanDev Code Dashboard\n";

        int Program;
        std::cout << "\nProgram List:\n"
                  << "0 - Exit\n"
                  << "1 - CyberSpace\n"
                  << "2 - OPFiles\n"
                  << "3 - Terminal\n";
        std::cout << "\nEnter a program number: ";
        std::cin >> Program;
        std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');

        switch (Program) {
            case 0:
                std::cout << "Exiting dashboard. Goodbye!\n";
                return 0;

            case 1:
                std::cout << "You selected CyberSpace\n";
                system("python3 Cyberspace.py");
                pressEnterToContinue();
                break;

            case 2:
                std::cout << "You selected OPFiles\n";
                // Add functionality for OPFiles here
                pressEnterToContinue();
                break;

            case 3: {
                system("clear");
                std::cout << "You selected Terminal (type 'exit' to return)\n";
                while (true) {
                    std::cout << "$ ";
                    std::string command;
                    std::getline(std::cin, command);

                    if (command == "exit") break;

                    if (!command.empty()) {
                        system(command.c_str());
                    }
                }
                break;
            }

            default:
                std::cout << "Invalid program number\n";
                pressEnterToContinue();
                break;
        }
    }

    return 0;
}
