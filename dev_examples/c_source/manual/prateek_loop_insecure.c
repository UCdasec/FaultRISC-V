#include <stdio.h>
#include <stdlib.h>

void faultDetect() {
    fprintf(stderr, "Fault Detected\n");
    exit(EXIT_FAILURE); // Terminate the program with a failure status
}

int main() {
    int iterations;

    // Prompt the user to enter the number of iterations
    printf("Enter the number of iterations: ");
    scanf("%d", &iterations);

    // Perform tasks using a for-loop with the specified number of iterations
    for (int i = 0; i < iterations; i++) {
        printf("Task %d completed\n", i + 1);
    }

    printf("End of program\n");

    return 0;
}

