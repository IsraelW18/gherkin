Feature: POST Log Out User

    Log Out User via API
        # method: POST 'https://thinking-tester-contact-list.herokuapp.com/users/logout'
        # header 'Authorization: Bearer {{token}}'
        # response example:
        # according the API documentation - not respose body is expected

        @sanity @positive
        Scenario: Successfully logging out a user
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/logout"
              And the request contains a valid authorization token
             When a POST request is sent to the API
             Then the response status code should be 200
              And the response body should remain empty
              And the user token should no longer be valid for future requests


        @smoke @negative
        Scenario: Failed to log out with an invalid token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/logout"
              And the request contains an invalid authorization token
             When a POST request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message "Unauthorized"


        @smoke @negative
        Scenario: Failing to log out without a token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/logout"
              And the request does not contain an authorization token
             When a POST request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message "Unauthorized"
