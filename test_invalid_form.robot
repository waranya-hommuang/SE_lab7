*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Form Page
Suite Teardown    Close All Browsers

*** Variables ***
${BASE_URL}          http://localhost:7272
${FORM_URL}          ${BASE_URL}/Form.html
${FIRST_NAME}        Somsong
${LAST_NAME}         Sandee
${DESTINATION}       Europe
${CONTACT_PERSON}    Sodsai Sandee
${RELATIONSHIP}      Mother
${EMAIL}             somsong@kkumail.com
${INVALID_EMAIL}     somsong@
${PHONE_NO}          081-111-1234
${INVALID_PHONE_NO}  191
${BROWSER}           Chrome
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome.exe
${CHROME_DRIVER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chromedriver.exe

*** Test Cases ***
Verify Form Page Display
    [Documentation]   Test Case 1: Verify that the form page is displayed correctly.
    Location Should Be   ${FORM_URL}
    Title Should Be   Customer Inquiry
    Page Should Contain Element   id=firstname
    Page Should Contain Element   id=lastname
    Page Should Contain Element   id=destination
    Page Should Contain Element   id=contactperson
    Page Should Contain Element   id=relationship
    Page Should Contain Element   id=email
    Page Should Contain Element   id=phone
    Page Should Contain Element   id=submitButton

Test Empty Destination
    [Documentation]   Test Case: Verify error when Destination is empty.
    Input Text   id=firstname      ${FIRST_NAME}
    Input Text   id=lastname       ${LAST_NAME}
    Input Text   id=contactperson  ${CONTACT_PERSON}
    Input Text   id=relationship   ${RELATIONSHIP}
    Input Text   id=email          ${EMAIL}
    Input Text   id=phone          ${PHONE_NO}
    Clear Element Text   id=destination
    Click Button   id=submitButton
    Page Should Contain   Please enter your destination.

Test Empty Email
    [Documentation]   Test Case: Verify error when Email is empty.
    Input Text   id=firstname      ${FIRST_NAME}
    Input Text   id=lastname       ${LAST_NAME}
    Input Text   id=destination    ${DESTINATION}
    Input Text   id=contactperson  ${CONTACT_PERSON}
    Input Text   id=relationship   ${RELATIONSHIP}
    Clear Element Text   id=email
    Input Text   id=phone          ${PHONE_NO}
    Click Button   id=submitButton
    Page Should Contain   Please enter a valid email address.

Test Invalid Email
    [Documentation]   Test Case: Verify error when Email is invalid.
    Input Text   id=firstname      ${FIRST_NAME}
    Input Text   id=lastname       ${LAST_NAME}
    Input Text   id=destination    ${DESTINATION}
    Input Text   id=contactperson  ${CONTACT_PERSON}
    Input Text   id=relationship   ${RELATIONSHIP}
    Input Text   id=email          ${INVALID_EMAIL}
    Input Text   id=phone          ${PHONE_NO}
    Click Button   id=submitButton
    Page Should Contain   Please enter a valid email address.

Test Empty Phone Number
    [Documentation]   Test Case: Verify error when Phone Number is empty.
    Input Text   id=firstname      ${FIRST_NAME}
    Input Text   id=lastname       ${LAST_NAME}
    Input Text   id=destination    ${DESTINATION}
    Input Text   id=contactperson  ${CONTACT_PERSON}
    Input Text   id=relationship   ${RELATIONSHIP}
    Input Text   id=email          ${EMAIL}
    Clear Element Text   id=phone
    Click Button   id=submitButton
    Page Should Contain   Please enter a phone number.

Test Invalid Phone Number
    [Documentation]   Test Case: Verify error when Phone Number is invalid.
    Input Text   id=firstname      ${FIRST_NAME}
    Input Text   id=lastname       ${LAST_NAME}
    Input Text   id=destination    ${DESTINATION}
    Input Text   id=contactperson  ${CONTACT_PERSON}
    Input Text   id=relationship   ${RELATIONSHIP}
    Input Text   id=email          ${EMAIL}
    Input Text   id=phone          ${INVALID_PHONE_NO}
    Click Button   id=submitButton
    Page Should Contain   Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678
    
*** Keywords ***
Open Browser To Form Page
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${chrome_options.binary_location}    Set Variable    ${CHROME_BROWSER_PATH}
    ${service}    Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
    Go To   ${FORM_URL}
    Maximize Browser Window
