Feature: Customer Login

    Logging in as a customer allows access to its multiple bank accounts, 
    viewing and browsing in the transaction history, and performing deposits and withdrawals.

        Background:
            Given the user is on the "https://www.globalsqa.com/angularJs-protractor/BankingProject/#/customer" page

        @Sanity @Regression @gui
        Scenario: Verify that the Customer Login page loads correctly
             Then the following elements should be present:
                  | Element Type | Element Name |
                  | page title   | XYZ Bank     |
                  | button       | Home         |
                  | dropdown     | Your Name:   |
              And "Your Name" dropdown field includes all Customers exist in the DB in the following format:
                  | First Name          | Last Name          |
                  | customer first name | customer last name |


        @sanity @regression @gui
        Scenario: Selecting a customer enables login button
             When the user selects a value in the "Your Name" dropdown field
             Then the "Login" button should be displayed


        @sanity @integration @gui
        Scenario: Logging in as a new customer which does not include a bank account
             When the user select a value in the "Your Name" dropdown field
              And clicks the "Login" button
             Then the user redirected to the "/account" page
              And the following message appears to the user:
                  """Welcome <user first name> <user last name> !! Please open an account with us.
                  """
              And the following elements appears on the page:
                  | Element Type | Element Name |
                  | page title   | XYZ Bank     |
                  | button       | Home         |
                  | button       | Logout       |


        # Following scenario assump that when a Customer incldues only 1 account,
        # it should appear in the main customer page as a lable and not in a dropdown list
        @smoke @gui
        Scenario: Logging-in as a customer which includes only 1 bank account
             When the user select a value in the "Your Name" dropdown field
              And clicks the "Login" button
             Then the user redirected to the "/account" page
              And the following message appears to the user:
                  """Welcome <user first name> <user last name> <account number>
                  """
              And the following additional elements appears on the page:
                  | Element Type | Element Name                             |
                  | page title   | XYZ Bank                                 |
                  | button       | Home                                     |
                  | button       | Logout                                   |
                  | label        | Account Number: <account number>         |
                  | label        | Balance: <account balance>               |
                  | label        | Currency: <account currency> (bold text) |
                  | button       | Transactions                             |
                  | button       | Deposit                                  |
                  | button       | Withdrawal                               |
                  

        @smoke @gui
        Scenario: Logging in as a customer which includes 2 bank accounts
             When the user select a value in the "Your Name" dropdown field
              And clicks the "Login" button
             Then the user redirected to the "/account" page
              And the following message appears to the user:
                  """Welcome '<user first name>' '<user last name>' !!
                  """
              And a dropdown field allows switching between customer accounts appears near the welcome message
              And the following additional elements appears on page:
                  | Element Type | Element Name                             |
                  | page title   | XYZ Bank                                 |
                  | button       | Home                                     |
                  | button       | Logout                                   |
                  | lable        | Account Number: <acount number>          |
                  | lable        | Balance: <account balance>               |
                  | lable        | Currency: <account currency> (bold text) |
                  | button       | Transactions                             |
                  | button       | Deposit                                  |
                  | button       | Withdrawal                               |


        @negative @authorization
        Scenario Outline: Validate that the Accounts dropdown displays only the customer associated bank accounts
            Given the following bank accounts exist for the user in the DB
                  | Account Number | Balance | Currency |
                  | 1001           | 8000    | Dollar   |
                  | 1002           | 5000    | Rupee    |
                  | 1003           | 11000   | Pound    |
              And the user is logged-in and is on the customer "/account" page
             When the user openes the Accounts dropdown
             Then only the <account_num> Acconts appears in the dropdown list
              And no other Accounts appears in the Accounts dropdown
        Examples:
                  | account_num |
                  | 1001        |
                  | 1002        |
                  | 1003        |


        @sanity @integration
        Scenario Outline: Switching between customer accounts using the account dropdown list
            Given the following bank accounts exist for the user in the DB
                  | Account Number | Balance | Currency |
                  | 1001           | 8000    | Dollar   |
                  | 1002           | 5000    | Rupee    |
                  | 1003           | 11000   | Pound    |
              And the user is logged-in and is on the customer "/account" page
             When the user select <account_number> in the "account dropdown"
             Then the following elemets on page will change respectively:
                  | Label name     | Value            |
                  | Account number | <account_number> |
                  | Balance        | <balance>        |
                  | Currency       | <currency>       |
        Examples:
                  | account_number | balance | currency |
                  | 1001           | 8000    | Dollar   |
                  | 1003           | 11000   | Pound    |
                  | 1002           | 5000    | Rupee    |