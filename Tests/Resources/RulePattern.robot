*** Settings ***
Resource          Common.robot

*** Variables ***
@{AllAttributes}    isadultmale    age    class    fare    joined    job    survived
@{AntecedentAttributes}    isadultmale    age    class    fare    joined    job
@{ConsequentAttributes}    survived
${AntecedentSectionId}    antecedent
${ConsequentSectionId}    succedent
${InterestMeasuresSectionId}  interest-measures
${AddInterestMeasureForm}   \#add-im-form
&{InterestMeasuresSelectValues}    Confidence=CONF    Support=SUPP    Rule length=RULE_LENGTH    Lift=LIFT
&{InterestMeasuresIds}    Confidence=im-conf    Support=im-supp    Rule length=im-rulelength    Lift=im-lift
*** Keywords ***
Add interest measure "${interestMeasure}" with threshold "${threshold}"
    Wait for element and click    css=#${InterestMeasuresSectionId} #add-im
    Wait until page contains element    css=${AddInterestMeasureForm} #add-im-select
    ${selectValue} =    Get From Dictionary     ${InterestMeasuresSelectValues}   ${interestMeasure}
    Select from list by value    css=#add-im-form #add-im-select    ${selectValue}
    Input text    css=#add-im-form #add-im-threshold-value  ${threshold}
    Wait for element and click    css=${AddInterestMeasureForm} input[type="submit"]
    Wait until page does not contain element     css=${AddInterestMeasureForm} input[type="submit"]

Antecedent in rule pattern section contains following attributes
    [Arguments]    @{attributes}
    Rule pattern section contains following attributes  ${AntecedentSectionId}   @{attributes}

Consequent in rule pattern section contains following attributes
    [Arguments]    @{attributes}
    Rule pattern section contains following attributes  ${ConsequentSectionId}   @{attributes}

Rule pattern section contains following attributes
    [Arguments]    ${sectionName}   @{attributes}
    : FOR    ${attribute}    IN    @{attributes}
    \   Page should contain element     xpath=//*[@id="${sectionName}"]//span[@class='field-name'][contains(string(),"${attribute}")]

Rule has interest measure "${interestMeasure}" with threshold "${threshold}"
    Page should contain element     xpath=//*[@id="${InterestMeasuresSectionId}"]//span[@class="name"][contains(string(),"${interestMeasure}")]
    Page should contain element     xpath=//*[@id="${InterestMeasuresSectionId}"]//span[@class="threshold"][contains(string(),"${threshold}")]

Antecedent is created from attributes
    [Arguments]    @{attributes}
    Rule is created from attributes     antecedent    @{attributes}

Consequent is created from attributes
    [Arguments]    @{attributes}
    Rule is created from attributes     consequent   @{attributes}    

Toggle attribute selectable
    Wait until miner is ready
    Wait for element and click  css=#attributes a[class="selectable"]
    Sleep   2s

Rule is created from attributes
    [Arguments]    ${addOption}     @{attributes}
    Toggle attribute selectable
    : FOR    ${attribute}    IN    @{attributes}
    \   Select "${attribute}" attribute
    Add selected attributes
    Select add attribute to "${addOption}"  
    Toggle attribute selectable  

Select "${attribute}" attribute
    Wait for element and click  css=#attribute-checkbox-${attribute}

Add selected attributes
    Wait for element and click  css=#add-selected-attributes

Select add attribute to "${addAttributeOption}"
    Wait until page contains element    css=#click-add-attribute-form
    Select from list by value    css=#click-add-attribute-select    ${addAttributeOption}
    Click element     css=#click-add-attribute-form input[type="submit"]

Remove attribute "${attribute}" from consequent
    Remove attribute "${attribute}" from "${ConsequentSectionId}" rule section

Remove attribute "${attribute}" from antecedent
    Remove attribute "${attribute}" from "${AntecedentSectionId}" rule section

Remove attribute "${attribute}" from "${ruleSectionId}" rule section
    Wait until page contains element    xpath=//*[@id="${ruleSectionId}"]//*[@class='field-name'][contains(string(),"${attribute}")]
    Mouse over  xpath=//*[@id="${ruleSectionId}"]//*[@class='field-name'][contains(string(),"${attribute}")]
    Click element  xpath=//*[@id="${ruleSectionId}"]//*[@class='field-name'][contains(string(),"${attribute}")]//following::*[@class="controls"]/*[@class="remove-field"]

Remove interest measure "${interestMeasure}"
    ${measureId} =    Get From Dictionary     ${InterestMeasuresIds}   ${interestMeasure}
    Wait until page contains element    css=#${measureId}
    Mouse over  css=#${measureId}
    Click element  css=#${measureId} #${measureId}-remove 

Interest measure section does not contain "${interestMeasure}"
    Page should not contain element    xpath=//*[@id="${InterestMeasuresSectionId}"]//span[@class="name"][contains(string(),"${interestMeasure}")] 

