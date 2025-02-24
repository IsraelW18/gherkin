Feature: Customers Managment

    managing customers include several actions, such as searching, sorting, and deleting customers
    
    # MANAGER_BASE_URL is a global value defined in - ../steps/common_steps.py

        @integration @positive
        Scenario Outline: Scenario Outline: The "Search Customer" box should support case-insensitive partial matches by First Name
            Given a list of customers with the following First Name already exist in the DB:
            # This scenario assumes that the characters in these First Name values do not appear in any Customer or Account property, including the related Customer
                  | First Name |
                  | Ariel      |
                  | No am      |
                  | Noa        |
              And no other customers exist in the DB
              And the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/list" form by clicking "Customers" button
              And enter a <search_key> into the "Seach Customer" search box
             Then the following customers should appear in the result area:
                  | First Name        |
                  | <search_result_1> |
                  | <search_result_2> |
                  | <search_result_3> |
        Examples:
                  | manager_main_page | search_key | search_result_1 | search_result_2 | search_result_3 |
                  | MANAGER_BASE_URL  | A          | Ariel           | No am           | Noa             |
                  | MANAGER_BASE_URL  | no         | No am           | Noa             |                 |
                  | MANAGER_BASE_URL  | ri         | Ariel           |                 |                 |
                  | MANAGER_BASE_URL  | "o a"      | No am           |                 |                 |
        

        @integration @negative
        Scenario Outline: The "Search Customer" box should trim leading and trailing whitespace in partial matches by First Name
            Given a list of customers with the following First Name already exist in the DB:
            # This scenario assumes that the characters in these First Name values do not appear in any Customer or Account property, including the related Customer
                  | First Name |
                  | Ariel      |
                  | No am      |
                  | Noa        |
              And no other customers exist in the DB
              And the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/list" form by clicking "Customers" button
              And enter a <search_key> into the "Seach Customer" search box
             Then the following customers should appear in the result area:
                  | First Name        |
                  | <search_result_1> |
                  | <search_result_2> |
                  | <search_result_3> |
        Examples:
                  | manager_main_page | search_key | search_result_1 | search_result_2 | search_result_3 |
                  | MANAGER_BASE_URL  | " oa"      | Noa             |                 |                 |
                  | MANAGER_BASE_URL  | "ri "      | Ariel           |                 |                 |
                  | MANAGER_BASE_URL  | " "        | Ariel           | No am           | Noa             |


        @integration @positive
        Scenario Outline: The "Search Customer" box should support case-insensitive partial matches by Last Name
            Given a list of customers with the following Last Name already exist in the DB:
            # This scenario assumes that the characters in these Last Name values do not appear in any Customer or Account property, including the related Customer
                  | Last Name |
                  | Carmi     |
                  | Bar ak    |
                  | Mizrachi  |
              And no other customers exist in the DB
              And the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/list" form by clicking "Customers" button
              And enter a <search_key> into the "Search Customer" search box
             Then the following customers should appear in the result area:
                  | Last Name         |
                  | <search_result_1> |
                  | <search_result_2> |
                  | <search_result_3> |
        Examples:
                  | manager_main_page | search_key | search_result_1 | search_result_2 | search_result_3 |
                  | MANAGER_BASE_URL  | r          | Carmi           | Bar ak          | Mizrachi        |
                  | MANAGER_BASE_URL  | C          | Carmi           | Mizrachi        |                 |
                  | MANAGER_BASE_URL  | rm         | Carmi           |                 |                 |
                  | MANAGER_BASE_URL  | "r a"      | Bar ak          |                 |                 |
                  | MANAGER_BASE_URL  | x          |                 |                 |                 |

        @integration @negative
        Scenario Outline: The "Search Customer" box should trim leading and trailing whitespace in partial matches by Last Name
            Given a list of customers with the following Last Name already exist in the DB:
            # This scenario assumes that the characters in these Last Name values do not appear in any Customer or Account property, including the related Customer
                  | Last Name |
                  | Carmi     |
                  | Bar ak    |
                  | Mizrachi  |
              And no other customers exist in the DB
              And the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/list" form by clicking "Customers" button
              And enter a <search_key> into the "Search Customer" search box
             Then the following customers should appear in the result area:
                  | Last Name         |
                  | <search_result_1> |
                  | <search_result_2> |
                  | <search_result_3> |
        Examples:
                  | manager_main_page | search_key | search_result_1 | search_result_2 | search_result_3 |
                  | MANAGER_BASE_URL  | " iz"      | Mizrachi        |                 |                 |
                  | MANAGER_BASE_URL  | "br "      | Bar ak          |                 |                 |
                  | MANAGER_BASE_URL  | " "        | Carmi           | Bar ak          | Mizrachi        |
                  

        @integration @positive
        Scenario Outline: The "Search Customer" box should support case-insensitive partial matches by Post Code
            Given a list of customers with the following Post Code already exist in the DB:
            # This scenario assumes that the characters in these Post Code values do not appear in any Customer or Account property, including the related Customer
                  | Post Code |
                  | E85 9AB   |
                  | 593346    |
                  | 933675    |
              And no other customers exist in the DB
              And the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/list" form by clicking "Customers" button
              And enter a <search_key> into the "Search Customer" search box
             Then the following customers should appear in the result area:
                  | Post Code         |
                  | <search_result_1> |
                  | <search_result_2> |
                  | <search_result_3> |
        Examples:
                  | manager_main_page | search_key | search_result_1 | search_result_2 | search_result_3 |
                  | MANAGER_BASE_URL  | 5          | E85 9AB         | 592346          | 43675           |
                  | MANAGER_BASE_URL  | 93         | 593346          | 933675          |                 |
                  | MANAGER_BASE_URL  | a          | E85 9AB         |                 |                 |
                  | MANAGER_BASE_URL  | y          |                 |                 |                 |
                  | MANAGER_BASE_URL  | "5 9"      | E85 9AB         |                 |                 |

        @integration @negative
        Scenario Outline: The "Search Customer" box should trim leading and trailing whitespace in partial matches by Post code
            Given a list of customers with the following Post Code already exist in the DB:
            # This scenario assumes that the characters in these Post Code values do not appear in any Customer or Account property, including the related Customer
                  | Post Code |
                  | E85 9AB   |
                  | 593346    |
                  | 933675    |
              And no other customers exist in the DB
              And the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/list" form by clicking "Customers" button
              And enter a <search_key> into the "Search Customer" search box
             Then the following customers should appear in the result area:
                  | Post Code         |
                  | <search_result_1> |
                  | <search_result_2> |
                  | <search_result_3> |
        Examples:
                  | manager_main_page | search_key | search_result_1 | search_result_2 | search_result_3 |
                  | MANAGER_BASE_URL  | " aB"      | E85 9AB         |                 |                 |
                  | MANAGER_BASE_URL  | "34 "      | 593346          |                 |                 |
                  | MANAGER_BASE_URL  | " "        | E85 9AB         | 592346          | 43675           |


        @integration @positive
        Scenario Outline: The "Search Customer" box should support case-insensitive partial matches by Account Number
            Given a list of customers related to one of the following Account Numbers already existing in the DB:
            # This scenario assumes that the characters in these Account Number values do not appear
            # in any Customer or Account property, including the related Customer
                  | Account Number |
                  | 1089           |
                  | 1890           |
                  | 0105           |
              And no other customers exist in the DB
              And the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/list" form by clicking "Customers" button
              And enter a <search_key> into the "Search Customer" search box
             Then the following customers should appear in the result area:
                  | Account Number    |
                  | <search_result_1> |
                  | <search_result_2> |
                  | <search_result_3> |
        # The following valid input values are limited due to the Account Number created
        # automaticaly by the system without user impact
        Examples:
                  | manager_main_page | search_key | search_result_1 | search_result_2 | search_result_3 |
                  | MANAGER_BASE_URL  | 0          | 1001            | 1890            | 0105            |
                  | MANAGER_BASE_URL  | 89         | 1089            | 1890            |                 |
                  | MANAGER_BASE_URL  | 01         | 0105            |                 |                 |


        @integration @negative
        Scenario Outline: The "Search Customer" box should trim leading and trailing whitespace in partial matches by Account Number
            Given a list of customers related to one of the following Account Numbers already existing in the DB:
            # This scenario assumes that the characters in these Account Number values do not appear  
            # in any Customer or Account property, including the associated Customer.  
                  | Account Number |
                  | 1089           |
                  | 1890           |
                  | 0105           |
              And no other customers exist in the DB
              And the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/list" form by clicking "Customers" button
              And enter a <search_key> into the "Search Customer" search box
             Then the following customers should appear in the result area:
                  | Account Number    |
                  | <search_result_1> |
                  | <search_result_2> |
                  | <search_result_3> |
        # The following negative input values are limited because Account Numbers are  
        # automatically generated by the system without user influence.                   
        Examples:
                  | manager_main_page | search_key | search_result_1 | search_result_2 | search_result_3 |
                  | MANAGER_BASE_URL  | " 01"      | 0105            |                 |                 |
                  | MANAGER_BASE_URL  | "01 "      | 0105            |                 |                 |
                  | MANAGER_BASE_URL  | " "        | 1001            | 1890            | 0105            |
        
        
        @integration
        Scenario Outline: Clearing the search box should re-display all customers
            Given the following list of customers already exist in the DB:
                  | First Name |
                  | Ariel      |
                  | Noam       |
                  | Noa        |
              And the user is logged in as a bank manager on the <manager_main_page> page
             When the user navigates to "/list" form by clicking the "Customer" button
              And enter "A" into the "Search Customer" search box
              And clear the "Search Customer" search box
             Then all customers exist in the DB should be re-displayed in the result area
        Examples:
                  | manager_main_page |
                  | MANAGER_BASE_URL  |


       # Following scenario assumes that when a Customer is deleted,
       # it is archived instead of being permanently removed
        @integration
        Scenario Outline: Deleting a customer by cliking on the "Delete" button
            Given there are several Customers in DB
              And the user is logged-in as a bank manager on the <manager_main_page> page
             When the user navigates to "/list" form by clicking "Customers" button
              And click the "Delete" button for 1 Customer in the list
             Then the Customer disappear from the UI
              And the Customer account with all it's Bank Account becomes archived in DB
        Examples:
                  | manager_main_page |
                  | MANAGER_BASE_URL  |


        @integration
        Scenario Outline: Clicking on the <column_name> column should toggle sorting order
            Given the following list of customers already exist in the DB:
                  | First Name | Last Name | Post Code |
                  | Ariel      | Cohen     | 30390     |
                  | Noam       | Levi      | E25 715D  |
                  | Jonathan   | Mizrachi  | 879635    |
              And the user is logged in as a bank manager on the <manager_main_page> page
             When the user clicks on the <column_name> column header for the 1st time
             Then all items in the result table should be sorted in Descending order based on the <column_name> column:
                  | <column_name>  |
                  | <desc_value_1> |
                  | <desc_value_2> |
                  | <desc_value_3> |
             When the user clicks on the <column_name> column header for the 2nd time
             Then all items in the result table should be sorted in Ascending order based on the <column_name> column:
                  | <column_name> |
                  | <asc_value_1> |
                  | <asc_value_2> |
                  | <asc_value_3> |
        Examples:
                  | manager_main_page | column_name | desc_value_1 | desc_value_2 | desc_value_3 | asc_value_1 | asc_value_2 | asc_value_3 |
                  | MANAGER_BASE_URL  | First Name  | Noam         | Jonathan     | Ariel        | Ariel       | Jonathan    | Noam        |
                  | MANAGER_BASE_URL  | Last Name   | Mizrachi     | Levi         | Cohen        | Cohen       | Levi        | Mizrachi    |
                  | MANAGER_BASE_URL  | Post Code   | E25 715D     | 879635       | 30390        | 30390       | 879635      | E25 715D    |

        