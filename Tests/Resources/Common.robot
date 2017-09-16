*** Settings ***
Library           Selenium2Library    10    10
Library           Process
Library           String
Library           Collections

*** Variables ***
${BaseUrl}        http://easyminer-frontend
${Browser}        ff
&{Urls}           newMiner=/easyminercenter/em/data/upload    register=/easyminercenter/em/user/register    home=/easyminercenter/    login=/easyminercenter/em/user/login    upload=/easyminercenter/em/data/upload    logout=/easyminercenter/em/user/logout
&{User21}     name=Suite 21    email=valid.user21@gmail.com    password=Aaaaaa    passwordRepeat=Aaaaaa
&{User22}     name=Suite 22    email=valid.user22@gmail.com    password=Aaaaaa    passwordRepeat=Aaaaaa
&{User31}     name=Suite 31    email=valid.user31@gmail.com    password=Aaaaaa    passwordRepeat=Aaaaaa
&{User32}     name=Suite 32    email=valid.user32@gmail.com    password=Aaaaaa    passwordRepeat=Aaaaaa
&{User33}     name=Suite 33    email=valid.user33@gmail.com    password=Aaaaaa    passwordRepeat=Aaaaaa

*** Keywords ***
Confirm standard form
    Wait for element and click   css=input[type="submit"]

Confirm standard form with id "${formId}"
    Wait for element and click   css=#${formId} input[type="submit"]

IFrame confirm standard form with id "${formId}" 
    Wait until element is visible    css=#${formId} input[type="submit"]
    Wait until element is enabled    css=#${formId} input[type="submit"]
    IFrame click on element "css=#${formId} input[type="submit"]"

Error is displayed on element with id "${elementId}"
    Page should contain element    css=input[id="${elementId}"][class~="has-error"]
    Page should contain element    css=span[id="${elementId}_message"][class~="error-message"]

Error is displayed on form with id "${formId}"
    Page should contain element    css=form[id="${formId}"] .error

Error is displayed on field "${fieldName}" in form "${formId}"
    Page should contain element    css=input[id="${formId}-${fieldName}"][class~="has-error"]
    Page should contain element    css=span[id="${formId}-${fieldName}_message"][class~="error-message"]

Sign up page is opened
    Go To    ${BaseUrl}${Urls.register}

Sign up user "${user}"
    Sign up page is opened
    Register user as "${user}"

Register user as "${user}"
    Input Text    css=input[type="text"][name="name"]    ${user.name}
    Input Text    css=input[type="text"][name="email"]    ${user.email}
    Input Text    css=input[type="password"][name="password"]    ${user.password}
    Input Text    css=input[type="password"][name="rePassword"]    ${user.passwordRepeat}
    Confirm standard form

Wait for user registration to complete
    Wait until page does not contain element     css=input[type="text"][name="email"]

Server error page is displayed
    Page should contain element    css=div.errorCode    with text    500

Logout user
    Go To    ${BaseUrl}${Urls.logout}

IFrame click on element "${elementSelector}"
    Press Key	${elementSelector}	\\13

Wait for element and click
    [Arguments]    ${elementSelector}
    Wait until element is visible    ${elementSelector}
    Wait until element is enabled    ${elementSelector}
    Click element     ${elementSelector}