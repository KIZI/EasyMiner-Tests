*** Settings ***
Suite Setup       Suite setup
Suite Teardown    Logout and close browsers
Force Tags        MiningProcess
Resource          Resources/MiningProcess.robot

*** Variables ***
${Miner}    titanic-3.1

*** Test Cases ***
[3.1.1] Add attributes - each value one bin preprocessing
      Given miner "${Miner}" page is opened
      When attributes are created from all dataset fields
      Then attributes derived from fields are available in attributes section
    
*** Keywords ***
Suite setup
      Attribute creation suite setup "${User31}" "${Miner}"

   












