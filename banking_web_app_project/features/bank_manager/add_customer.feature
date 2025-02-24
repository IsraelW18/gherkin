Feature: Add Customer

    Registering a new customer to the bank functionality, with valid and invalid inputs
    
    # MANAGER_BASE_URL is a global variable defined in - ../steps/common_steps.py

        @acceptance @positive
        Scenario Outline: Adding a new valid customer to the bank
            Given the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/addCust" form by cliking "Add Customer" button
              And enter the following Customer details:
                  | Field Name | Value        |
                  | First Name | <First Name> |
                  | Last Name  | <last_name>  |
                  | Post Code  | <post_code   |
              And click the "Add Customer" button
             Then a popup "Customer added successfully with customer id: <customer_id>" should be appeared for the user
              And the new Customer should be added to the DB with all details
        Examples:
                  | manager_main_page | first_name                 | last_name                  | post_code |
                  | MANAGER_BASE_URL  | fnlower                    | lnlower                    | 12345     |
                  | MANAGER_BASE_URL  | FNUPPER                    | LNUPPER                    | 123-4567  |
                  | MANAGER_BASE_URL  | fn with spaces             | ln with spaces             | EC1A 1BB  |
                  | MANAGER_BASE_URL  | fn'with-valid-special-chrs | ln'with-valid-special-chrs | 75008     |
                  | MANAGER_BASE_URL  | MediumlengthOfFirstName    | MediumLengthOfLastName     | 12 345    |


        # The "Add Customer" fields allow all types of characters,
        # but I added the following negative for demonstration purposes.
        @integration @negative
        Scenario Outline: Adding a new invalid customer to the bank
            Given the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/addCust" form by cliking "Add Customer" button
              And Enter the following Customer details:
                  | Field Name | Value        |
                  | First Name | <First Name> |
                  | Last Name  | <last_name>  |
                  | Post Code  | <post_code   |
              And click the "Add Customer" button
             Then a relevant popup "<...> value is not valid.. valid values are:..." should be appeared for the user
              And the new Customer should not be added to the DB
        Examples:
                  | manager_main_page | first_name                     | last_name                             | post_code |
                  | MANAGER_BASE_URL  | First$%^Name                   | Last^&*Name                           | %1*234/@5 |
                  | MANAGER_BASE_URL  | 123FirstName                   | 123LastName                           | 12345     |
                  | MANAGER_BASE_URL  | "      "                       | "      "                              | EC1A 1BB  |
                  | MANAGER_BASE_URL  | a                              | b                                     | 12 345    |
                  | MANAGER_BASE_URL  | LongFirstName-ABCDEFGHIGKLM... | LongLastName_ABCDEFGHIGKLMNOPQRSTU... | 12345     |
      

        # This scenario is separate from the previous invalid main scenario because the expected result differs
        @integration @negative
        Scenario Outline: Trying to add a Customer with empty values
            Given the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/addCust" form by cliking "Add Customer" button
              And Enter the following Customer details:
                  | Field Name | Value        |
                  | First Name | <First Name> |
                  | Last Name  | <last_name>  |
                  | Post Code  | <post_code   |
              And click the "Add Customer" button
             Then a tooltip alert "Please fill out this field." appeared neer the <field> field
              And the new Customer should not be added to the DB
        Examples:
                  | manager_main_page | first_name | last_name | post_code | field      |
                  | MANAGER_BASE_URL  |            | Cohen     | 12345     | First Name |
                  | MANAGER_BASE_URL  | David      |           | 12345     | Last Name  |
                  | MANAGER_BASE_URL  | David      | Cohen     |           | Post Code  |
                  | MANAGER_BASE_URL  |            |           |           | First Name |


        @integration @negative
        Scenario: Trying to add an already existing user into the DB
            Given the user with the following details alraedy exist in the DB:
                  | Field      | Value         |
                  | First Name | QA_First_Name |
                  | Last Name  | QA_Last_Name  |
                  | Post Code  | 67891         |
              And the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/addCust" form by cliking "Add Customer" button
              And enter the following Customer existing customer details:
                  | Field      | Value         |
                  | First Name | QA_First_Name |
                  | Last Name  | QA_Last_Name  |
                  | Post Code  | 67891         |
             Then A popup "Please check the details. Customer may be duplicate." will be appeared to the user


        # Following scenario assumes that when a Customer is deleted,
        # it is archived instead of being permanently removed
        @e2e @acceptance
        Scenario Outline: Adding a customer, opening an account, then deleting the customer and verifying account archiving
            Given the user is logged in as a bank manager on <manager_main_page>
             When the user adds a new customer with the following details:
                  | Field Name | Value        |
                  | First Name | <first_name> |
                  | Last Name  | <last_name>  |
                  | Post Code  | <post_code>  |
              And the customer is successfully created
              And the user opens a bank account for customer <first_name> <last_name> with <currency>
             Then the account should be successfully created and linked to <first_name> <last_name> customer

             When the user deletes the customer <first_name> <last_name>
             Then the customer <first_name> <last_name> should be removed from the system
              And all accounts linked to <first_name> <last_name> should be archived
        Examples:
                  | manager_main_page | first_name | last_name | post_code | currency |
                  | MANAGER_BASE_URL  | David      | Mizrachi  | 12345     | Dollar   |
                  | MANAGER_BASE_URL  | Noa        | Barak     | 67890     | Pound    |