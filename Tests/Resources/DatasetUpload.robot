*** Settings ***
Resource          Common.robot

*** Variables ***
@{TitanicDatasetFields}    Is adult male    Age    Class/Dept    Fare    Joined    Job    Survived
${TitanicDatasetFieldCount}    7
${UploadFileFormId}    frm-uploadForm
${UploadFileConfigFormId}    frm-uploadConfigForm

*** Keywords ***
Dataset upload suite setup
    Delete all users
    Open Browser    ${BaseUrl}${Urls.home}    ${Browser}
    Sign up user "${ValidUser1}"

Dataset upload suite teardown
    Logout user
    Close All Browsers

dataset upload page is opened
    Go To    ${BaseUrl}${Urls.upload}

dataset "${datasetName}" is uploaded
    Choose File    css=#${UploadFileFormId}-file    /Tests/Resources/DatasetFiles/${datasetName}
    Confirm standard form with id "${UploadFileFormId}"

separator "${separator}" is selected
    Select From List By Value    css=#${UploadFileConfigFormId}-separator    ${separator}
    Focus    css=#${UploadFileConfigFormId}-name

Dataset upload test setup
   Go To    ${BaseUrl}${Urls.login}
   login user as "${ValidUser1}"
