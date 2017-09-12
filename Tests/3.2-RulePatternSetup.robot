*** Settings ***
Suite Setup       Rule pattern suite setup
Suite Teardown    Mining process suite teardown
Force Tags        Mining process
Resource          Resources/MiningProcess.robot

*** Variables ***
@{AllAttributes}    isadultmale    age    class    fare    joined    job    survived
@{AntecedentAttributes}    isadultmale    age    class    fare    joined    job
@{ConsequentAttributes}    survived
${AntecedentSectionId}    antecedent
${ConsequentSectionId}    succedent
${InterestMeasuresSectionId}  interest-measures
@{RuleSectionIds}   
${AddInterestMeasureForm}   \#add-im-form
&{InterestMeasuresSelectValues}    Confidence=CONF    Support=SUPP    Rule length=RULE_LENGTH    Lift=LIFT
&{InterestMeasuresIds}    Confidence=im-conf    Support=im-supp    Rule length=im-rulelength    Lift=im-lift
${LiftThreshold}   1.2
${RuleLength}   6
@{AttributesToRemove}    age    class    fare
@{AttributesAfterRemove}    isadultmale    joined    job    survived

*** Test Cases ***
[3.2.1] Miner setup - Add antecedent
     Given titanic dataset miner page is opened
     When antecedent is created from attributes  @{AntecedentAttributes} 
     Then antecedent in rule pattern section contains following attributes   @{AntecedentAttributes}   

[3.2.2] Miner setup - Add consequent
     Given titanic dataset miner page is opened
     When consequent is created from attributes  @{ConsequentAttributes} 
     Then consequent in rule pattern section contains following attributes   @{ConsequentAttributes}     

[3.2.3] Miner setup - Add interest measures
    Given titanic dataset miner page is opened
    When add interest measures lift and rule length
    Then lift and rule length are shown in interest measure section  

[3.2.4] Miner setup - Remove antecedent
    Given titanic dataset miner has following antecedent attributes    @{AllAttributes}
    When antecedent atributtes are removed  @{AttributesToRemove} 
    Then antecedent in rule pattern section contains following attributes   @{AttributesAfterRemove}

[3.2.5] Miner setup - Remove consequent
    Given titanic dataset miner has following consequent attributes    @{AllAttributes}
    When consequent atributtes are removed  @{AttributesToRemove} 
    Then consequent in rule pattern section contains following attributes   @{AttributesAfterRemove}

[3.2.6] Miner setup - Remove interest measures
    Given titanic dataset miner page is opened
    When remove interest measures confidence and support
    Then interest measure section should not contain confidence and support measure
    
*** Keywords ***
Antecedent is created from attributes
    [Arguments]    @{attributes}
    Rule is created from attributes     antecedent    @{attributes}

Consequent is created from attributes
    [Arguments]    @{attributes}
    Rule is created from attributes     consequent   @{attributes}    

Rule is created from attributes
    [Arguments]    ${addOption}     @{attributes}
    Wait Until Page Contains Element    css=#attributes span[title="${attributes[0]}"]
    Wait for element and click  css=#attributes a[class="selectable"]
    : FOR    ${attribute}    IN    @{attributes}
    \   Select "${attribute}" attribute
    Add selected attributes
    Select add attribute to "${addOption}"    

Select "${attribute}" attribute
    Wait Until Element Is Enabled    css=#attribute-checkbox-${attribute}
    Select checkbox     css=#attribute-checkbox-${attribute}

Add selected attributes
    Wait for element and click  css=#add-selected-attributes

Select add attribute to "${addAttributeOption}"
    Wait Until Page Contains Element    css=#click-add-attribute-form
    Select From List By Value    css=#click-add-attribute-select    ${addAttributeOption}
    Click element     css=#click-add-attribute-form input[type="submit"]

Antecedent in rule pattern section contains following attributes
    [Arguments]    @{attributes}
    Rule pattern section contains following attributes  ${AntecedentSectionId}   @{attributes}

Consequent in rule pattern section contains following attributes
    [Arguments]    @{attributes}
    Rule pattern section contains following attributes  ${ConsequentSectionId}   @{attributes}

Rule pattern section contains following attributes
    [Arguments]    ${sectionName}   @{attributes}
    : FOR    ${attribute}    IN    @{attributes}
    \   page should contain element     xpath=//*[@id="${sectionName}"]//span[@class='field-name'][contains(string(),"${attribute}")]

Add interest measure "${interestMeasure}" with threshold "${threshold}"
    Wait for element and click    css=#${InterestMeasuresSectionId} #add-im
    Wait Until Page Contains Element    css=${AddInterestMeasureForm} #add-im-select
    ${selectValue} =    Get From Dictionary     ${InterestMeasuresSelectValues}   ${interestMeasure}
    Select From List By Value    css=#add-im-form #add-im-select    ${selectValue}
    Input Text    css=#add-im-form #add-im-threshold-value  ${threshold}
    Wait for element and click    css=${AddInterestMeasureForm} input[type="submit"]
    Wait Until Page Does Not Contain Element     css=${AddInterestMeasureForm} input[type="submit"]

Rule has interest measure "${interestMeasure}" with threshold "${threshold}"
    Page should contain element     xpath=//*[@id="${InterestMeasuresSectionId}"]//span[@class="name"][contains(string(),"${interestMeasure}")]
    Page should contain element     xpath=//*[@id="${InterestMeasuresSectionId}"]//span[@class="threshold"][contains(string(),"${threshold}")]

Add interest measures lift and rule length
    Add interest measure "Lift" with threshold "${LiftThreshold}"
    Add interest measure "Rule length" with threshold "${RuleLength}"

Lift and rule length are shown in interest measure section 
    Rule has interest measure "Lift" with threshold "${LiftThreshold}"
    Rule has interest measure "Rule length" with threshold "${RuleLength}"

Remove interest measures confidence and support
    Remove interest measure "Confidence"
    Remove interest measure "Support"

Remove interest measure "${interestMeasure}"
    ${measureId} =    Get From Dictionary     ${InterestMeasuresIds}   ${interestMeasure}
    Wait Until Page Contains Element    css=#${measureId}
    Mouse Over  css=#${measureId}
    Click Element  css=#${measureId} #${measureId}-remove

Interest measure section does not contain "${interestMeasure}"
    Page Should Not Contain Element    xpath=//*[@id="${InterestMeasuresSectionId}"]//span[@class="name"][contains(string(),"${interestMeasure}")] 

Interest measure section should not contain confidence and support measure
    Interest measure section does not contain "Confidence"
    Interest measure section does not contain "Support"

Titanic dataset miner has following antecedent attributes
    [Arguments]    @{attributes}
    Titanic dataset miner page is opened
    Antecedent is created from attributes  @{attributes} 
    Antecedent in rule pattern section contains following attributes   @{attributes} 

Titanic dataset miner has following consequent attributes
    [Arguments]    @{attributes}
    Titanic dataset miner page is opened
    Consequent is created from attributes  @{attributes} 
    Consequent in rule pattern section contains following attributes   @{attributes} 

Remove attribute "${attribute}" from consequent
    Remove attribute "${attribute}" from "${ConsequentSectionId}" rule section

Remove attribute "${attribute}" from antecedent
    Remove attribute "${attribute}" from "${AntecedentSectionId}" rule section

Remove attribute "${attribute}" from "${ruleSectionId}" rule section
    Wait Until Page Contains Element    xpath=//*[@id="${ruleSectionId}"]//*[@class='field-name'][contains(string(),"${attribute}")]
    Mouse Over  xpath=//*[@id="${ruleSectionId}"]//*[@class='field-name'][contains(string(),"${attribute}")]
    Click Element  xpath=//*[@id="${ruleSectionId}"]//*[@class='field-name'][contains(string(),"${attribute}")]//following::*[@class="controls"]/*[@class="remove-field"]

Antecedent atributtes are removed
    [Arguments]     @{attributes}
    : FOR    ${attribute}    IN    @{attributes}
    \   Remove attribute "${attribute}" from antecedent

Consequent atributtes are removed
    [Arguments]     @{attributes}
    : FOR    ${attribute}    IN    @{attributes}
    \   Remove attribute "${attribute}" from consequent

Rule pattern section does not contain following attributes
    [Arguments]    ${sectionName}   @{attributes}
    : FOR    ${attribute}    IN    @{attributes}
    \   Page should not contain element     xpath=//*[@id="${sectionName}"]//span[@class='field-name'][contains(string(),"${attribute}")]
