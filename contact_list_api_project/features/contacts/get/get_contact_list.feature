Feature: GET Contact List

    Retrieve Contact List via API

        # method: GET
        # url: https://thinking-tester-contact-list.herokuapp.com/contacts
        # header 'Authorization: Bearer {{token}}' \
        # response example:
        # [
        #   {
        #     "_id": "6085a221fcfc72405667c3d4",
        #     "firstName": "John",
        #     "lastName": "Doe",
        #     "birthdate": "1970-01-01",
        #     "email": "jdoe@fake.com",
        #     "phone": "8005555555",
        #     "street1": "1 Main St.",
        #     "street2": "Apartment A",
        #     "city": "Anytown",
        #     "stateProvince": "KS",
        #     "postalCode": "12345",
        #     "country": "USA",
        #     "owner": "6085a21efcfc72405667c3d4",
        #     "__v": 0
        #   },
        #   {
        #     "_id": "607b29861ba4d3a0b96733bc",
        #     "firstName": "Jan",
        #     "lastName": "Brady",
        #     "birthdate": "2001-11-11",
        #     "email": "fake2@gmail.com",
        #     "phone": "8008675309",
        #     "street1": "100 Elm St.",
        #     "city": "Springfield",
        #     "stateProvince": "NE",
        #     "postalCode": "23456",
        #     "country": "United States",
        #     "owner": "6085a21efcfc72405667c3d4",
        #     "__v": 0
        #   }
        # ]

        @sanity @resression @positive
        Scenario: Successfully retrieve the list of all contacts
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts"
              And there are already several contacts exist in the DB
              And the request contains a valid authorization token
             When a GET request is sent to the API
             Then the response status code should be 200
              And the response should be an array in Json format
              And each contact in the json should have the following fields:
                  | Field Name    |
                  | _id           |
                  | firstName     |
                  | lastName      |
                  | birthdate     |
                  | email         |
                  | phone         |
                  | street1       |
                  | city          |
                  | stateProvince |
                  | postalCode    |
                  | country       |
                  | owner         |
                  | __v           |


        @resression @positive
        Scenario: Empty array returns in case no contacts exist in the DB
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts"
              And the DB do not contains any contact
              And the request contains a valid authorization token
             When a GET request is sent to the API
             Then the response status code should be 200
              And the response should be an empty array in Json format
              And "No contact exist in the DB" message should be appeared in the response
                  

        @sanity @regression @negative
        Scenario: Failing to retrieve the contact list without a valid token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts"
              And the request contain an invalid authorization token
             When a GET request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message indicating "Unauthorized"


        @sanity @regression @negative
        Scenario: Failed to retrieve the contact with an expired token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts"
              And the request contain an expired authorization token
             When a GET request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message indicating "Unauthorized"


        @smoke @negative
        Scenario: Failing to retrieve the contact list due to invalid endpoint
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/invalid"
              And the request contains a valid authorization token
             When a GET request is sent to the API
             Then the response status code should be 404
              And the response body should contain an error message indicating "Not Found"

