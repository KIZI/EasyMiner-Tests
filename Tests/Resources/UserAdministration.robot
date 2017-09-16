*** Settings ***
Resource          Common.robot

*** Variables ***
&{InvalidUserEmptyName}    name=    email=invalid.user1@gmail.com    password=Aaaaaa    passwordRepeat=Aaaaaa
&{InvalidUserEmptyEmail}    name=Invalid UserTwo    email=    password=Aaaaaa    passwordRepeat=Aaaaaa
&{InvalidUserEmptyPassword}    name=Invalid UserThree    email=invalid.user3@gmail.com    password=    passwordRepeat=Aaaaaa
&{InvalidUserEmptyPasswordRepeat}    name=Invalid UserFour    email=invalid.user4@gmail.com    password=Aaaaaa    passwordRepeat=
&{InvalidUserUnmatchingPasswords}    name=Invalid UserFive    email=invalid.user5@gmail.com    password=Aaaaaa    passwordRepeat=AaaaaA
&{InvalidUserShortPasswords}    name=Invalid UserSix    email=invalid.user6@gmail.com    password=Aaaaa    passwordRepeat=Aaaaa
&{InvalidUserEmptyUsername}    name=Invalid UserSeven    email=    password=Aaaaaa   passwordRepeat=Aaaaaa
*** Keywords ***
