# RFID-Secure-embedded-system-project

Security systems play an important role in preventing unauthorized users from entering a secure 
location. The security system is divided into two types; the use of a normal door lock key and 
the use of an electronic automatic identification system. In general, locks are very simple devices 
that can be easily broken by unwanted people, allowing unauthorized people to enter secure 
locations.
Security is one of the main necessaries of a system. Lots of systems become useless without 
security. When we consider a particular system, it has different types of users. Allowing access 
to authenticated users is a major role in security. An access control system is helpful for archive 
this task.
It must need to enhanced security in access-controlled systems which are used in warehouse, 
datacentres, etc. So it, not sufficient to access the system using only a username and password.
The regular Authentication system has not details about accessed users. But it is very important 
to keep information about users to enhance security. Otherwise, system administration also 
cannot provide information about accessed users.
So the need for a low-cost, efficient access control system is recognized by us. Our solution 
should accurate and has capable to store several users' information. We realized that software 
parts, hardware parts, and databases are required.
Here, we implemented a secured access system, the only authorized person can access the 
system by scanning their RFIDs.

# Project Outcomes
* We implemented a low-cost system. Here we used Arduino UNO board, LCD display, 
buzzer as major hardware components. The total Hardware cost of the project is 
2600.00LKR Therefore we were able to achieve our objective. 
 
* The accuracy of the software and hardware part is 100%. All the testing cases are 
correctly identified and performed the required response. 
 
* The system is capable of storing user login data up to 10GB. (We used Microsoft SQL 
Server as the database). Therefore this system can be kept a larger amount of login 
records. 
 
* The system software is capable of adding users to the system easily (only system 
administrates). Then the system can be easily expandable. 
 
* Our Access Control System authenticates via RFID. RFIDs are faster than biometric 
methods such as a fingerprint. This system response in less than 2 seconds and start to 
open the gate. Therefore this system is faster than expected. 
 
* The system is capable of identifying any authorized access and then the buzzer turns on 
and the gate does not open for a particular unauthorized user. This information also 
saves to the database.


## System Components
* Hardware
  * RFID tags
  * RFID Readers
  * Microcontroller (Atmega328p)
  * LED Display
  * Buzzer & LEDs
  * 12V power supply

* Software 
  * Windows form Application (.Net Framework)
  * MS SQL server database
