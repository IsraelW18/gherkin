Feature: POST Login User

    Login User via API
        # method: POST 'https://thinking-tester-contact-list.herokuapp.com/users/login'
        # header 'Authorization: Bearer {{token}}'
        # body example:
        # {
        #   "email": "test2@fake.com",
        #   "password": "myNewPassword"
        # }

        @sanity @regression @positive
        Scenario: Successfully logging in a user
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/login"
              And the following user already exists in the database:
                  | firstName | lastName | email              | password      |
                  | Updated   | Username | anyemail@gmail.com | myNewPassword |
              And the request body contains valid login credentials:
                  | Field    | Value              |
                  | email    | anyemail@gmail.com |
                  | password | myNewPassword      |
             When the POST request is sent to the API
             Then the API generated a new valid token for the given user
              And the response status code should be 200
              And the response body should contain the logged-in user's details:
                  | Field     | Value                    |
                  | _id       | 608b2db1add2691791c04c89 |
                  | firstName | Updated                  |
                  | lastName  | Username                 |
                  | email     | anyemail@gmail.com       |
                  | __v       | 212                      |
              And the response body should include a valid token


        @sanity @negative
        Scenario: Failing to log in with an invalid password
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/login"
              And the following user already exists in the database:
                  | firstName | lastName | email              | password   |
                  | Updated   | Username | anyemail@gmail.com | myPassword |
              And the request body contains the following invalid password:
                  | Field    | Value              |
                  | email    | anyemail@gmail.com |
                  | password | 123456             |
             When a POST request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message "Invalid login credentials"


        @sanity @negative
        Scenario: Failed to log in with an invalid email
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/login"
              And the request body contains the following invalid login email:
                  | Field    | Value             |
                  | email    | invalid@gmail.com |
                  | password | myNewPassword     |
             When a POST request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message "Invalid login credentials"


        @smoke @negative
        Scenario Outline: Failed to log in with missing data
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/login"
              And the request body contains missing login credentials:
                  | Field   | Value   |
                  | <field> | <value> |
             When a POST request is sent to the API
             Then the response status code should be 400
              And the response body should contain an error message "<error_message>"

        Examples:
                  | field    | value | error_message         |
                  | email    |       | Email is mandator     |
                  | password |       | Password is mandatory |