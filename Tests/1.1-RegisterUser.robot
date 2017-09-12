*** Settings ***
Suite Setup       Register user suite setup
Suite Teardown    Close All Browsers
Test Setup        Register user test setup
Test Teardown     Register user test teardown
Force Tags        User administration
Resource          Resources/UserAdministration.robot

*** Variables ***
${RegisterFormId}    frm-registrationForm

*** Test Cases ***
[1.1.1] Register valid user
     Given sign up page is opened
     When register user as "${ValidUser1}"
     Then create new miner page is displayed

[1.1.2] Register invalid user with empty name
     Given sign up page is opened
     When register user as "${InvalidUserEmptyName}"
     Then error is displayed on field "name" in form "${RegisterFormId}"

[1.1.3] Register invalid user with empty email
     Given sign up page is opened
     When register user as "${InvalidUserEmptyEmail}"
     Then error is displayed on field "email" in form "${RegisterFormId}"

[1.1.4] Register invalid user with empty password
     Given sign up page is opened
     When register user as "${InvalidUserEmptyPassword}"
     Then error is displayed on field "password" in form "${RegisterFormId}"

[1.1.5] Register invalid user with empty repeated password
     Given sign up page is opened
     When register user as "${InvalidUserEmptyPasswordRepeat}"
     Then error is displayed on field "rePassword" in form "${RegisterFormId}"

[1.1.6] Register invalid user with unmatching passwords
     Given sign up page is opened
     When register user as "${InvalidUserUnmatchingPasswords}"
     Then error is displayed on field "rePassword" in form "${RegisterFormId}"

[1.1.7] Register invalid user with short password
     Given sign up page is opened
     When register user as "${InvalidUserShortPasswords}"
     Then error is displayed on field "password" in form "${RegisterFormId}"

[1.1.8] Register user that is already registered
     Given valid user is already registered
     And sign up page is opened
     When register user as "${ValidUser1}"
     Then error is displayed on form with id "${RegisterFormId}"

*** Keywords ***
Register user suite setup
    Delete all users
    Open Browser    ${BaseUrl}${Urls.home}    ${Browser}

Register user test setup
    Delete all users
    Go To    ${BaseUrl}${Urls.home}

Register user test teardown
    Logout user

Create new miner page is displayed
    Page should contain element    css=a[href="${Urls.upload}"]
