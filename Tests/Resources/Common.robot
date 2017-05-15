*** Settings ***
Library           Selenium2Library
Library           Process
Variables         variables.py

*** Variables ***
${Browser}        ff
&{Urls}           newMiner=/easyminercenter/em/data/upload    register=/easyminercenter/em/user/register    home=/easyminercenter/    login=/easyminercenter/em/user/login    upload=/easyminercenter/em/data/upload    logout=/easyminercenter/em/user/logout
${ImplicitWait}    10s
&{ValidUser1}     name=Valid UserOne    email=valid.user1@gmail.com    password=Aaaaaa    passwordRepeat=Aaaaaa

*** Keywords ***
Confirm standard form
    Click Element    css=input[name="_submit"][class~="button"]

Delete all users
    ${result}=    Run Process    /Tests/Resources/delete-all-users.sh    stdout=${TEMPDIR}/stdout.txt    stderr=${TEMPDIR}/stderr.txt    timeout=10s    shell=True
    Log Many    stdout: ${result.stdout}    stderr: ${result.stderr}

error is displayed on element with id "${elementId}"
    page should contain element    css=input[id="${elementId}"][class~="has-error"]
    page should contain element    css=span[id="${elementId}_message"][class~="error-message"]

error is displayed on form with id "${formId}"
    page should contain element    css=form[id="${formId}"] .error

error is displayed on field "${fieldName}" in form "${formId}"
    page should contain element    css=input[id="${formId}-${fieldName}"][class~="has-error"]
    page should contain element    css=span[id="${formId}-${fieldName}_message"][class~="error-message"]

valid user is already registered
    sign up page is opened
    register user as "${ValidUser1}"
    logout user

sign up page is opened
    Go To    ${BaseUrl}${Urls.register}

sign up user "${user}"
    sign up page is opened
    register user as "${user}"

register user as "${user}"
    Input Text    css=input[type="text"][name="name"]    ${user.name}
    Input Text    css=input[type="text"][name="email"]    ${user.email}
    Input Text    css=input[type="password"][name="password"]    ${user.password}
    Input Text    css=input[type="password"][name="rePassword"]    ${user.passwordRepeat}
    Confirm standard form

server error page is displayed
    page should contain element    css=div.errorCode    with text    500

logout user
    Go To    ${BaseUrl}${Urls.logout}
