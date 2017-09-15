*** Settings ***
Suite Setup       Rule pattern suite setup
Suite Teardown    Mining process suite teardown
Force Tags        MiningProcess
Resource          Resources/MiningProcess.robot
Resource          Resources/RulePattern.robot

*** Variables ***
${Confidence}   0.784
${RuleLength}   2
@{ExpectedRules}    isadultmale(TRUE) → survived(FALSE)     job(General Labourer) → survived(FALSE)
@{ExpectedConfidence}    0.801     0.969
@{ExpectedSupport}    0.576      0.071
${ExpectedRulesCount}    2
${FoundRulesSectionId}  found-rules-rules
${RuleTabsSectionId}  marked-rules

*** Test Cases ***
[3.3.1] Miner rules - find rules
    Given rule pattern is created on miner page
    When rule mining is started
    Then miner should find rules

[3.3.2] Miner rules - show rule details
    Given rules are found on miner page
    When is clicked on found rule "${ExpectedRules[0]}" details button
    Then rule "${ExpectedRules[0]}" details should appear

[3.3.3] Miner rules - add to rule to clipboard
    Given rules are found on miner page
    When rule "${ExpectedRules[0]}" from found rules is added to rule clipboard
    Then rule "${ExpectedRules[0]}" should appear in rule clipboard

[3.3.4] Miner rules - remove rule from clipboard
    Given rule "${ExpectedRules[0]}" is in rule clipboard
    When rule "${ExpectedRules[0]}" is removed from rule clipboard
    Then rule "${ExpectedRules[0]}" should not appear in rule clipboard
    
*** Keywords ***
Rule pattern is created on miner page
    Miner page is opened
    Antecedent is created from attributes  @{AntecedentAttributes}
    Antecedent in rule pattern section contains following attributes   @{AntecedentAttributes} 
    Consequent is created from attributes  @{ConsequentAttributes} 
    Consequent in rule pattern section contains following attributes   @{ConsequentAttributes} 
    Remove interest measure "Confidence"
    Interest measure section does not contain "Confidence"
    Add interest measure "Confidence" with threshold "${Confidence}"
    Rule has interest measure "Confidence" with threshold "${Confidence}"
    Add interest measure "Rule length" with threshold "${RuleLength}"
    Rule has interest measure "Rule length" with threshold "${RuleLength}"

Rule mining is started
    Wait for element and click  css=#start-mining

Miner should find rules
    Wait until page contains element  css=.solved    60s
    Found rules should contain rule "${ExpectedRules[0]}"
    Found rules count should be "${ExpectedRulesCount}"
    Found rule "${ExpectedRules[0]}" should have measure "Confidence" with value "${ExpectedConfidence[0]}"
    Found rule "${ExpectedRules[0]}" should have measure "Support" with value "${ExpectedSupport[0]}"
    Found rules should contain rule "${ExpectedRules[1]}"
    Found rule "${ExpectedRules[1]}" should have measure "Confidence" with value "${ExpectedConfidence[1]}"
    Found rule "${ExpectedRules[1]}" should have measure "Support" with value "${ExpectedSupport[1]}"

Found rules count should be "${foundRulesCount}"
    Page should contain element     xpath=//*[@id="found-rules-task-name"]//*[@class="count"][contains(string(),"${foundRulesCount}") ]

Select rule clipboard tab
    Wait for element and click  css=h2.marked-rules-tasks

Select rule knowledge base tab
    Wait for element and click  css=h2.marked-rules-base

Found rule "${rule}" should have measure "${measure}" with value "${measureValue}"
    Rule "${rule}" in section "${FoundRulesSectionId}" should have measure "${measure}" with value "${measureValue}"

Rule "${rule}" in section "${section}" should have measure "${measure}" with value "${measureValue}"
    Page should contain element     xpath=//*[@id="${section}"]//*[@class="rule"][contains(string(),"${rule}")]//following::*[@class="ims"]//span[contains(string(),"${measure}") and contains(string(),"${measureValue}") ]

Found rules should contain rule "${rule}"
    Section "${FoundRulesSectionId}" should contain "${rule}"

Section "${section}" should contain "${rule}"
    Page should contain element     xpath=//*[@id="${section}"]//*[@class="rule"][contains(string(),"${rule}")] 

Section "${section}" should not contain "${rule}"
    Page should not contain element     xpath=//*[@id="${section}"]//*[@class="rule"][contains(string(),"${rule}")] 

Rules are found on miner page
    Rule pattern is created on miner page
    Rule mining is started
    Miner should find rules

Is clicked on found rule "${rule}" details button
    Select rule action "details" for "${rule}" in section "${FoundRulesSectionId}"

Select rule action "${action}" for "${rule}" in section "${section}"
    Found rules should contain rule "${rule}"
    Mouse over  xpath=//*[@id="${section}"]//*[@class="rule"][contains(string(),"${rule}")] 
    Click element   xpath=//*[@id="${section}"]//*[@class="rule"][contains(string(),"${rule}")]//following::*[@class="ruleActions"]/*[@class="${action}"]

Rule "${rule}" details should appear
    Select frame    css=iframe[src*="rule-details"]
    Wait until page contains    ${rule}
    Page should contain confusion matrix
    Page should contain confusion matrix with values    1272   316  224  396
    Unselect frame

Page should contain confusion matrix
    Page should contain element     xpath=//*[@class="rule4ftTable"]//tbody/tr[1]/td[2][contains(string(),"consequent")] 
    Page should contain element     xpath=//*[@class="rule4ftTable"]//tbody/tr[1]/td[3][contains(string(),"¬ consequent")] 
    Page should contain element     xpath=//*[@class="rule4ftTable"]//tbody/tr[2]/td[1][contains(string(),"antecedent")] 
    Page should contain element     xpath=//*[@class="rule4ftTable"]//tbody/tr[3]/td[1][contains(string(),"¬ antecedent")] 

Page should contain confusion matrix with values
    [Arguments]     @{values}
    Page should contain element    xpath=//*[@class="rule4ftTable"]//tbody/tr[2]/td[2][contains(string(),"${values[0]}")]
    Page should contain element    xpath=//*[@class="rule4ftTable"]//tbody/tr[2]/td[3][contains(string(),"${values[1]}")]
    Page should contain element    xpath=//*[@class="rule4ftTable"]//tbody/tr[3]/td[2][contains(string(),"${values[2]}")]
    Page should contain element    xpath=//*[@class="rule4ftTable"]//tbody/tr[3]/td[3][contains(string(),"${values[3]}")]

Rule "${rule}" from found rules is added to rule clipboard
    Select rule action "mark" for "${rule}" in section "${FoundRulesSectionId}"

Rule "${rule}" should appear in rule clipboard
    Select rule clipboard tab
    Section "${RuleTabsSectionId}" should contain "${rule}"
    Rule "${rule}" in section "${RuleTabsSectionId}" should have measure "Confidence" with value "${ExpectedConfidence[0]}"
    Rule "${rule}" in section "${RuleTabsSectionId}" should have measure "Support" with value "${ExpectedSupport[0]}"

Remove rule "${rule}" from rule clipboard
    Select rule action "clear" for "${rule}" in section "${RuleTabsSectionId}"

Rule "${rule}" is removed from rule clipboard
    Select rule clipboard tab
    Remove rule "${rule}" from rule clipboard

Rule "${rule}" should not appear in rule clipboard
    Select rule clipboard tab
    Section "${RuleTabsSectionId}" should not contain "${rule}"

Rule "${rule}" is in rule clipboard
    Rules are found on miner page
    Rule "${rule}" from found rules is added to rule clipboard
    Rule "${rule}" should appear in rule clipboard