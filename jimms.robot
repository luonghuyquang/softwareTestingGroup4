*** Settings ***
Library  selenium
*** Variables ***
${BASE URL}  https://www.jimms.fi/
${PRODUCT PAGE PATH}  /product/some-product
${LISAA KORIIN LINK ID}  LisaaKoriin

*** Test Cases ***
 find link "Lisää koriin" from product page
   Set Test Documentation    doc 

*** Keywords ***