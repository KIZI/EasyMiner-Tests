*** Settings ***
Resource          Common.robot
Resource          DatasetUpload.robot

*** Variables ***
${NewMinerFormId}    frm-newMinerForm
${MinerPageUrl}    /easyminercenter/em/data/open-miner/1
${NewAtributeFormId}    frm-newAttributeForm
${NewAttributeIframeSelector}   css=iframe[src*="/attributes/add-attribute"]
*** Keywords ***
Miner page is opened
    Go to    ${BaseUrl}${MinerPageUrl}
    Wait until miner is ready   

Wait until miner is ready
    Wait Until Element Is Not Visible   css=#overlay

Column names are simplified
    Set column name to "${TitanicDatasetFieldsSimplified[0]}" for column number "0"
    Set column name to "${TitanicDatasetFieldsSimplified[2]}" for column number "2"

Dataset upload column configuration page is opened
    Dataset upload page is opened
    Dataset "titanic-comma.csv" is uploaded
    Datasource name is set to "${TitanicDatasourceName}"
    Separator "," is selected
    Confirm standard form with id "${UploadFileConfigFormId}"

Set column name to "${columnName}" for column number "${columnNumber}"
    Clear element text    css=#column_${columnNumber}_name
    Input text    css=#column_${columnNumber}_name    ${columnName}

Correct column datatypes are selected
    Select column type as "${ColumnTypeNominal}" for column number "0"
    Select column type as "${ColumnTypeNumerical}" for column number "1"
    Select column type as "${ColumnTypeNominal}" for column number "2"
    Select column type as "${ColumnTypeNumerical}" for column number "3"
    Select column type as "${ColumnTypeNominal}" for column number "4"
    Select column type as "${ColumnTypeNominal}" for column number "5"
    Select column type as "${ColumnTypeNominal}" for column number "6"

Select column type as "${columnType}" for column number "${columnNumber}"
    Select from list by value    css=#column_${columnNumber}_type    ${columnType}
    Focus    css=#${ConfigureColumnsFormId}

Column configuration form is submitted
    Confirm standard form with id "${ConfigureColumnsFormId}"

Datasource name is set to "${datasourceName}"
    Clear element text    css=#${UploadFileConfigFormId}-name
    Input text    css=#${UploadFileConfigFormId}-name    ${datasourceName}

Set attribute name to "${attributeName}"
    Clear element text    css=#${NewAtributeFormId}-attributeName
    Input text    css=#${NewAtributeFormId}-attributeName    ${attributeName}
    Iframe confirm standard form with id "${NewAtributeFormId}"     
    Unselect frame

New miner with name "${minerName}" is created
    Wait until page contains element    css=#${NewMinerFormId}-name    60s
    Clear element text    css=#${NewMinerFormId}-name
    Input text    css=#${NewMinerFormId}-name    ${minerName}
    Confirm standard form with id "${NewMinerFormId}"
    Wait until page contains element    xpath=//*[@id="kb-ruleset"][contains(string(),"${minerName}")]    60s

Create attribute from "${datafieldName}" datafield    
    ${datafieldName} =    Convert to lowercase    ${datafieldName}
    Wait until page contains element    css=#field-checkbox-${datafieldName}
    Select checkbox     css=#field-checkbox-${datafieldName}
    Click element    css=#add-selected-data-fields

Select "${datafieldName}" datafield
    ${datafieldName} =    Convert to lowercase    ${datafieldName}
    Wait until page contains element    css=#field-checkbox-${datafieldName}
    Select checkbox     css=#field-checkbox-${datafieldName}

Attributes are created from all dataset fields
    Wait until page contains element    css=#data-fields span[title="${TitanicDatasetFieldsSimplified[0]}"]
    Wait for element and click  css=#data-fields a[class="selectable"]
    Sleep   2s
    : FOR    ${datafieldName}    IN    @{TitanicDatasetFieldsSimplified}
    \   Select "${datafieldName}" datafield
    Add selected datafields to attributes
    Select each value one bin preprocessing

Add selected datafields to attributes
    Wait for element and click    css=#add-selected-data-fields

Miner has "${attributeName}" attribute
    ${attributeName} =    Convert to lowercase    ${attributeName}
    Page should contain element    css=#attribute-nav-${attributeName}[title="${attributeName}"]
    Page should contain element    css=#attribute-add-${attributeName}
    Page should contain element    css=#attribute-remove-${attributeName}

Select each value one bin preprocessing
    Wait until page contains element    ${NewAttributeIframeSelector}
    Select frame    ${NewAttributeIframeSelector}
    IFrame click on element "css=a[href*="type=eachOne"]"
    Wait until page does not contain element     ${NewAttributeIframeSelector}   25s
    Unselect frame

Attributes derived from fields are available in attributes section
    : FOR    ${datafieldName}    IN    @{TitanicDatasetFieldsSimplified}
    \    ${datafieldName} =    Convert to lowercase    ${datafieldName}
    \    Miner has "${datafieldName}" attribute

Attribute creation suite setup
    Dataset upload suite setup
    Dataset upload column configuration page is opened
    Column names are simplified
    Correct column datatypes are selected
    Column configuration form is submitted
    New miner with name "titanic-miner-test-123" is created

Rule pattern suite setup
    Attribute creation suite setup
    Miner page is opened
    Attributes are created from all dataset fields
    Attributes derived from fields are available in attributes section

Mining process suite teardown
    Dataset upload suite teardown