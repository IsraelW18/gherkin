Feature: POST Add Contacts

              Add New Contact via API

        # method: POST
        # url: https://thinking-tester-contact-list.herokuapp.com/contacts
        # header 'Authorization: Bearer {{token}}' \
        # body example:
        # {
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
        #     "country": "USA"
        # }
        @sanity @positive
        Scenario Outline: Successfully adding a new contact
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts"
              And the request contains a valid authorization token
              And the request body contains valid contact details:
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
             When a POST request is sent to the API
             Then the response status code should be 201
              And the new contant should be added to the DB
              And its details should be appeared in the response
              And the contact should have a unique "id" in DB
              And no other contacts in DB should be affected
        Examples:
                  | first_name | last_name | birthdate  | email               | phone      | street1      | street2     | city        | state | postal_code | country |
                  | David      | Avivi     | 1988-01-08 | davivi@gmail.com    | 0528963457 | 9 Collin St. | Apartment C | Anytown     | KS    | 12345       | USA     |
                  | Lea        | Arieli    | 2010-05-05 | larieli@outlook.com | 0583249246 | 5 Ore St.    | Suite B     | Springfield | IL    | 67890       | USA     |
                  | Ron        | Cohen     | 1995-09-09 | rcohen@hotmail.com  | 0547896543 | 7 Main St.   |             | Anytown     | KS    | 55555       | USA     |
                  | Sara       | Levi      | 1980-12-12 | slevi@aol.com       | 0501234567 | 15 Hill Rd.  | Apartment D | Springfield |       | 67890       | UK      |
                  | Dan        | Mor       | 2001-07-03 | dmor@yahoo.com      | 0539876543 | 3 Bay St.    |             | Miami       | FL    | 33101       | USA     |


        @sanity @negative
        Scenario Outline: Failing to add a new contact with invalid data
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts"
              And the request contains a valid authorization token
              And the request body contains invalid contact details:
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
             When a POST request is sent to the API
             Then the response status code should be 400
              And the response body should contain the following error message <error_message>
        # Following inputs assume the followings:
        #  1. Valid date format is yyyy-mm-dd
        #  2. Mandatory fields are those commonly accepted according to standard practices in most applications
        #  'State' value is mandatory only in USA
        Examples:
                  | first_name | last_name | birthdate  | email            | phone      | street1      | street2     | state | postal_code | country | error_message               |
                  |            | Avivi     | 1970-01-08 | davivi@gmail.com | 0528963457 | 9 Collin St. | Apartment B | KS    | 12345       | USA     | First name is required      |
                  | David      |           | 1970-01-08 | davivi@gmail.com | 0528963457 | 9 Collin St. | Apartment B | KS    | 12345       | USA     | Last name is required       |
                  | David      | Avivi     |            | davivi@gmail.com | 0528963457 | 9 Collin St. | Apartment B | KS    | 12345       | USA     | Birthdate is required       |
                  | David      | Avivi     | 1970-13-08 | davivi@gmail.com | 0528963457 | 9 Collin St. | Apartment B | KS    | 12345       | USA     | Birthdate format in invalid |
                  | David      | Avivi     | 1970-01-32 | davivi@gmail.com | 0528963457 | 9 Collin St. | Apartment B | KS    | 12345       | USA     | Birthdate format in invalid |
                  | David      | Avivi     | 1970/01/08 | davivi@gmail.com | 0528963457 | 9 Collin St. | Apartment B | KS    | 12345       | USA     | Birthdate format in invalid |
                  | David      | Avivi     | 1970.01.08 | davivi@gmail.com | 0528963457 | 9 Collin St. | Apartment B | KS    | 12345       | USA     | Birthdate format in invalid |
                  | David      | Avivi     | 08-01-1970 | davivi@gmail.com | 0528963457 | 9 Collin St. | Apartment B | KS    | 12345       | USA     | Birthdate format in invalid |
                  | David      | Avivi     | 1970-01-08 | invalid-email    | 0528963457 | 9 Collin St. | Apartment B | KS    | 12345       | USA     | Invalid email format        |
                  | David      | Avivi     | 1970-01-08 | davivi@gmail.com |            | 9 Collin St. | Apartment B | KS    | 12345       | USA     | Phone number is required    |
                  | David      | Avivi     | 1970-01-08 | davivi@gmail.com | abC        | 9 Collin St. | Apartment B | KS    | 12345       | USA     | Phone number is invalid     |
                  | David      | Avivi     | 1970-01-08 | davivi@gmail.com | !@$^&      | 9 Collin St. | Apartment B | KS    | 12345       | USA     | Phone number is invalid     |
                  | David      | Avivi     | 1970-01-08 | davivi@gmail.com | "   "      | 9 Collin St. | Apartment B | KS    | 12345       | USA     | Phone number is invalid     |
                  | David      | Avivi     | 1970-01-08 | davivi@gmail.com | -168235698 | 9 Collin St. | Apartment B | KS    | 12345       | USA     | Phone number is invalid     |
                  | David      | Avivi     | 1970-01-08 | davivi@gmail.com | 0528963457 |              | Apartment B | KS    | 12345       | USA     | Street1 address is required |
                  | David      | Avivi     | 1970-01-08 | davivi@gmail.com | 0528963457 | 9 Collin St. | Apartment B |       | 12345       | USA     | State is required in USA    |
                  | David      | Avivi     | 1970-01-08 | davivi@gmail.com | 0528963457 | 9 Collin St. | Apartment B | KS    | 12345       |         | Country is required         |


        @negative
        Scenario: Failed to add a new contact without a valid token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts"
              And the request does not contain an invalid authorization token
              And the request body contains valid contact details
             When a POST request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message indicating "Unauthorized"

        @negative
        Scenario: Failed to add a new contact with expired token
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/contacts"
              And the request contain an expired authorization token
              And the request body contains valid contact details
             When a POST request is sent to the API
             Then the response status code should be 401
              And the response body should contain an error message indicating "Unauthorized"


        @negative
        Scenario: Failing to add a new contact due to invalid endpoint
            Given the API endpoint is "https://thinking-tester-contact-list.herokuapp.com/invalid"
              And the request contains a valid authorization token
              And the request body contains valid contact details
             When a POST request is sent to the API
             Then the response status code should be 404
              And the response body should contain an error message indicating "Not Found"