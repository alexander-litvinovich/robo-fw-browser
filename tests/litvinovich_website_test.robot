*** Settings ***
Library    Browser
Resource   ../resources/browser_keywords.robot

Suite Setup    Initialize Browser For Litvinovich Test
Suite Teardown    Close All Browsers

*** Keywords ***
Initialize Browser For Litvinovich Test
    Log    Browser initialized for Litvinovich website test

Close All Browsers
    Close Browser

*** Test Cases ***
Litvinovich Website Functionality Test
    [Documentation]    Test that verifies https://litvinovich.dev is working, contains "Saša" text, then navigates to 404 page and performs keyboard interactions
    [Tags]    gherkin    website    functional    keyboard    404
    Given I open the website    https://litvinovich.dev
    When the page loads successfully
    Then the website should be working
    And the website should contain text    Saša
    And Go To    https://litvinovich.dev/404page
    When the page loads successfully
    Then I perform keyboard sequence q-w-w
    And I close the browser

*** Keywords ***
# Given Steps
I open the website
    [Arguments]    ${url}
    [Documentation]    Opens URL in a new browser
    New Browser    chromium    headless=false
    New Page    ${url}

# When Steps  
the page loads successfully
    [Documentation]    Waits for the page to fully load
    Wait For Elements State    body    visible    timeout=30s
    Sleep    2s    # Additional wait to ensure full rendering

# Then Steps
the website should be working
    [Documentation]    Verifies the website is working by checking page title and basic elements
    # Check that the page has loaded and has a title
    ${title}=    Get Title
    Should Not Be Empty    ${title}
    Log    Page title: ${title}
    
    # Check that the page has some content (body should not be empty)
    ${body_text}=    Get Text    body
    Should Not Be Empty    ${body_text}
    Log    Website is working - page has title and content

the website should contain text
    [Arguments]    ${expected_text}
    [Documentation]    Verifies that the page contains the specified text
    ${page_content}=    Get Text    body
    Should Contain    ${page_content}    ${expected_text}    ignore_case=True
    Log    Successfully found "${expected_text}" text on the page

I perform keyboard sequence q-w-w
    [Documentation]    Performs the keyboard sequence: q (200ms) -> wait 50ms -> w (200ms) -> wait 50ms -> w (200ms)
    
    Keyboard Key    press    t
    Sleep    600ms
    Keyboard Key    up    t
    
    Sleep    200ms
    
    Keyboard Key    press    e
    Sleep    700ms
    Keyboard Key    up    e
    
    Sleep    200ms
    
    Keyboard Key    press    q
    Sleep    800ms
    Keyboard Key    up    q

I close the browser
    [Documentation]    Closes the browser
    Close Browser
