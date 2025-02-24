Feature: GET User Profile

    Get User Profile via API
        # method: GET 'https://thinking-tester-contact-list.herokuapp.com/users/me'
        # header 'Authorization: Bearer {{token}}'
        # response example:
        # {
        #   "_id": "608b2db1add2691791c04c89",
        #   "firstName": "Test",
        #   "lastName": "User",
        #   "email": "test@fake.com",
        #   "__v": 1
        # }

        @sanity @positive
        Scenario: Successfully retrieving the current user profile
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/me"
              And make sure a user with the following details already exist in the DB:
                  | Field     | Value                    |
                  | _id       | 608b2db1add2691791c04c89 |
                  | firstName | QA First Name            |
                  | lastNamee | QA Last Name             |
                  | email     | newemail@gmail.com       |
              And the request contains a valid authorization token
             When a GET request is sent to the API
             Then the response status code should be 200
              And the response body should contain the current user profile details:
                  | firstName | Test               |
                  | lastName  | User               |
                  | email     | newemail@gmail.com |


        @sanity @negative
        Scenario: Failing to retrieve user profile with an invalid token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/me"
              And the request contains an invalid authorization token
             When a GET request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message indicating "Unauthorized"


        @smoke @negative
        Scenario: Failing to retrieve user profile with a missing token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/me"
              And the request does not contain an authorization token
             When a GET request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message indicating "Unauthorized"


        @regression @negative
        Scenario: Failed to retrieve another user profile
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/users/another_user_id"
              And the request contains a valid authorization token
             When a GET request is sent to the API
             Then the response status code should be 403
              And the response body should contain an error message indicating "Forbidden"
