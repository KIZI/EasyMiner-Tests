*** Settings ***
Suite Setup       Suite setup
Suite Teardown    Logout and close browsers
Force Tags        DatasetUpload
Resource          Resources/DatasetUpload.robot

*** Variables ***

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

[2.1.4] Upload csv dataset - tab separated
       Given dataset upload page is opened
       When dataset "titanic-tab.csv" is uploaded
       And separator "\t" is selected
       Then dataset field count should be "${TitanicDatasetFieldCount}"
       And dataset field headers should contain following fields    @{TitanicDatasetFields}

[2.1.5] Upload zip archive with comma separated csv dataset
       Given dataset upload page is opened
       When dataset "titanic.zip" is uploaded
       And separator "," is selected
       Then dataset field count should be "${TitanicDatasetFieldCount}"
       And dataset field headers should contain following fields    @{TitanicDatasetFields}

[2.1.6] Upload form submission without selecting file to upload
       Given dataset upload page is opened
       When upload form is submitted without selecting file to upload
       Then error is displayed on field "file" in form "${UploadFileFormId}"

[2.1.7] Upload form submission - default column names
       Given configuration for "titanic-comma.csv" is opened
       When separator "," is selected
       And dataset configuration is submitted
       Then dataset column configuration page should appear with configuration for following fields    @{TitanicDatasetFields}

*** Keywords ***
Suite setup
      Dataset upload suite setup "${User21}"

Dataset field headers should contain following fields
    [Arguments]    @{datasetFields}
    : FOR    ${field}    IN    @{datasetFields}
    \    Table header should contain    css=#uploadConfigPreviewBlock table    ${field}

Dataset field count should be "${datasetFieldCount}"
    Wait until page contains element    //*[@id="uploadConfigPreviewBlock"]/table/tbody/tr[1]/th[${datasetFieldCount}]
    Xpath should match X times    //*[@id="uploadConfigPreviewBlock"]/table/tbody/tr/th    ${datasetFieldCount}

Upload form is submitted without selecting file to upload
    Confirm standard form

Dataset configuration is submitted
    Confirm standard form with id "${UploadFileConfigFormId}"

Configuration for "${datasetName}" is opened
    Dataset upload page is opened
    Dataset "${datasetName}" is uploaded

Dataset column configuration page should appear with configuration for following fields
    [Arguments]    @{datasetFields}
    Wait until page contains element    css=#column_0_name
    ${datasetLenght} =    Get length    ${datasetFields}
    : FOR    ${columnIndex}    IN RANGE    0    ${datasetLenght}
    \    ${columnIndexString} =    Convert to string    ${columnIndex}
    \    Page should contain element    css=#column_${columnIndexString}_name    with text    ${datasetFields[${columnIndex}]}
