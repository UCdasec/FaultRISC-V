#include <stdio.h>

// Function to check if motion is detected
int isMotionDetected() {
    // Simulating motion detection logic
    return 1; // Replace with actual motion detection logic
}

// Function to check if door is open
int isDoorOpen() {
    // Simulating door status
    return 0; // Replace with actual door status reading logic
}

// Function to trigger alarm
void triggerAlarm() {
    printf("Intrusion detected! Activating alarm.\n");
    // Code to activate alarm goes here
}

int main() {
    // Check if motion is detected
    if (isMotionDetected()) {
        triggerAlarm();
    } else {
        // Check if the door is open
        if (isDoorOpen()) {
            triggerAlarm();
        } else {
            printf("No intrusion detected. System is secure.\n");
            // Additional logic for a secure system goes here
        }
    }

    return 0;
}

