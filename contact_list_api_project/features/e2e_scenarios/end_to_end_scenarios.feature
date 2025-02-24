Feature: End-to-End API Testing for Users and Contacts

        # End to End scenario:
        # Creating a new user >> logging in >> adding a contact >> updating >> deleting >> logging out
        @e2e @positive
        Scenario: Full user and contact validation flow
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users"
              And no user with email "anyemail@gmail.com" exists in the database
             When adding a new user with the following details:
                  | Field     | Value              |
                  | firstName | E2EuserFN          |
                  | lastName  | E2EuserLN          |
                  | email     | anyemail@gmail.com |
                  | password  | E2Epass123@        |
             Then the user with email "anyemail@gmail.com" should exist in the database

             When logging in with the following credentials:
                  | email    | anyemail@gmail.com |
                  | password | E2ETest123@        |
             Then the response body should include a valid token

             When adding a new contact with the following details:
                  | Field      | Value             |
                  | firstName  | Dan               |
                  | lastName   | Arieli            |
                  | email      | darieli@yahoo.com |
                  | phone      | 0521234567        |
                  | street1    | 5 Main St.        |
                  | city       | Tel Aviv          |
                  | postalCode | 67890             |
                  | country    | Israel            |
             Then the contact with email "darieli@yahoo.com" should exist in the database

             When updating the contact with the following new details:
                  | Field | Value      |
                  | phone | 0507654321 |
             Then the contact in the database should include "0507654321" in the phone field

             When deleting the contact with email "darieli@yahoo.com"
             Then the contact with email "darieli@yahoo.com" should no longer exist in the database

             When logging out the user
             Then the token should no longer be valid for future requests


        # Negative E2E scenario: Attempting to perform all main actions with an expired token
        @e2e @negative
        Scenario: Full flow with expired token validation flow
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users"
              And the request contains an expired authorization token
             When attempting to add a new user
             Then the response status code should be 401
              And the response body should contain an error message "Unauthorized"

             When attempting to log in with an expired token
             Then the response status code should be 401
              And the response body should contain an error message "Unauthorized"

             When attempting to add a contact with an expired token
             Then the response status code should be 401
              And the response body should contain an error message "Unauthorized"

             When attempting to update a contact with an expired token
             Then the response status code should be 401
              And the response body should contain an error message "Unauthorized"

             When attempting to delete a contact with an expired token
             Then the response status code should be 401
              And the response body should contain an error message "Unauthorized"