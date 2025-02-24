Feature: PUT Update Contact
    
    Update Contact via API

        # Method: PUT 'https://thinking-tester-contact-list.herokuapp.com/contacts/<contact_id>'
        # header 'Authorization: Bearer {{token}}'
        # body example:
        #  {
        #     "firstName": "Sara",
        #     "lastName": "Miller",
        #     "birthdate": "1982-04-18",
        #     "email": "amiller@gmail.com",
        #     "phone": "9375554242",
        #     "street1": "13 School St.",
        #     "street2": "Apt. 15",
        #     "city": "Washington",
        #     "stateProvince": "NY",
        #     "postalCode": "A1B2D4",
        #     "country": "New york"
        #  }

        # Following scenarios assumes that all fields in the JSON are mandatory when using the PUT method
        # to prevent deletion of missing fields
        @sanity @regression @positive
        Scenario Outline: Successfully updating an existing contact
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/<contact_id>"
              And the request contains a valid authorization token
              And a contact with the following details already exists in the DB:
                  | _id           | <contact_id>       |
                  | firstName     | <original_first>   |
                  | lastName      | <original_last>    |
                  | birthdate     | <original_dob>     |
                  | email         | <original_email>   |
                  | phone         | <original_phone>   |
                  | street1       | <original_street1> |
                  | street2       | <original_street2> |
                  | city          | <original_city>    |
                  | stateProvince | <original_state>   |
                  | postalCode    | <original_postal>  |
                  | country       | <original_country> |
             When the user updates the contact with the following new details:
                  | firstName     | <new_first>   |
                  | lastName      | <new_last>    |
                  | birthdate     | <new_dob>     |
                  | email         | <new_email>   |
                  | phone         | <new_phone>   |
                  | street1       | <new_street1> |
                  | street2       | <new_street2> |
                  | city          | <new_city>    |
                  | stateProvince | <new_state>   |
                  | postalCode    | <new_postal>  |
                  | country       | <new_country> |
              And a PUT request is sent to the API
             Then the response status code should be 200
              And the response body should include the updated contact details
              And the contact in the database should be updated with:
                  | firstName     | <new_first>   |
                  | lastName      | <new_last>    |
                  | birthdate     | <new_dob>     |
                  | email         | <new_email>   |
                  | phone         | <new_phone>   |
                  | street1       | <new_street1> |
                  | street2       | <new_street2> |
                  | city          | <new_city>    |
                  | stateProvince | <new_state>   |
                  | postalCode    | <new_postal>  |
                  | country       | <new_country> |
              And no other cotacts should be affected in the DB
        Examples:
                  | contact_id               | original_first | original_last | original_dob | original_email  | original_phone | original_street1 | original_street2 | original_city | original_state | original_postal | original_country | new_first | new_last  | new_dob    | new_email         | new_phone  | new_street1   | new_street2 | new_city   | new_state | new_postal | new_country |
                  | 6085a221fcfc72405667c3d4 | Sara           | Miller        | 1975-11-08   | saram@gmail.com | 8005555555     | 1 Main St.       | Apartment A      | QA City       | NY             | 12345           | USA              | QA New FN | QA New LN | 1992-02-02 | qanew@hotmail.com | 8005981242 | 13 School St. | Apt. 5      | Washington | QC        | A1B2D4     | Canada      |


        @sanity @negative
        Scenario: Failing to update a contact with an invalid token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/6085a221fcfc72405667c3d4"
              And the request contain an invalid authorization token
              And the request body contains valid contact details
             When a PUT request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message indicating "Unauthorized"


        @sanity @negative
        Scenario: Failing to update a contact with an expired token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/6085a221fcfc72405667c3d4"
              And the request contain an expired authorization token
              And the request body contains valid contact details
             When a PUT request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message indicating "Unauthorized"


        @smoke @negative
        Scenario: Failing to update a contact with invalid ID
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/invalid_id"
              And the request contains a valid authorization token
              And the request body contains valid contact details
             When a PUT request is sent to the API
             Then the response status code should be 404
              And the response body should contain an error message indicating "Contact not found"


        @smoke @negative
        Scenario Outline: Failing to update a contact with invalid data
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/<contact_id>"
              And the request contains a valid authorization token
              And the request body contains invalid contact details:
                  | Field   | Value           |
                  | <field> | <invalid_value> |
             When a PUT request is sent to the API
             Then the response status code should be 400
              And the response body should contain an error message "<error_message>"
        # Following inputes based on the assupmtion that in PUT method params are optional, except of <contact_id>
        Examples:
                  | contact_id               | field         | invalid_value | error_message               |
                  | 6085a221fcfc72405667c3d4 | contact_id    |               | contact_id is mandatory     |
                  | 6085a221fcfc72405667c3d4 | firstName     |               | firstName is mandatory      |
                  | 6085a221fcfc72405667c3d4 | lastName      |               | lastName is mandatory       |
                  | 6085a221fcfc72405667c3d4 | email         |               | email is mandator           |
                  | 6085a221fcfc72405667c3d4 | phone         |               | phone is mandator           |
                  | 6085a221fcfc72405667c3d4 | street1       |               | street1 is mandator         |
                  | 6085a221fcfc72405667c3d4 | street2       |               | street2 is mandator         |
                  | 6085a221fcfc72405667c3d4 | city          |               | city is mandator            |
                  | 6085a221fcfc72405667c3d4 | stateProvince |               | stateProvince is mandator   |
                  | 6085a221fcfc72405667c3d4 | postalCode    |               | postalCode is mandator      |
                  | 6085a221fcfc72405667c3d4 | country       |               | country is mandator         |
                  | 6085a221fcfc72405667c3d4 | email         | invalid-email | Invalid email format        |
                  | 6085a221fcfc72405667c3d4 | phone         | abc1234567    | Invalid phone number format |
                  | 6085a221fcfc72405667c3d4 | birthdate     | 02-30-2020    | Invalid birthdate format    |