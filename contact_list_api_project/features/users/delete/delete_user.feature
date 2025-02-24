Feature: DELETE User

    delete User via API

        # method: DELETE 'https://thinking-tester-contact-list.herokuapp.com/users/me'
        # expected response:
        # According the the API documentation - no response is expected

        @sanity @positive
        Scenario: Successfully delete an existing user
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/me"
              And the following user already exists in the database:
                  | firstName   | lastName   | email                | password   |
                  | QAFirstName | QALastName | anyemail@outlook.com | myPassword |
              And the request contains a valid authorization token
             When the user sends a DELETE request to the API
             Then the response status code should be 200
              And the response body should not contain any message
              And the user with email "anyemail@outlook.com" should no longer exist in the DB
              And no other users should be affected in the DB


        @sanity @regression @negative
        Scenario: Failing to delete a user with an invalid token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/me"
              And the request contains an invalid authorization token
             When a DELETE request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message "Unauthorized"

        @sanity @regression @negative
        Scenario: Failing to delete a user with an expired token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/me"
              And the request contains an already expired authorization token
             When a DELETE request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message "Unauthorized"


        @smoke @negative
        Scenario: Failing to delete a user without a token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/me"
              And the request does not contain an authorization token
             When a DELETE request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message "Unauthorized"
