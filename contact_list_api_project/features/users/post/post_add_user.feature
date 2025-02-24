Feature: POST Add User

              Add New User via API
        # method: POST 'https://thinking-tester-contact-list.herokuapp.com/users'
        # header 'Authorization: Bearer {{token}}'
        # body example:
        # {
        #     "firstName": "Test",
        #     "lastName": "User",
        #     "email": "test@fake.com",
        #     "password": "myPassword"
        # }

        # Following scenarios assume that the email address is the unique user identifier.
        @sanity @positive
        Scenario Outline: Successfully add a new user
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users"
              And the request contains a valid authorization token
              And no user with <email> already exists in the database
             When adding a new user with the following details:
                  | firstName | <first_name> |
                  | lastName  | <last_name>  |
                  | email     | <email>      |
                  | password  | <password>   |
              And a POST request is sent to the API
             Then the response status code should be 201
              And the response body should include the new created user details
              And the new user with <email> should exist in the database
              And No other information should be affected in the DB
        Examples:
                  | first_name | last_name | email              | password    |
                  | NewUserFN  | NewUserLN | newemail@gmail.com | 123456789A@ |


        @regression @negative
        Scenario: Failing to add a user with an invalid token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users"
              And the request contains an invalid authorization token
              And the request body contains valid user details
             When a POST request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message indicating "Unauthorized"


        @smoke @negative
        Scenario Outline: Failing to add a user with missing or invalid data
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users"
              And the request contains a valid authorization token
              And the request body contains invalid user details:
                  | field        | value           |
                  | <field_name> | <invalid_value> |
             When a POST request is sent to the API
             Then the response status code should be 400
              And the response body should contain an error message "<error_message>"
        Examples:
                  | field_name | invalid_value      | error_message        |
                  | email      | invalid-email      | Invalid email format |
                  | password   |                    | Password is required |
                  | email      | newemail@gmail.com | User already exists  |
