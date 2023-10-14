*** Settings ***
Library    SeleniumLibrary    

*** Variables ***
${BASE URL}  https://www.jimms.fi
${PRODUCT PAGE PATH}  /product/some-product
${LISAA KORIIN LINK ID}  LisaaKoriin

*** Test Cases ***
Open website and Click Link
    Open Browser    ${BASE URL}    chrome    options=add_experimental_option("detach", True)
    Maximize Browser Window
    Sleep    1
Scroll the target link element into view
    Run Keyword And Ignore Error    Scroll Element Into View    xpath:/html/body/main/div[4]/section[1]/div/ul
 Wait until the target link element is visible
    Wait Until Element Is Visible    xpath://*[@id="fp-suggestions-carousel1-slide01"]/div/product-box/div[2]/div[3]/addto-cart-wrapper/div/a



Click the link
    Click Element    xpath://*[@id="fp-suggestions-carousel1-slide01"]/div/product-box/div[2]/div[3]/addto-cart-wrapper/div/a

Close Window
    Sleep    1
    Close All Browsers