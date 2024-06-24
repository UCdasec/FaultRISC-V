#include <stdio.h>

int main(int argc, char** argv) {
    switch (argc) {
    case 0: printf("Impossible"); break;
    case 1: printf("Too few args"); break;
    case 2: printf("Correct number of args"); break;
    default: printf("Default"); break;
    }

    if (argv[0] == "main.c") {
        printf("main");
        for (int i = 0; i < 10; i++) {
            printf("Loop");
        }
    }
    else if (argv[0] == "other.c") {
        printf("other");
        if (argv[1] == "A") {
            printf("A");
        }
        else if (argv[1] == "B") {
            printf("B");
        }
        else {
            printf("First else");
        }
    }
    else {
        printf("Second else");
    }
}