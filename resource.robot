*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${SERVER}         localhost:7272
${BROWSER}        Chrome
${REGISTER URL}    http://${SERVER}/Form.html
${SUCCESS URL}    http://${SERVER}/Complete.html
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}chrome-mac-x64${/}Google Chrome for Testing.app${/}Contents${/}MacOS${/}Google Chrome for Testing
${CHROME_DRIVER_PATH}    ${EXECDIR}${/}chromedriver-mac-x64${/}chromedriver
${VALID FIRSTNAME}    Somsong
${VALID LASTNAME}    Sandee
${VALID DESTINATION}    Europe
${VALID CONTACT_PERSON}    Sodsai Sandee
${VALID RELATIONSHIP}    Mother
${VALID EMAIL}    somsong@kkumail.com
${INVALID EMAIL}    somsong@
${VALID PHONENUMBER}    081-111-1234
${INVALID PHONENUMBER}    191
${DESTINATION ERROR MESSAGE}    Please enter your destination.
${EMAIL ERROR MESSAGE}    Please enter a valid email address.
${EMPTY PHONENUMBER ERROR MESSAGE}    Please enter a phone number.
${INVALID PHONENUMBER ERROR MESSAGE}    Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678)

*** Keywords ***
Open Form
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${chrome_options.binary_location}     Set Variable       ${CHROME_BROWSER_PATH}
    ${service}   Evaluate   sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")
    # [selenium >= 4.10] `chrome_options` change to `options`
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
	Open Browser    ${REGISTER URL}    ${BROWSER}
	Location Should Be    ${REGISTER URL}

Input Inquiry Form
    [Arguments]    ${firstname}    ${lastname}    ${destination}    ${contactperson}    ${relationship}    ${email}    ${phone}
	Input Text    firstname    ${firstname}
	Input Text    lastname    ${lastname}
	Input Text    destination    ${destination}
	Input Text    contactperson    ${contactperson}
	Input Text    relationship    ${relationship}
	Input Text    email    ${email}
	Input Text    phone    ${phone}
    Click Button    submitButton
