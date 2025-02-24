Feature: PATCH Update User

    Partially Update User via API

    # method: PATCH 'https://thinking-tester-contact-list.herokuapp.com/users/me'
    # header 'Authorization: Bearer {{token}}'
    # body example:
    # {
    #     "firstName": "Updated",
    #     "lastName": "Username",
    #     "email": "test2@fake.com",
    #     "password": "myNewPassword"
    # }

        @sanity @regression @positive
        Scenario Outline: Successfully update specific fields of an existing user
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/me"
              And the request contains a valid authorization token
              And a user with the following details already exists in the DB:
                  | firstName | <original_firstN> |
                  | lastName  | <original_lastN>  |
                  | email     | <original_email>  |
             When the user updates the following field:
                  | field        | value       |
                  | <field_name> | <new_value> |
              And a PATCH request is sent to the API
             Then the response status code should be 200
              And the user in the DB should have <new_value> in the <field_name> field
              And all other user fields should remain unchanged
              And no other users should be affected in the DB
        Examples:
                  | original_firstN | original_lastN | original_email | field_name | new_value        |
                  | Test            | User           | test@gmail.com | firstName  | NewFN            |
                  | Test            | User           | test@gmail.com | lastName   | NewLN            |
                  | Test            | User           | test@gmail.com | email      | newemail@aol.com |
                  | Test            | User           | test@gmail.com | password   | newepassword!*&  |


        @regression @negative
        Scenario: Failed to update a user with invalid token using PATCH
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/me"
              And the request contains an invalid authorization token
              And the request body contains valid user details
             When a PATCH request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message "Unauthorized"


        @regression @negative
        Scenario: Failed to update another user profile using PATCH
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/other_user_id"
              And the request contains a valid authorization token
              And the request body contains valid user details
             When a PATCH request is sent to the API
             Then the response status code should be 403
              And the response body should contain an error message "Forbidden"


        @regression @negative
        Scenario Outline: Failed to update a user with invalid data using PATCH
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/me"
              And the request contains a valid authorization token
              And the request body contains invalid user details:
                  | field        | value           |
                  | <field_name> | <invalid_value> |
             When a PATCH request is sent to the API
             Then the response status code should be 400
              And the response body should contain an error message <error_message>
        # The following inputs are examples only, each field should be tested separately.
        Examples:
                  | field_name | invalid_value | error_message        |
                  | email      | invalid-email | Invalid email format |
                  | password   |               | Password is required |
