*** Settings ***
Suite Setup       Login user suite setup
Suite Teardown    Close All Browsers
Test Teardown     Login user test teardown
Force Tags        User Administration
Resource          Resources/UserAdministration.robot

*** Variables ***
&{UserWithCredentialMissmatch}    name=${ValidUser1.name}    email=${ValidUser1.email}    password=${ValidUser2.password}    passwordRepeat=${ValidUser2.passwordRepeat}
&{UserWithEmptyPassword}    name=${ValidUser1.name}    email=${ValidUser1.email}    password=    passwordRepeat=
&{UserWithEmptyUsername}    name=${ValidUser2.name}    email=    password=${ValidUser2.password}    passwordRepeat=${ValidUser2.passwordRepeat}
&{UnRegisteredUser}    name=Unregistered user    email=abcdefgh@seznam.cz    password=aaaaaaaa    passwordRepeat=aaaaaaaa
${LoginFormId}    frm-loginForm

*** Test Cases ***
[1.2.1] Login as valid user 1
     Given login page is opened
     When login user as "${ValidUser1}"
     Then user is logged in as "${ValidUser1}"

[1.2.2] Login as valid user 2
     Given login page is opened
     When login user as "${ValidUser2}"
     Then user is logged in as "${ValidUser2}"

[1.2.3] Login as unregistered user
     Given login page is opened
     When login user as "${UnRegisteredUser}"
     Then error is displayed on form with id "${LoginFormId}"

[1.2.4] Login with empty username and filled password
     Given login page is opened
     When login user as "${UserWithEmptyUsername}"
     Then error is displayed on field "email" in form "${LoginFormId}"

[1.2.5] Login with valid username and empty password
     Given login page is opened
     When login user as "${UserWithEmptyPassword}"
     Then error is displayed on field "password" in form "${LoginFormId}"

[1.2.6] Login with unmatching username and password
     Given login page is opened
     When login user as "${UserWithCredentialMissmatch}"
     Then error is displayed on form with id "${LoginFormId}"

*** Keywords ***
Login user suite setup
    Delete all users
    Open Browser    ${BaseUrl}${Urls.home}    ${Browser}
    Sign up user "${ValidUser1}"
    Logout user
    Sign up user "${ValidUser2}"
    Logout user

Login user test teardown
    Logout user

Login user suite teardown
    Logout user
    Close All Browsers

Login user as "${user}"
    Input text    css=input[type="email"][name="email"]    ${user.email}
    Input text    css=input[type="password"][name="password"]    ${user.password}
    Confirm standard form

User is logged in as "${user}"
    Page should contain element    css=#headerUserLink > span.name    with text    ${user.name}

Login page is opened
    Go To    ${BaseUrl}${Urls.login}
