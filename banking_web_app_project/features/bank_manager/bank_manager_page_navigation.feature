Feature: Bank Manager Page Navigation
        
    manager pages navigation and loading
   
    # MANAGER_BASE_URL is a global variable defined in - ../steps/common_steps.py

        @Smoke @Sanity @gui
        Scenario: Verify that the Bank Manager page loads correctly
            Given the user is on the "https://www.globalsqa.com/angularJs-protractor/BankingProject/#/manager" page
             Then the page title should be 'XYZ Bank'
              And the following buttons should be present:
                  | Button Text  |
                  | Add Customer |
                  | Open Account |
                  | Customers    |


        @Sanity @Regression @usability @gui
        Scenario Outline: Navigation and page elements loading verification
            Given the user is on the <manager_main_page> page
             When the user clicks on the <nav_button> button
             Then the <page> page should be displayed
              And the following elements should be present:
                  | Element Type | Element Name           |
                  | Page Title   | XYZ Bank               |
                  | button       | Home                   |
                  | button       | <expected_button>      |
                  | input field  | <expected_input_1>     |
                  | input field  | <expected_input_2>     |
                  | input field  | <expected_input_3>     |
                  | dropdown     | <expected_dropdown_1>  |
                  | dropdown     | <expected_dropdown_2>  |
                  | search box   | <expected_search_box>  |
                  | table column | <expected_table_col_1> |
                  | table column | <expected_table_col_2> |
                  | table column | <expected_table_col_3> |
                  | table column | <expected_table_col_4> |
                  | table column | <expected_table_col_5> |
        Examples:
                  | manager_main_page | nav_button   | page                | expected_button | expected_input_1 | expected_input_2 | expected_input_3 | expected_dropdown_1 | expected_dropdown_2 | expected_search_box | expected_table_col_1  | expected_table_col_2 | expected_table_col_3 | expected_table_col_4 | expected_table_col_5   |
                  | MANAGER_BASE_URL  | Add Customer | Add Customer Page   | Add Customer    | First Name       | Last Name        | Post Code        |                     |                     |                     |                       |                      |                      |                      |                        |
                  | MANAGER_BASE_URL  | Open Account | Open Account Page   | Process         |                  |                  |                  | Customer dropdown   | Currency dropdown   |                     |                       |                      |                      |                      |                        |
                  | MANAGER_BASE_URL  | Customers    | Customers List Page | Delete Customer |                  |                  |                  |                     |                     | Search Customer     | First Name (sortable) | Last Name (sortable) | Post Code (sortable) | Account Number       | Delete Customer button |


        @Sanity @Regression @gui
        Scenario Outline: Navigation back to Bank Manager page
            Given the user is on <manager_main_page>
              And the user is on <current_page>
             When the user clicks on the "Home" button
             Then the Bank <main_page> page should be displayed
        Examples:
                  | manager_main_page | current_page | main_page |
                  | MANAGER_BASE_URL  | /addCust     | BASE_URL  |
                  | MANAGER_BASE_URL  | /openAccount | BASE_URL  |
                  | MANAGER_BASE_URL  | /list        | BASE_URL  |
