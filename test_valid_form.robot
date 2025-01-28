*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Form Page
Suite Teardown    Close All Browsers

*** Variables ***
${BASE_URL}          http://localhost:7272
${FORM_URL}          ${BASE_URL}/Form.html
${COMPLETE_URL}      ${BASE_URL}/Complete.html
${FIRST_NAME}        Somsong
${LAST_NAME}         Sandee
${DESTINATION}       Europe
${CONTACT_PERSON}    Sodsai Sandee
${RELATIONSHIP}      Mother
${EMAIL}             somsong@kkumail.com
${PHONE_NO}          081-111-1234
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

Submit Form With Valid Data
    [Documentation]   Test Case 2: Submit form with valid data and verify completion page.
    Input Text   id=firstname      ${FIRST_NAME}
    Input Text   id=lastname       ${LAST_NAME}
    Input Text   id=destination    ${DESTINATION}
    Input Text   id=contactperson  ${CONTACT_PERSON}
    Input Text   id=relationship   ${RELATIONSHIP}
    Input Text   id=email          ${EMAIL}
    Input Text   id=phone          ${PHONE_NO}
    Click Button   id=submitButton
    Location Should Contain    ${COMPLETE_URL}
    Wait Until Page Contains   Our agent will contact you shortly.
    Title Should Be   Completed
    Page Should Contain   Thank you for your patient.

*** Keywords ***
Open Browser To Form Page
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${chrome_options.binary_location}    Set Variable    ${CHROME_BROWSER_PATH}
    ${service}    Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
    Go To   ${FORM_URL}
    Maximize Browser Window