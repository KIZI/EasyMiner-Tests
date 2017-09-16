*** Settings ***
Resource          Common.robot

*** Variables ***
${ConfigureColumnsFormId}    frm-uploadColumnsListForm
${ColumnTypeNominal}    nominal
${ColumnTypeNumerical}    numeric
${ColumnTypeIgnore}    null
${TitanicDatasourceName}    titanic-dataset-123
@{TitanicDatasetFields}    Is adult male    Age    Class/Dept    Fare    Joined    Job    Survived
@{TitanicDatasetFieldsSimplified}    IsAdultMale    Age    Class    Fare    Joined    Job    Survived
${TitanicDatasetFieldCount}    7
${UploadFileFormId}    frm-uploadForm
${UploadFileConfigFormId}    frm-uploadConfigForm
${NewMinerFormId}    frm-newMinerForm

*** Keywords ***
Dataset upload suite setup "${user}"
    Open Browser    ${BaseUrl}${Urls.home}    ${Browser}
    Sign up user "${user}"
    Wait for user registration to complete

Logout and close browsers
    Logout user
    Close all browsers

Dataset upload page is opened
    Go To    ${BaseUrl}${Urls.upload}

Dataset "${datasetName}" is uploaded
    Choose file    css=#${UploadFileFormId}-file    /Tests/Resources/DatasetFiles/${datasetName}
    Confirm standard form with id "${UploadFileFormId}"

Separator "${separator}" is selected
    Wait until page contains element    css=#${UploadFileConfigFormId}-separator
    Select From List By Value    css=#${UploadFileConfigFormId}-separator    ${separator}
    Focus    css=#${UploadFileConfigFormId}-name