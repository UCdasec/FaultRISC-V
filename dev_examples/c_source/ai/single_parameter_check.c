#include <stdio.h>
#include <stdbool.h>

// Function prototypes
bool checkCondition1(int data);

int main() {
    FILE *file;
    int data;

    // Open file for reading
    file = fopen("data.txt", "r");
    if (file == NULL) {
        printf("Error opening file!\n");
        return 1;
    }

    // Read data from file
    fscanf(file, "%d", &data);

    // Close the file
    fclose(file);

    // Check conditions using boolean functions
    if (checkCondition1(data)) {
        printf("Condition 1 is true\n");

    } else {
        printf("Condition 1 is false\n");
    }

    return 0;
}

// Boolean function implementations
bool checkCondition1(int data) {
    int threshold1;
    printf("Enter the threshold for Condition 1: ");
    scanf("%d", &threshold1);
    printf("Checking Condition 1 with threshold %d\n", threshold1);
    // Example condition: data is greater than threshold
    return (data > threshold1);
}
