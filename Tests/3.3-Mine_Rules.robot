*** Settings ***
Suite Setup       Suite Setup
Suite Teardown    Logout and close browsers
Force Tags        MiningProcess
Resource          Resources/MiningProcess.robot
Resource          Resources/RulePattern.robot

*** Variables ***
${Miner}    titanic-3.3
${Confidence}   0.782
${RuleLength}   2
@{ExpectedRules}    isadultmale(TRUE) → survived(FALSE)     job(General Labourer) → survived(FALSE)     joined(Belfast) → survived(FALSE)    
@{ExpectedConfidence}    0.801     0.969    0.783
@{ExpectedSupport}    0.576      0.071    0.07
${ExpectedRulesCount}    3
${FoundRulesSectionId}  found-rules-rules
${RuleTabsSectionId}  marked-rules
${AddToRuleClipboardIcon}  unmark
${InterestingRuleIcon}   kbRemovePositive
${NotInterestingRuleIcon}   kbRemoveNegative
${AddToRuleClipboardAction}  mark
${InterestingRuleAction}   kbAddPositive
${NotInterestingRuleAction}   kbAddNegative

*** Test Cases ***
[3.3.1] Mine rules
    Given rule pattern is created on miner page
    When rule mining is started
    Then miner should find rules

[3.3.2] Show rule details
    Given rules are found on miner page
    When is clicked on found rule "${ExpectedRules[0]}" details button
    Then rule "${ExpectedRules[0]}" details should appear

[3.3.3] Add to rule to clipboard
    Given rules are found on miner page
    When rule "${ExpectedRules[0]}" from found rules is added to rule clipboard
    Then rule "${ExpectedRules[0]}" with confidence "${ExpectedConfidence[0]}" and support "${ExpectedSupport[0]}" should appear in rule clipboard

[3.3.4] Remove rule from clipboard
    Given rule "${ExpectedRules[0]}" is in rule clipboard
    When rule "${ExpectedRules[0]}" is removed from rule clipboard
    Then rule "${ExpectedRules[0]}" should not appear in rule clipboard
    
[3.3.5] Add to rule to knowledge base as interesting
    Given rules are found on miner page
    When rule "${ExpectedRules[0]}" from found rules is added to knowledge base as interesting
    Then rule "${ExpectedRules[0]}" with confidence "${ExpectedConfidence[0]}" and support "${ExpectedSupport[0]}" should appear in knowledge base

[3.3.6] Add to rule to knowledge base as not interesting
    Given rules are found on miner page
    When rule "${ExpectedRules[1]}" from found rules is added to knowledge base as not interesting
    Then rule "${ExpectedRules[1]}" with confidence "${ExpectedConfidence[1]}" and support "${ExpectedSupport[1]}" should appear in knowledge base

[3.3.7] Remove rule from knowledge base
    Given rule "${ExpectedRules[2]}" is in rule clipboard
    When rule "${ExpectedRules[2]}" is removed from rule clipboard
    Then rule "${ExpectedRules[2]}" should not appear in in knowledge base

*** Keywords ***
Suite setup
    Rule pattern suite setup "${User33}" "${Miner}"

Rule pattern is created on miner page
    Miner "${Miner}" page is opened
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
    Rule "${ExpectedRules[0]}" with confidence "${ExpectedConfidence[0]}" and support "${ExpectedSupport[0]}" should appear in found rules
    Rule "${ExpectedRules[1]}" with confidence "${ExpectedConfidence[1]}" and support "${ExpectedSupport[1]}" should appear in found rules
    Rule "${ExpectedRules[2]}" with confidence "${ExpectedConfidence[2]}" and support "${ExpectedSupport[2]}" should appear in found rules

Found rules count should be "${foundRulesCount}"
    Page should contain element     xpath=//*[@id="found-rules-task-name"]//*[@class="count"][contains(string(),"${foundRulesCount}") ]

Rule "${rule}" with confidence "${confidence}" and support "${support}" should appear in found rules
    Found rules should contain rule "${rule}"
    Found rule "${rule}" should have measure "Confidence" with value "${confidence}"
    Found rule "${rule}" should have measure "Support" with value "${support}"

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

Rule "${rule}" should be in rule clipboard
    Select rule clipboard tab
    Section "${RuleTabsSectionId}" should contain "${rule}"

Rule "${rule}" with confidence "${confidence}" and support "${support}" should appear in rule clipboard
    Rule "${rule}" should be in rule clipboard
    Rule "${rule}" in section "${RuleTabsSectionId}" should have measure "Confidence" with value "${confidence}"
    Rule "${rule}" in section "${RuleTabsSectionId}" should have measure "Support" with value "${support}"

Remove rule "${rule}" from rule clipboard
    Select rule action "clear" for "${rule}" in section "${RuleTabsSectionId}"

Rule "${rule}" is removed from rule clipboard
    Select rule clipboard tab
    Remove rule "${rule}" from rule clipboard

Rule "${rule}" should not appear in rule clipboard
    Select rule clipboard tab
    Section "${RuleTabsSectionId}" should not contain "${rule}"

Rule "${rule}" should not appear in in knowledge base
    Select rule knowledge base tab
    Section "${RuleTabsSectionId}" should not contain "${rule}"

Rule "${rule}" is in rule clipboard
    Rules are found on miner page
    Rule "${rule}" from found rules is added to rule clipboard
    Rule "${rule}" should be in rule clipboard

Rule "${rule}" is in knowledge base as interesting
    Rules are found on miner page
    Rule "${rule}" from found rules is added to knowledge base as interesting
    Rule "${rule}" should be in knowledge base

Rule "${rule}" from found rules is added to rule clipboard
    Select rule action "${AddToRuleClipboardAction}" for "${rule}" in section "${FoundRulesSectionId}"
    Rule "${rule}" from found rules is tagged with "${AddToRuleClipboardIcon}"

Rule "${rule}" from found rules is added to knowledge base as interesting
    Select rule action "${InterestingRuleAction}" for "${rule}" in section "${FoundRulesSectionId}"
    Rule "${rule}" from found rules is tagged with "${InterestingRuleIcon}"

Rule "${rule}" from found rules is added to knowledge base as not interesting
    Select rule action "${NotInterestingRuleAction}" for "${rule}" in section "${FoundRulesSectionId}"
    Rule "${rule}" from found rules is tagged with "${NotInterestingRuleIcon}"

Rule "${rule}" from found rules is tagged with "${tag}"
    Mouse over  css=#found-rules-multi-controls
    Element should be visible   xpath=//*[@id="${FoundRulesSectionId}"]//*[@class="rule"][contains(string(),"${rule}")]//following::*[@class="ruleActions"]/*[@class="${tag}"]

Rule "${rule}" should be in knowledge base
    Select rule knowledge base tab
    Section "${RuleTabsSectionId}" should contain "${rule}"

Rule "${rule}" with confidence "${confidence}" and support "${support}" should appear in knowledge base
    Rule "${rule}" should be in knowledge base
    Rule "${rule}" in section "${RuleTabsSectionId}" should have measure "Confidence" with value "${confidence}"
    Rule "${rule}" in section "${RuleTabsSectionId}" should have measure "Support" with value "${support}"