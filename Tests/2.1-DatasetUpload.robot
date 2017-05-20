*** Settings ***
Suite Setup       Dataset upload suite setup
Suite Teardown    Dataset upload suite teardown
Force Tags        Create new miner
Resource          Resources/CreateNewMiner.robot

*** Variables ***
@{TitanicDatasetFields}    Is_adult_male    Age    Class_Dept    Fare    Joined    Job    Survived
${TitanicDatasetFieldCount}    7
${UploadFileFormId}    frm-uploadForm
${UploadFileConfigFormId}    frm-uploadConfigForm

*** Test Cases ***
[2.1.1] Upload csv dataset - comma separated
    Given dataset upload page is opened
    When dataset "titanic-comma.csv" is uploaded
    And separator "," is selected
    Then dataset field count should be "${TitanicDatasetFieldCount}"
    And dataset field headers should contain following fields    @{TitanicDatasetFields}

[2.1.2] Upload csv dataset - semicolon separated
    Given dataset upload page is opened
    When dataset "titanic-semicolon.csv" is uploaded
    And separator ";" is selected
    Then dataset field count should be "${TitanicDatasetFieldCount}"
    And dataset field headers should contain following fields    @{TitanicDatasetFields}

[2.1.3] Upload csv dataset - vertical line separated
    Given dataset upload page is opened
    When dataset "titanic-verticalLine.csv" is uploaded
    And separator "|" is selected
    Then dataset field count should be "${TitanicDatasetFieldCount}"
    And dataset field headers should contain following fields    @{TitanicDatasetFields}

#[2.1.4] Upload csv dataset - tab separated
#    Given dataset upload page is opened
#    When dataset "titanic-tab.csv" is uploaded
#    And separator "\t" is selected
#    Then dataset field count should be "${TitanicDatasetFieldCount}"
#    And dataset field headers should contain following fields    @{TitanicDatasetFields}

[2.1.5] Upload zip archive with csv dataset - comma separated
    Given dataset upload page is opened
    When dataset "titanic.zip" is uploaded
    And separator "," is selected
    Then dataset field count should be "${TitanicDatasetFieldCount}"
    And dataset field headers should contain following fields    @{TitanicDatasetFields}

[2.1.6] Upload form submission without selecting file to upload
    Given dataset upload page is opened
    When upload form is submitted without selecting file to upload
    Then error is displayed on field "file" in form "${UploadFileFormId}"

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

dataset field headers should contain following fields
    [Arguments]    @{datasetFields}
    : FOR    ${field}    IN    @{datasetFields}
    \    Table Header Should Contain    css=#uploadConfigPreviewBlock > table    ${field}

dataset "${datasetName}" is uploaded
    Choose File    css=#${UploadFileFormId}-file    /Tests/Resources/DatasetFiles/${datasetName}
    Confirm standard form

dataset field count should be "${datasetFieldCount}"
    Wait Until Page Contains Element    //*[@id="uploadConfigPreviewBlock"]/table/tbody/tr[1]/th[${datasetFieldCount}]
    Xpath Should Match X Times    //*[@id="uploadConfigPreviewBlock"]/table/tbody/tr/th    ${datasetFieldCount}

separator "${separator}" is selected
    Select From List By Value    css=#${UploadFileConfigFormId}-separator    ${separator}
    Focus    css=#${UploadFileConfigFormId}-name

upload form is submitted without selecting file to upload
    Confirm standard form
