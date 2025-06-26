*** Settings ***
Library    Browser
Resource   ../resources/browser_keywords.robot

Suite Setup    Initialize Browser
Suite Teardown    Close All Browsers

*** Keywords ***
Initialize Browser
    # Browser timeout will be set using page-level settings
    Log    Browser initialized

Close All Browsers
    Close Browser

*** Test Cases ***
Sign In Button Test
    Given I open the application
    When the page loads
    Then I should see a button with text    Sign in with Keycloak
    then Login
    And I close the browser

*** Keywords ***
the page loads
    Sleep    2s    # Wait for the page to fully load
