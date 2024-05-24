#include <stdio.h>

// Function to check if the temperature is above a certain threshold
int isTemperatureHigh(int temperatureThreshold, int currentTemperature) {
    return currentTemperature > temperatureThreshold;
}

// Function to perform cooling action
void startCoolingSystem() {
    printf("Cooling system activated!\n");
    // Code to start the cooling system goes here
}

// Function to read temperature from the sensor
int readTemperature() {
    // Simulating temperature reading from a sensor
    return 30; // Replace with actual sensor reading logic
}

int main() {
    // Initialize the temperature threshold
    int temperatureThreshold = 25;

    // Read current temperature from the sensor
    int currentTemperature = readTemperature();

    // Store the result of isTemperatureHigh function in a variable
    int isTemperatureHighResult = isTemperatureHigh(temperatureThreshold, currentTemperature);

    // Check the stored result of isTemperatureHigh function
    if (isTemperatureHighResult) {
        printf("Temperature is high!\n");
        startCoolingSystem();
    } else {
        printf("Temperature is within normal range.\n");
    }

    return 0;
}

