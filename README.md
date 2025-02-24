# CheckPoint Candidate Home Task

**Repository Owner:** [Israel Wasserman](https://www.linkedin.com/in/israel-wasserman/) 

## Project Overview
This repository contains BDD scenarios for following 2 projects:
* **Bank Web Application Project**
* **API - Contact List Project**

---

## 1️. Bank Web Application (BDD)
This section includes behavior-driven development (BDD) test scenarios for the banking web application.

* **Main Page**
* **Bank Manager Functionality**
* **Customer Login Page Functionality** (as specified in the task instructions)

***Global Environment Variables***
<br>
The project uses global variables for "multi-environment maintenance" and simplified environment switching in tests.  
These variables are defined in: [/steps/common_steps.py](https://github.com/IsraelW18/CheckPoint_CandidateHomeTask/blob/main/banking_web_app_project/features/steps/common_steps.py)

---

## 2️. API – Contact List Project (BDD & Postman)
This section includes API test scenarios and Postman scripts for managing contacts and users.

**BDD scenarios** for all API requests:
  - **Contacts** (Adding, Retrieving, Updating, and Deleting contacts)
  - **Users** (Authentication & management)

**Postman collection** with script examples:
  * **Validation using 'Script'** in **GET Contacts** request
  * **Global parameters storage** in the following requests:
    - **POST** – Add Contacts
    - **POST** – Log In User

---
##