*** Settings ***
Suite Setup       Attribute creation suite setup
Suite Teardown    Mining process suite teardown
Force Tags        MiningProcess
Resource          Resources/MiningProcess.robot

*** Variables ***


*** Test Cases ***
[3.1.1] Add attributes - each value one bin preprocessing
      Given miner page is opened
      When attributes are created from all dataset fields
      Then attributes derived from fields are available in attributes section
    
*** Keywords ***


   












