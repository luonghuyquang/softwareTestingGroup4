*** Settings ***
Library    String
Library    SeleniumLibrary
*** Variables ***
${URL}  https://www.jimms.fi/
${EL_SSHOT}    ${CURDIR}${/}screenshots/LisääKoriin.png

*** Test Cases ***
Test 4.1 Can you find icon related to link "Lisää koriin". Robot takes element screenshot from icon. - Andrejs Kavalans
    Open Browser    ${URL}    chrome
    ...            chrome     options=add_experimental_option("detach", True)
    Maximize Browser Window
    
    Capture Element Screenshot    class:me-1    ${EL_SSHOT}
    SeleniumLibrary.Close Browser

*** Test Cases ***
Test 4.2 Adding 2 products to the cart, opening cart, checking that the price is correcttly summed - Andrejs Kavalans
        Open Browser    ${URL}${/}Product/Tietokoneet    chrome
    ...            chrome     options=add_experimental_option("detach", True)
    Maximize Browser Window

    Click Element    xpath:/html/body/main/div[2]/div/div[2]/div[4]/div/div[1]/product-box/div[2]/div[3]/addto-cart-wrapper
    Sleep    1s
    Click Element    xpath:/html/body/main/div[2]/div/div[2]/div[4]/div/div[2]/product-box/div[2]/div[3]/addto-cart-wrapper

    ${price1}    Get Text   xpath:/html/body/main/div[2]/div/div[2]/div[4]/div/div[1]/product-box/div[2]/div[3]/div/span/span
    ${price2}    Get Text   xpath://*[@id="jim-main"]/div[2]/div/div[2]/div[4]/div/div[2]/product-box/div[2]/div[3]/div/span/span

    ${price1}    Remove String    ${price1}    €
    ${price2}    Remove String    ${price2}    €
    ${price1}    Replace String    ${price1}    ,    .
    ${price2}    Replace String    ${price2}    ,    .
    ${price1}    Remove String    ${price1}    ${SPACE}
    ${price2}    Remove String    ${price2}    ${SPACE}
    Convert to Number    ${price1}
    Convert to Number    ${price2}
    ${priceSUM}=    Evaluate    ${price1}+${price2}

    Click Element    xpath:/html/body/header/div/div[3]/jim-cart-dropdown/div/a
    Wait Until Location Is    ${URL}fi/ShoppingCart
    ${priceCart}    Get Text    xpath:/html/body/main/div/div/div/div[2]/div/div[1]/ul/li[5]/span
    ${priceCart}    Remove String    ${priceCart}    €
    ${priceCart}    Replace String    ${priceCart}    ,    .
    ${priceCart}    Remove String    ${priceCart}    ${SPACE}
    Convert to Number    ${priceCart}
    Should Be Equal As Numbers    ${priceSUM}    ${priceCart}

    SeleniumLibrary.Close Browser