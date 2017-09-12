*** Settings ***
Suite Setup       Dataset upload suite setup
Suite Teardown    Dataset upload suite teardown
Force Tags        Dataset upload
Resource          Resources/DatasetUpload.robot

*** Variables ***
@{NewColumnNames}    New attribute name 0    New attribute name 1    New attribute name 2    New attribute name 3    New attribute name 4    New attribute name 5    New attribute name 6
@{ColumnNumbersToIgnore}    1    3    4    6
@{NotIgnoredColumnNames}    New attribute name 0    New attribute name 2    New attribute name 5
@{IgnoredColumnNames}    New attribute name 1    New attribute name 3    New attribute name 4    New attribute name 6
#${MinerPageUrl}    /easyminercenter/em/data/open-miner/1
#${NewAtributeFormId}    frm-newAttributeForm
#${NewAttributeIframeSelector}   css=iframe[src*="/attributes/add-attribute"]
*** Test Cases ***
[2.2.1] Configure dataset columns - type options
     Given titanic dataset upload column configuration page is opened
     When correct column datatypes are selected
     And column configuration form is submitted
     Then create new miner page for datasource with name "${TitanicDatasourceName}" is shown

[2.2.2] Configure dataset columns - rename columns
     Given titanic dataset upload column configuration page is opened
     When column names are renamed
     And column configuration form is submitted
     And new miner with name "titanic-test-2.2.2" is created
     Then miner should have datafields with following names    @{NewColumnNames}

[2.2.3] Configure dataset columns - set column type as ignored
     Given titanic dataset upload column configuration page is opened
     When column names are renamed
     And ignoring columns with following numbers    @{ColumnNumbersToIgnore}
     And column configuration form is submitted
     And new miner with name "titanic-test-2.2.3" is created
     Then miner should only contain not ignored datafields

*** Keywords ***
Titanic dataset upload column configuration page is opened
    Dataset upload page is opened
    Dataset "titanic-comma.csv" is uploaded
    Datasource name is set to "${TitanicDatasourceName}"
    Separator "," is selected
    Confirm standard form with id "${UploadFileConfigFormId}"

Correct column datatypes are selected
    Select column type as "${ColumnTypeNominal}" for column number "0"
    Select column type as "${ColumnTypeNumerical}" for column number "1"
    Select column type as "${ColumnTypeNominal}" for column number "2"
    Select column type as "${ColumnTypeNumerical}" for column number "3"
    Select column type as "${ColumnTypeNominal}" for column number "4"
    Select column type as "${ColumnTypeNominal}" for column number "5"
    Select column type as "${ColumnTypeNominal}" for column number "6"

Select column type as "${columnType}" for column number "${columnNumber}"
    Select From List By Value    css=#column_${columnNumber}_type    ${columnType}
    Focus    css=#${ConfigureColumnsFormId}

Column configuration form is submitted
    Confirm standard form with id "${ConfigureColumnsFormId}"

Create new miner page for datasource with name "${datasourceName}" is shown
    Wait Until Page Contains Element    css=input[name="datasourceName"][value~="${datasourceName}"]    20s
    page should contain element    css=input[name="datasourceName"][value~="${datasourceName}"]

Datasource name is set to "${datasourceName}"
    Wait Until Page Contains Element    css=#${UploadFileConfigFormId}-name     20s
    Clear Element Text    css=#${UploadFileConfigFormId}-name
    Input text    css=#${UploadFileConfigFormId}-name    ${datasourceName}

Column names are renamed
    : FOR    ${columnIndex}    IN RANGE    0    7
    \    set column name to "${NewColumnNames[${columnIndex}]}" for column number "${columnIndex}"

Set column name to "${columnName}" for column number "${columnNumber}"
    Clear Element Text    css=#column_${columnNumber}_name
    Input text    css=#column_${columnNumber}_name    ${columnName}

New miner with name "${minerName}" is created
    Wait Until Page Contains Element    css=#${NewMinerFormId}-name    20s
    Clear Element Text    css=#${NewMinerFormId}-name
    Input text    css=#${NewMinerFormId}-name    ${minerName}
    Confirm standard form with id "${NewMinerFormId}"

Miner should have datafields with following names
    [Arguments]    @{datasetFields}
    Wait Until Page Contains Element    css=#kb-ruleset    20s
    ${datasetLenght} =    Get Length    ${datasetFields}
    : FOR    ${columnIndex}    IN RANGE    0    ${datasetLenght}
    \    Page should contain element    css=#data-fields li span[title="${datasetFields[${columnIndex}]}"]    with text    ${datasetFields[${columnIndex}]}

Miner should not have datafields with following names
    [Arguments]    @{datasetFields}
    Wait Until Page Contains Element    css=#kb-ruleset    20s
    ${datasetLenght} =    Get Length    ${datasetFields}
    : FOR    ${columnIndex}    IN RANGE    0    ${datasetLenght}
    \    Page should not contain element    css=#data-fields li span[title="${datasetFields[${columnIndex}]}"]    with text    ${datasetFields[${columnIndex}]}

Ignoring columns with following numbers
    [Arguments]    @{columnNumbers}
    : FOR    ${number}    IN    @{columnNumbers}
    \    Select column type as "${ColumnTypeIgnore}" for column number "${number}"

Miner should only contain not ignored datafields
    Wait Until Page Contains Element    css=#kb-ruleset    20s
    Miner should have datafields with following names    @{NotIgnoredColumnNames}
    Miner should not have datafields with following names    @{IgnoredColumnNames}