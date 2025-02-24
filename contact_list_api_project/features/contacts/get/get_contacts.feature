Feature: GET Contagts

    Retrieve Single Contact via API
        # method: GET
        # url: https://thinking-tester-contact-list.herokuapp.com/contacts/<contact_id>
        # header 'Authorization: Bearer {{token}}' \
        # response example:
        # {
        #   "_id": "6085a221fcfc72405667c3d4",
        #   "firstName": "John",
        #   "lastName": "Doe",
        #   "birthdate": "1970-01-01",
        #   "email": "jdoe@fake.com",
        #   "phone": "8005555555",
        #   "street1": "1 Main St.",
        #   "street2": "Apartment A",
        #   "city": "Anytown",
        #   "stateProvince": "KS",
        #   "postalCode": "12345",
        #   "country": "USA",
        #   "owner": "6085a21efcfc72405667c3d4",
        #   "__v": 0
        # }

        @positive
        Scenario Outline: Successfully retrieve a single contact by <contact_id>
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/<contact_id>"
              And the request contains a valid authorization token
              And the DB includes several contact and 1 of them is one with the following details:
                  | Field Name    | Value         |
                  | firstName     | <first_name>  |
                  | lastName      | <last_name>   |
                  | birthdate     | <birthdate>   |
                  | email         | <email>       |
                  | phone         | <phone>       |
                  | street1       | <street1>     |
                  | street2       | <street2>     |
                  | city          | <city>        |
                  | stateProvince | <state>       |
                  | postalCode    | <postal_code> |
                  | country       | <country>     |
             When a GET request is sent to the API
             Then the response status code should be 200
              And the response body should contain only the foolowing the contact details object:
                  | Field Name    | Expected Value |
                  | _id           | <contact_id>   |
                  | firstName     | <first_name>   |
                  | lastName      | <last_name>    |
                  | birthdate     | <birthdate>    |
                  | email         | <email>        |
                  | phone         | <phone>        |
                  | street1       | <street1>      |
                  | street2       | <street2>      |
                  | city          | <city>         |
                  | stateProvince | <state>        |
                  | postalCode    | <postal_code>  |
                  | country       | <country>      |
                  | owner         | <owner_id>     |
                  | __v           | 0              |
        Examples:
                  | contact_id               | first_name | last_name | birthdate  | email         | phone      | street1    | street2     | city    | state | postal_code | country | owner_id                 |
                  | 6085a221fcfc72405667c3d4 | John       | Doe       | 1970-01-01 | jdoe@fake.com | 8005555555 | 1 Main St. | Apartment A | Anytown | KS    | 12345       | USA     | 6085a21efcfc72405667c3d4 |


        @sanity @negative
        Scenario: Failing to retrieve a contact with invalid token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/<valid_contact_id>"
              And the request contain an invalid authorization token
             When a GET request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message indicating "Unauthorized"


        @smoke @negative
        Scenario: Failing to retrieve a contact with invalid ID
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/<invalid_contace_id>"
              And the request contains a valid authorization token
             When a GET request is sent to the API
             Then the response status code should be 404
              And the response body should contain an error message indicating "Contact not found"
