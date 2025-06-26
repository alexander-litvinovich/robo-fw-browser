*** Settings ***
Library    Browser
Library    OperatingSystem
Library    String

*** Keywords ***
I open the application
    New Browser    chromium    headless=false
    New Page    http://localhost:8000

I should see a "Sign in with Keycloak" button
    Wait For Elements State    text="Sign in with Keycloak"    visible    timeout=30s
    Get Text    text="Sign in with Keycloak"    ==    Sign in with Keycloak

I should see a button with text
    [Arguments]    ${button_text}
    Wait For Elements State    text="${button_text}"    visible    timeout=30s
    Get Text    text="${button_text}"    ==    ${button_text}

Wait For Url
    [Arguments]    ${url}    ${timeout}=30s
    Wait For Condition    url    ==    ${url}    timeout=${timeout}

Get Username From Env
    ${env_content}=    Get File    ${CURDIR}/../.env
    @{lines}=    Split To Lines    ${env_content}
    ${username}=    Set Variable    ${EMPTY}
    FOR    ${line}    IN    @{lines}
        ${trimmed_line}=    Strip String    ${line}
        ${is_username_line}=    Evaluate    "${trimmed_line}".startswith("USERNAME=")
        IF    ${is_username_line}
            @{parts}=    Split String    ${trimmed_line}    =    1
            ${username}=    Set Variable    ${parts}[1]
            BREAK
        END
    END
    [Return]    ${username}

Get Password From Env
    ${env_content}=    Get File    ${CURDIR}/../.env
    @{lines}=    Split To Lines    ${env_content}
    ${password}=    Set Variable    ${EMPTY}
    FOR    ${line}    IN    @{lines}
        ${trimmed_line}=    Strip String    ${line}
        ${is_password_line}=    Evaluate    "${trimmed_line}".startswith("PASSWORD=")
        IF    ${is_password_line}
            @{parts}=    Split String    ${trimmed_line}    =    1
            ${password}=    Set Variable    ${parts}[1]
            BREAK
        END
    END
    [Return]    ${password}

Login
    # Find and click "Sign in with Keycloak" button
    Wait For Elements State    text="Sign in with Keycloak"    visible    timeout=30s
    Click    text="Sign in with Keycloak"
    
    # Wait until redirect (could be Okta or Keycloak)
    Wait For Condition    url    not contains    localhost:8000    timeout=30s
    
    # Find the username input and type username from .env
    Wait For Elements State    id=username    visible    timeout=30s
    ${username}=    Get Username From Env
    Fill Text    id=username    ${username}
         
    # Find and click the submit button
    # Wait For Elements State    button[type="submit"]    visible    timeout=30s
    Click    button[type="submit"]
    
    # Wait for being redirected to localhost:8000
    Wait For Url    http://localhost:8000    timeout=30s
    
    # Find the text "Home" on the page
    Wait For Elements State    text="Home"    visible    timeout=30s

I close the browser
    Close Browser
