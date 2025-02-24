Feature: DELETE Contacts

        delete Contact via API

        # method: DELETE 'https://thinking-tester-contact-list.herokuapp.com/contacts/<contact_id>'
        # header 'Authorization: Bearer {{token}}'
        # expected response:
        # "Contact deleted"

        @sanity @positive
        Scenario Outline: Successfully delete an existing contact
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/<contact_id>"
              And the request contains a valid authorization token
              And a contact with the following details already exists in the DB:
                  | _id       | <contact_id> |
                  | firstName | <first_name> |
                  | lastName  | <last_name>  |
                  | email     | <email>      |
             When the user sends a DELETE request to the API
             Then the response status code should be 200
              And the response should contain a success message "Contact deleted"
              And the contact with <contact_id> should no longer exist in the database
              And no other contacts should be affected in the DB

        Examples:
                  | contact_id               | first_name | last_name | email           |
                  | 6085a221fcfc72405667c3d4 | Sara       | Miller    | saram@gmail.com |


        @sanity @negative
        Scenario: Failing to delete a contact with an invalid token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/<any existing contact id>"
              And the request contains an invalid authorization token
             When a DELETE request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message indicating "Unauthorized"


        @sanity @negative
        Scenario: Failing to delete a contact with an expired token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/<any existing contact id>"
              And the request contains an expired authorization token
             When a DELETE request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message indicating "Unauthorized"


        @smoke @negative
        Scenario: Failing to delete a contact with an invalid ID
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/invalid_id"
              And the request contains a valid authorization token
             When a DELETE request is sent to the API
             Then the response status code should be 404
              And the response body should contain an error message indicating "Contact not found"
