Feature: Main Bank Page

    The main page should allow users to navigate to their relevant Login page

        # Using a main 'Given' Statement which is shared for all tests in this feature
        Background:
            Given the user is on the "https://www.globalsqa.com/angularJs-protractor/BankingProject/#/login" page

        @smoke @sanity @gui
        Scenario: Verify that main page loads correctly
             Then the page title should be 'XYZ Bank'
              And its text CSS style should be as follows:
                  | Property   | Value  |
                  | font-size  | 30px   |
                  | color      | white  |
                  | text-align | center |
                # Following .css values are examples
              And there are 3 buttons in the page with the following details:
                  | Button Text        | Button Background Color | Button Text Color | Button Margin |
                  | Home               | #FFFFFF                 | #000333           | 0px           |
                  | Customer Login     | #286090                 | #000fff           | 0px           |
                  | Bank Manager Login | #286090                 | #000fff           | 0px           |


        @Sanity @Regression @gui
        Scenario Outline: Navigation to the Manager and Customer pages from main page
             When click on the <login_button> button
             Then the <page> page should be displayed
        Examples:
                  | login_button       | page              |
                  | Bank Manager Login | Bank Manager Page |
                  | Customer Login     | Customers Page    |
