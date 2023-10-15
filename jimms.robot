*** Settings ***
Library    SeleniumLibrary  

*** Variables ***
${BASE URL}  https://www.jimms.fi


*** Test Cases ***
Open website and Click Link
    Open Browser    ${BASE URL}    chrome    options=add_experimental_option("detach", True)
    Maximize Browser Window
    #Sleep to wait for page reloading
    Sleep    1
    #Ignore the error and scroll
    Run Keyword And Ignore Error    Scroll Element Into View    xpath:/html/body/main/div[4]/section[1]/div/ul
    Wait Until Element Is Visible    xpath://*[@id="fp-suggestions-carousel1-slide01"]/div/product-box/div[2]/div[3]/addto-cart-wrapper/div/a
    

5.1 Add the items into the shopping basket and check
    Click Element    xpath://*[@id="fp-suggestions-carousel1-slide01"]/div/product-box/div[2]/div[3]/addto-cart-wrapper/div/a
    sleep    2
    Click Element    xpath=/html/body/main/div[4]/section[1]/div[2]/ul/li[2]/div/product-box/div[2]/div[3]/addto-cart-wrapper/div/a
    sleep    2
    Click Element    xpath=/html/body/header/div/div[3]/jim-cart-dropdown/div/a
    ${number_show}    Get Text    xpath://*[@id="headercartcontainer"]/a/span/span
    ${elements}    Get Webelements    xpath=//*[@id="jim-main"]/div/div/div/div[1]/article
    ${element_count}    Get Length    ${elements}    
    Should Be Equal     ${element_count}    ${number_show}


    
