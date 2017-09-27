*** Settings ***
Suite Setup       Suite setup
Suite Teardown    Logout and close browsers
Force Tags        MiningProcess
Resource          Resources/MiningProcess.robot
Resource          Resources/RulePattern.robot

*** Variables ***
${Miner}    titanic-3.2
${LiftThreshold}   1.2
${RuleLength}   6
@{AttributesToRemove}    age    class    fare
@{AttributesAfterRemove}    isadultmale    joined    job    survived

*** Test Cases ***
[3.2.1] Add antecedent
      Given miner "${Miner}" page is opened
      When antecedent is created from attributes  @{AntecedentAttributes} 
      Then antecedent in rule pattern section contains following attributes   @{AntecedentAttributes}   

[3.2.2] Add consequent
      Given miner "${Miner}" page is opened
      When consequent is created from attributes  @{ConsequentAttributes} 
      Then consequent in rule pattern section contains following attributes   @{ConsequentAttributes}     

[3.2.3] Add interest measures
     Given miner "${Miner}" page is opened
     When add interest measures lift and rule length
     Then lift and rule length are shown in interest measure section  

[3.2.4] Remove antecedent
     Given miner has following antecedent attributes    @{AllAttributes}
     When antecedent atributtes are removed  @{AttributesToRemove} 
     Then antecedent in rule pattern section contains following attributes   @{AttributesAfterRemove}

[3.2.5] Remove consequent
     Given miner has following consequent attributes    @{AllAttributes}
     When consequent atributtes are removed  @{AttributesToRemove} 
     Then consequent in rule pattern section contains following attributes   @{AttributesAfterRemove}

[3.2.6] Remove interest measures
     Given miner "${Miner}" page is opened
     When remove interest measures confidence and support
     Then interest measure section should not contain confidence and support measure
    
*** Keywords ***
Suite setup
    Rule pattern suite setup "${User32}" "${Miner}"

Add interest measures lift and rule length
    Add interest measure "Lift" with threshold "${LiftThreshold}"
    Add interest measure "Rule length" with threshold "${RuleLength}"

Lift and rule length are shown in interest measure section 
    Rule has interest measure "Lift" with threshold "${LiftThreshold}"
    Rule has interest measure "Rule length" with threshold "${RuleLength}"

Remove interest measures confidence and support
    Remove interest measure "Confidence"
    Remove interest measure "Support"

Interest measure section should not contain confidence and support measure
    Interest measure section does not contain "Confidence"
    Interest measure section does not contain "Support"

Miner has following antecedent attributes
    [Arguments]    @{attributes}
    Miner "${Miner}" page is opened
    Antecedent is created from attributes  @{attributes} 
    Antecedent in rule pattern section contains following attributes   @{attributes} 

Miner has following consequent attributes
    [Arguments]    @{attributes}
    Miner "${Miner}" page is opened
    Consequent is created from attributes  @{attributes} 
    Consequent in rule pattern section contains following attributes   @{attributes} 

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