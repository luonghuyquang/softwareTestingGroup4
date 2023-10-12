*** Settings ***
Library    String
Library    SeleniumLibrary
*** Variables ***
${URL}  https://www.jimms.fi/
${EL_SSHOT}    ${CURDIR}${/}screenshots/LisääKoriin.png

*** Test Cases ***
Test 4:Can you find icon related to link "Lisää koriin". Robot takes element screenshot from icon. - Andrejs Kavalans
    Open Browser    ${URL}    chrome
    ...            chrome     options=add_experimental_option("detach", True)
    Maximize Browser Window
    
    Capture Element Screenshot    class:me-1    ${EL_SSHOT}
    SeleniumLibrary.Close Browser