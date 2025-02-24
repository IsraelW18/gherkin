Feature: PATCH Update Contact

    Partially Update Contact via API

        # method: PATCH 'https://thinking-tester-contact-list.herokuapp.com/contacts/<contact_id>'
        # header 'Authorization: Bearer {{token}}'
        # body example:
        # {
        #   "firstName": "Anna"
        # }

        @sanity @regression @positive
        Scenario Outline: Successfully update specific fields of an existing contact
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/<contact_id>"
              And the request contains a valid authorization token
              And a contact with the following details already exists in the DB:
                  | _id       | <contact_id>     |
                  | firstName | <original_first> |
                  | lastName  | <original_last>  |
                  | email     | <original_email> |
             When the user updates the following field:
                  | field        | value       |
                  | <field_name> | <new_value> |
              And a PATCH request is sent to the API
             Then the response status code should be 200
              And the contact in the DB should have <new_value> in the <field_name> field
              And all other contact fields should remain unchanged
              And all other contacts information should not be affected
        # Following inputs are examples, each field should be tested separately.
        Examples:
                  | contact_id               | original_first | original_last | original_email  | field_name | new_value        |
                  | 6085a221fcfc72405667c3d4 | Sara           | Miller        | saram@gmail.com | firstName  | Anna             |
                  | 6085a221fcfc72405667c3d4 | Sara           | Miller        | saram@gmail.com | email      | anna@hotmail.com |

        @regression @negative
        Scenario: Failing to update a contact with invalid token using PATCH
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/6085a221fcfc72405667c3d4"
              And the request contains an invalid authorization token
              And the request body contains valid contact details
             When a PATCH request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message "Unauthorized"


        @regression @negative
        Scenario: Failed to update a contact with invalid ID using PATCH
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/invalid_id"
              And the request contains a valid authorization token
              And the request body contains valid contact details
             When a PATCH request is sent to the API
             Then the response status code should be 404
              And the response body should contain an error message "Contact not found"


        @regression @negative
        Scenario Outline: Failing to update a contact with invalid data using PATCH
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts/<contact_id>"
              And the request contains a valid authorization token
              And the request body contains invalid contact details:
                  | field        | value           |
                  | <field_name> | <invalid_value> |
             When a PATCH request is sent to the API
             Then the response status code should be 400
              And the response body should contain an error message <error_message>
        # Following inputs are examples, each field should be tested separately.
        Examples:
                  | contact_id               | field_name | invalid_value | error_message               |
                  | 6085a221fcfc72405667c3d4 | email      | invalid-email | Invalid email format        |
                  | 6085a221fcfc72405667c3d4 | phone      | abc1234567    | Invalid phone number format |
