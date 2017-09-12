*** Settings ***
Library           Selenium2Library    10    10
Library           Process
Library           String
Library           Collections

*** Variables ***
${BaseUrl}        http://easyminer-frontend
${Browser}        ff
&{Urls}           newMiner=/easyminercenter/em/data/upload    register=/easyminercenter/em/user/register    home=/easyminercenter/    login=/easyminercenter/em/user/login    upload=/easyminercenter/em/data/upload    logout=/easyminercenter/em/user/logout
&{ValidUser1}     name=Valid UserOne    email=valid.user1@gmail.com    password=Aaaaaa    passwordRepeat=Aaaaaa

*** Keywords ***
Confirm standard form
    Wait for element and click   css=input[type="submit"]

Confirm standard form with id "${formId}"
    Wait for element and click   css=#${formId} input[type="submit"]

IFrame confirm standard form with id "${formId}" 
    Wait Until Element Is Enabled    css=#${formId} input[type="submit"]
    IFrame click on element "css=#${formId} input[type="submit"]"

Delete all users
    ${result}=    Run Process    /Tests/Resources/delete-all-users.sh    stdout=${TEMPDIR}/stdout.txt    stderr=${TEMPDIR}/stderr.txt    timeout=20s    shell=True
    Log Many    stdout: ${result.stdout}    stderr: ${result.stderr}

Error is displayed on element with id "${elementId}"
    Page should contain element    css=input[id="${elementId}"][class~="has-error"]
    Page should contain element    css=span[id="${elementId}_message"][class~="error-message"]

Error is displayed on form with id "${formId}"
    Page should contain element    css=form[id="${formId}"] .error

Error is displayed on field "${fieldName}" in form "${formId}"
    Page should contain element    css=input[id="${formId}-${fieldName}"][class~="has-error"]
    Page should contain element    css=span[id="${formId}-${fieldName}_message"][class~="error-message"]

Valid user is already registered
    Sign up page is opened
    Register user as "${ValidUser1}"
    Logout user

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
    Wait Until Page Does Not Contain Element     css=input[type="text"][name="email"]

Server error page is displayed
    Page should contain element    css=div.errorCode    with text    500

Logout user
    Go To    ${BaseUrl}${Urls.logout}

IFrame click on element "${elementSelector}"
    Press Key	${elementSelector}	\\13

Wait for element and click
    [Arguments]    ${elementSelector}
    Wait Until Element Is Enabled    ${elementSelector}
    Click element     ${elementSelector}