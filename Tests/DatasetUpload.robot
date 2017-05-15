*** Settings ***
Suite Setup       Dataset upload suite setup
Suite Teardown    Dataset upload suite teardown
Force Tags        Create new miner
Resource          Resources/CreateNewMiner.robot

*** Variables ***
@{TitanicDatasetFields}    Is_adult_male    Age    Class_Dept    Fare    Joined    Job    Survived
${TitanicDatasetFieldCount}    7

*** Test Cases ***
[2.1.1] Upload csv dataset - comma separated
    Given dataset upload page is opened
    When dataset "titanic-comma.csv" is uploaded
    Then dataset field headers should contain following fields    @{TitanicDatasetFields}
    And dataset field count should be "${TitanicDatasetFieldCount}"

[2.1.2] Upload csv dataset - semicolon separated
    Given dataset upload page is opened
    When dataset "titanic-semicolon.csv" is uploaded
    Then dataset field headers should contain following fields    @{TitanicDatasetFields}
    And dataset field count should be "${TitanicDatasetFieldCount}"

[2.1.3] Upload csv dataset - vertical line separated
    Given dataset upload page is opened
    When dataset "titanic-verticalLine.csv" is uploaded
    Then dataset field headers should contain following fields    @{TitanicDatasetFields}

[2.1.4] Upload csv dataset - tab separated
    Given dataset upload page is opened
    When dataset "titanic-tab.csv" is uploaded
    Then dataset field headers should contain following fields    @{TitanicDatasetFields}
    And dataset field count should be "${TitanicDatasetFieldCount}"

[2.1.4] Upload zip archive with csv dataset - comma separated
    Given dataset upload page is opened
    When dataset "titanic.zip" is uploaded
    Then dataset field headers should contain following fields    @{TitanicDatasetFields}
    And dataset field count should be "${TitanicDatasetFieldCount}"

*** Keywords ***
Dataset upload suite setup
    Set Selenium Implicit Wait    ${ImplicitWait}
    Delete all users
    Open Browser    ${BaseUrl}${Urls.home}    ${Browser}
    Sign up user "${ValidUser1}"

Dataset upload suite teardown
    Close Browser

dataset upload page is opened
    Go To    ${BaseUrl}${Urls.upload}

dataset field headers should contain following fields
    [Arguments]    @{datasetFields}
    : FOR    ${field}    IN    @{datasetFields}
    \    Table Header Should Contain    css=#uploadConfigPreviewBlock > table    ${field}

dataset "${datasetName}" is uploaded
    Choose File    css=#frm-uploadForm-file    /Tests/Resources/DatasetFiles/${datasetName}
    Confirm standard form

dataset field count should be "${datasetFieldCount}"
    Xpath Should Match X Times    //*[@id="uploadConfigPreviewBlock"]/table/tbody/tr/th    ${datasetFieldCount}