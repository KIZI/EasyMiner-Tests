# How to write tests
To ensure high readability, maintainability and also performace, please follow these conventions. There are based on best practices. For more tips how to write good tests read official [guidelines](https://github.com/robotframework/HowToWriteGoodTestCases/blob/master/HowToWriteGoodTestCases.rst).
## Limitations of execution environment
Each test run is executed on fresh environment (even local runs). Even database state is not persisted. 
All test suites have to:
- Be added to /Test directory
- Use only Firefox as browser
## Code conventions
- Use variables to reuse values, especially selectors
- Use keywords to reuse logic, leverage arguments for better reusability
- Use resource files to reuse keywords
- Pascal case for global variables, camel case for local variables
- Avoid adding unecessary documentation using *Documentation* keyword, use right names for keywords/scenarios/suites instead
- Keyword name should explain what the keyword does, not how it does it
- Use descriptive and clear sentences for custom keywords, write them as plain language sentances (capitalizing just the first letter) 
- Leverage [Data-driven](https://github.com/robotframework/HowToWriteGoodTestCases/blob/master/HowToWriteGoodTestCases.rst#data-driven-tests) approach for scenarios that uses large amount of different test data
- **Avoid** using sleep unless **absolutely** necessary. Use *Wait ...* keywords instead
- When waiting for long running actions using *Wait ...*, always specify timeout with some additional time over expected time for action. Keep in mind that tests can be executed on slower machine than yours. Also *Wait ...* keywords checks given condition repeatedly within time specified in *timeout*, so bigger timeouts does not increase test execution time.
## Test suites and scenarios
- Use [Given-When-Then](https://www.google.cz/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&uact=8&ved=0ahUKEwi6p6qIj8bWAhUGVxQKHUHBDGUQFggsMAE&url=https%3A%2F%2Fwww.agilealliance.org%2Fglossary%2Fgwt%2F&usg=AFQjCNFekLAZjKSa4B4HFqbOuFmzEyUBqA) structure for scenarios
- Test only **one** action per scenario
- Test only relevant outcomes of actions
- Avoid long scenarios with over usage of *AND* keyword
- Leverage Test Suite Setup keyword to setup desired initial application state
- Make sure that all scenarios are independent - leverage test (suite) setup/teardown, using different user accounts etc.
- Use tags to split suites into groups by covered functionality
- Start scenario names with *[X.Y.Z]* identifier, where X is functionality group number, Y is suite number within functionality and Z is number of scenarion within test suite (see currently implemented scenarios)
- Start scenario suite names with *X.Y-* identifier, where X is functionality group number, Y suite number within functionality
- User underscore _ to separate words in test suite names
- Use short and descriptive names for suite/scenarios

## Finding elements on page
- Prefer css selectors over xpath. Correctly used css selectors are less dependent on specific page structure
- Do not check text on element, unless it is relevant for system behavior. For example checking found rule text is relevant (= testing functionality), but checking label on submit button does not (= this is just label, does not affect app behavior)
- Do not just copy+paste selectors from browser development tools
- Create your own selectors that are flexible, not tied to specific page structure. For example instead of targeting submit button of form using (copy pasted from Chrome developer tools):
```
#frm-registrationForm > div.actions > input 
```
use custom selector
```
#frm-registrationForm input[type="submit"]
```
Latter is less fragile, because it does not matter if button is inside div.action element or not.

## Test data
If possible, use test data that are already used elsewhere. Check [EasyMiner tutorial](http://www.easyminer.eu/tutorial) or [REST-API Tests] before creating test data on your own.

# Adding new tests to repository
This repository has two branches for test definitions - *master* and *v2.4*.

*Master* is used for tests that are in [EasyMinerCenter](https://github.com/KIZI/EasyMiner-EasyMinerCenter) master branch, i.e. development branch.

*v2.4* is used for tests that are in [EasyMinerCenter](https://github.com/KIZI/EasyMiner-EasyMinerCenter) v2.4 branch, i.e. latest stable branch.

When new stable version of EasyMinerCenter is released, follow current pattern and create new branch with same name as EasyMinerCenter version tag. And changed used images for services in docker-compose accordingly. This process allows to develop tests for new functionality for currently developed version and still ensure quality of stable releases.

Keep in mind that each push to branches with .travis.yml file triggers build on Travis CI. After Travis build, results are updated to website and emailed to all members of EasyMiner development team. To avoid spamming your team, please push to those branches with **caution**. Always try to execute your tests locally.


# Known issues
Current version of libraries used for automation has problems with *Click element* keyword if target element is inside *iframe* element. Use *IFrame click on element "${elementSelector}"* keyword defined in /Resouces/Common.robot resource file. This keyword uses workaround to simulate click on element selected element.