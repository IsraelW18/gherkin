# I decided to separate the 'Home' button navigation into a different feature
# to prevent the "Background" step above from running first in the following scenario.

Feature: Home button navigation
        @regression @usability @gui
        Scenario Outline: Clicking the Home button should redirect correctly from each location
            Given the user is on the <Current Page>
             When they click the "Home" button
             Then they should be redirected to <Expected Destination>

        Examples:
                  | Current Page            | Expected Destination                                                     |
                  | Main Page               | Main Page (no change)                                                    |
                  | Bank Manager Login Page | https://www.globalsqa.com/angularJs-protractor/BankingProject/#/login    |
                  | Customer Login Page     | https://www.globalsqa.com/angularJs-protractor/BankingProject/#/customer |
                  