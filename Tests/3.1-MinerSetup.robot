*** Settings ***
Suite Setup       Miner setup suite setup
Suite Teardown    Miner setup suite teardown
Force Tags        Mining process
Resource          Resources/MiningProcess.robot
Resource          Resources/DatasetUpload.robot

*** Variables ***
${ConfigureColumnsFormId}    frm-uploadColumnsListForm
${ColumnTypeNominal}    nominal
${ColumnTypeNumerical}    numeric
${ColumnTypeIgnore}    null
${TitanicDatasourceName}    titanic-dataset-123
@{TitanicDatasetFieldsSimplified}    IsAdultMale    Age    Class    Fare    Joined    Job    Survived
${NewMinerFormId}    frm-newMinerForm
${MinerPageUrl}    /easyminercenter/em/data/open-miner/1
${NewAtributeFormId}    frm-newAttributeForm
${NewAttributeIframeSelector}   css=iframe[src*="/attributes/add-attribute"]

*** Test Cases ***
# TODO
# [3.1.1] Miner setup - Add attributes
#     Given titanic dataset miner page is opened
#     When atributtes are created from all dataset fields
#     Then attributes derived from fields are available in attributes section
    
*** Keywords ***
Miner setup suite setup
    Dataset upload suite setup
    titanic dataset upload column configuration page is opened
    column names are simplified
    correct column datatypes are selected
    column configuration form is submitted
    new miner with name "titanic-test-3.1" is created

Miner setup suite teardown
    Logout user
    Close All Browsers

titanic dataset miner page is opened
    Go To    ${BaseUrl}${MinerPageUrl}

column names are simplified
    set column name to "${TitanicDatasetFieldsSimplified[0]}" for column number "0"
    set column name to "${TitanicDatasetFieldsSimplified[2]}" for column number "2"

titanic dataset upload column configuration page is opened
    dataset upload page is opened
    dataset "titanic-comma.csv" is uploaded
    datasource name is set to "${TitanicDatasourceName}"
    separator "," is selected
    Confirm standard form with id "${UploadFileConfigFormId}"

set column name to "${columnName}" for column number "${columnNumber}"
    Clear Element Text    css=#column_${columnNumber}_name
    Input text    css=#column_${columnNumber}_name    ${columnName}

correct column datatypes are selected
    Select column type as "${ColumnTypeNominal}" for column number "0"
    Select column type as "${ColumnTypeNumerical}" for column number "1"
    Select column type as "${ColumnTypeNominal}" for column number "2"
    Select column type as "${ColumnTypeNumerical}" for column number "3"
    Select column type as "${ColumnTypeNominal}" for column number "4"
    Select column type as "${ColumnTypeNominal}" for column number "5"
    Select column type as "${ColumnTypeNominal}" for column number "6"

select column type as "${columnType}" for column number "${columnNumber}"
    Select From List By Value    css=#column_${columnNumber}_type    ${columnType}
    Focus    css=#${ConfigureColumnsFormId}

column configuration form is submitted
    Confirm standard form with id "${ConfigureColumnsFormId}"

datasource name is set to "${datasourceName}"
    Clear Element Text    css=#${UploadFileConfigFormId}-name
    Input text    css=#${UploadFileConfigFormId}-name    ${datasourceName}

set attribute name to "${attributeName}"
    Clear Element Text    css=#${NewAtributeFormId}-attributeName
    Input text    css=#${NewAtributeFormId}-attributeName    ${attributeName}
    Iframe confirm standard form with id "${NewAtributeFormId}"     
    Unselect frame

new miner with name "${minerName}" is created
    Wait Until Page Contains Element    css=#${NewMinerFormId}-name    20s
    Clear Element Text    css=#${NewMinerFormId}-name
    Input text    css=#${NewMinerFormId}-name    ${minerName}
    Confirm standard form with id "${NewMinerFormId}"
    Sleep   20s

create attribute from "${datafieldName}" datafield    
    ${datafieldName} =    Convert To Lowercase    ${datafieldName}
    Select checkbox     css=#field-checkbox-${datafieldName}
    Click element    css=#add-selected-data-fields

atributtes are created from all dataset fields
    Wait Until Page Contains Element    css=#data-fields span[title="${TitanicDatasetFieldsSimplified[0]}"]
    Click element   css=#data-fields a[title="Selectable"]
    : FOR    ${datafieldName}    IN    @{TitanicDatasetFieldsSimplified}
    \   create attribute from "${datafieldName}" datafield
    \   select each value one bin preprocessing

miner has "${attributeName}" attribute
    ${attributeName} =    Convert To Lowercase    ${attributeName}
    page should contain element    css=#attribute-nav-${attributeName}[title="${attributeName}"]
    page should contain element    css=#attribute-add-${attributeName}
    page should contain element    css=#attribute-remove-${attributeName}

attributes derived from fields are available in attributes section
    : FOR    ${datafieldName}    IN    @{TitanicDatasetFieldsSimplified}
    \    ${datafieldName} =    Convert To Lowercase    ${datafieldName}
    \    miner has "${datafieldName}" attribute
    Capture Page Screenshot

select each value one bin preprocessing
    Wait Until Page Contains Element    ${NewAttributeIframeSelector}
    Select frame    ${NewAttributeIframeSelector}
    IFrame click on element "css=a[href*="type=eachOne"]"
    Wait Until Page Does Not Contain Element     ${NewAttributeIframeSelector}   25s
    Unselect frame
    