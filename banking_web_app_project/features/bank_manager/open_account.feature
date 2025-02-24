Feature: Open Account

    Opening bank account for customers
    
    # MANAGER_BASE_URL is a global value defined in - ../steps/common_steps.py

        @sanity @integration @positive
        Scenario Outline: Verifying that all created customers from DB appear in the Customer dropdown list
            Given the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/openAccount" form by cliking "Open Account" button
              And open the Customer dropdown list
             Then all existing customers from the database should appear
              And no other values should be present
        Examples:
                  | manager_main_page |
                  | MANAGER_BASE_URL  |


        @Regression @integration @positive
        Scenario Outline: Verifying that the Currency dropdown list includes the relevant items
            Given the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/openAccount" form by cliking "Open Account" button
              And open the Currency dropdown list
             Then following values appear in the list
                  | Currency Name |
                  | Dollar        |
                  | Pound         |
                  | Rupee         |
              And no other values should be present
        Examples:
                  | manager_main_page |
                  | MANAGER_BASE_URL  |

        # The next scenario is written under the assumption that
        # a customer may have several unique accounts per Currency 
        @Regression @syetem @negative
        Scenario Outline: Creating 3 bank accounts with different currencies for the same existing customer
            Given the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/openAccount" form by cliking "Open Account" button
              And select a customer from the "Customer" dropdown list
              And select a <currency> from the "Currency" dropdown list
              And click the "Process" button
             Then a popup "Account created successfully with account Number: <account_num>" should be appeared for the user
              And the new account should be added to the DB with all relevant Customer details
              And the account currency should be <currency>
        Examples:
                  | manager_main_page | currency |
                  | MANAGER_BASE_URL  | Dollar   |
                  | MANAGER_BASE_URL  | Pound    |
                  | MANAGER_BASE_URL  | Rupee    |


        # The next scenario is written under the assumption that 
        # a customer may not have duplicated accounts with the same currency
        @syetem @negative
        Scenario Outline: Attempting to create multiple accounts with the same currency for the same customer
            Given a Customer with the following details already exist in DB:
                  | Field      | Value          |
                  | First Name | AUT_First_Name |
                  | Last Name  | AUT_Last_Name  |
                  | Post Code  | 98765          |
              And the Customer includes already a relation to a Bank Account with Currency: <curreny>
              And the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/openAccount" form by cliking "Open Account" button
              And select a <customer> from the "Customer" dropdown list
              And select a <currency> from the "Currency" dropdown list
              And click the "Process" button
             Then a popup alert with the following message appears for the user:
                  """Same account already exist.
                  Cannot create multiple accounts with same Currency for the same Customer!
                  """
              And the new account should not be added to the DB
        Examples:
                  | manager_main_page | customer                     | currency |
                  | MANAGER_BASE_URL  | AUT_First_Name AUT_Last_Name | Dollar   |
                  
                  
        @sanity @integration @negative
        Scenario Outline: Trying to create a Bank Account with empty values
            Given the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/openAccount" form by clicking "Open Account" button
              And select a <customer> from the Customer dropdown field
              And select a <currency> from the Currency dropdown field
              And click the "Process" button
             Then a tool-tip alert "Please select an item in the list" should appear near the missing value
              And a new bank account should not be added to the DB
        # <any value> means any option from the dropdown list
        Examples:
                  | customer    | currency    |
                  | <any value> |             |
                  |             | <any value> |
                  