*** Comments ***
# Group 4 members in ABC order:

# Allan Omoregbee (test 3)
# Andrejs Kavalans (test 4)
# Njoku Nelson (test 2)
# Quang Luong (test 1 - mandatory 1.1, optional 1.2)
# Tuan Dang (test 5)
## TEST Seque
# Software Testing
# Group Project Work


*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     String


*** Variables ***
# The website to test
${URL}          https://www.jimms.fi/
# For test 2.2 and 2.3
${KEYWORD_N}      ps5
${PRODUCT_N}      graphics processor
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
        Open Browser    https://www.jimms.fi/fi/Product/Tietokoneet    chrome
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

*** Test Cases ***
1.0. Quang Preparations for Tests
# 1.0.1. Make the Directory for Screenshots
    Create Directory    .\\1quangLuongScreenshots
    Set Screenshot Directory    .\\1quangLuongScreenshots
# 1.0.2. Create a .txt file with to store the Category without Landing Page
    Create File    ./1quangLuong.txt    Categories without Landing Page:\n

# Mandatory Test: Check if all Product Category (Tuoteryhmät) items have landing page

1.1. Mandatory - Quang Check If All Categories Have A Landing Page
# Open the Browser to the tested URL
    Open Browser    ${URL}    Chrome
    ...    Chrome    options=add_experimental_option("detach", True)
    Maximize Browser Window

# Run a loop to check for a href="" attribute
# If there is no landing page, append the Category name to quangLuong.txt
# If there is a landing page, click on the link to open it to prepare for the next level
    FOR    ${i}    IN RANGE    1    32
        ${path_1}=    Set Variable    //*[@id="sitemegamenu"]/nav/ul/li[${i}]/a
        # ${path_1}=    Set Variable    /html/body/header/div/div[1]/jim-drilldown-mega-menu/nav/ul/li[${i}]/a
        ${element}=    Run Keyword And Return Status    Element Should Be Visible    xpath:${path_1}
        IF    not ${element}
            IF    ${i}>1    BREAK
        END
        # Count the number of cycles to know the number of categories
        Log    'number of cylces: ${i}'
        # If the Category has a landing page, there must be a href link and enabled to it at this level of the menu
        Run Keyword And Ignore Error    Element Should Be Enabled    xpath:${path_1}
        # Check if the element has a href attribute
        ${href_attribute}=    Run Keyword And Ignore Error    Get Element Attribute    xpath:${path_1}    href
        # If there is no landing page, append the Category name to quangLuong.txt
        # This is an alternative to Should Not Be Empty, with the possibility to write the problematic category to file
        IF    ${href_attribute} == ('PASS', None)
            ${category}=    Get Text    ${path_1}
            Append To File    ./1quangLuong.txt    Level 1: ${category}\n
            # If there is a landing page, click on the link to open it to check it content
        ELSE
            # Go back to home page
            Go To    ${URL}
            # Click on the link of the Landing Page
            Click Element    ${path_1}
            # The landing page is expected to have at least an image
            Page Should Contain Element    xpath=//img
        END
        # Closing of the loop
    END
    # Close the browser
    Close Browser

# 1.2. Optional Test: Check if Product Sub Category (level 2) items have Landing Page:

1.2 Optional - Quang Check If All Sub-Categories Have A Landing Page
# 1.2.1. Open the Browser to the tested URL
    Open Browser    ${URL}    Chrome
    ...    Chrome    options=add_experimental_option("detach", True)
    Maximize Browser Window

    # 1st loop through the Categories (level 1, similar to Test 1.1 but not testing here)
    FOR    ${i}    IN RANGE    1    15    # Limit to 15 cycles to save time, actually there's only 10 elements to test
        ${path_1}=    Set Variable    //*[@id="sitemegamenu"]/nav/ul/li[${i}]/a
        # ${path_1}=    Set Variable    /html/body/header/div/div[1]/jim-drilldown-mega-menu/nav/ul/li[${i}]/a
        ${element1}=    Run Keyword And Return Status    Element Should Be Visible    xpath:${path_1}
        IF    not ${element1}
            IF    ${i}>1    BREAK
        END
        # This is to open for the next level of Sub Category
        Go To    ${URL}
        Click Element    ${path_1}

        # 2nd loop - this is to check for a href="" attribute
        # If there is no landing page, append the Sub-Category name to quangLuong.txt
        # If there is a landing page, click on the link to open it to prepare for the next level
        # In the video I limited the run to 2 cycles for time saving
        FOR    ${j}    IN RANGE    1    3
            # ${path_2}=    Set Variable    /html/body/main/div[2]/div/div[1]/filtermenu/div/div[2]/div/div/div[2]/div/ul/li[${j}]/div/div/a
            ${path_2}=    Set Variable    //*[@id="cListGroup"]/div/ul/li[${j}]/div/div/a
            ${element2}=    Run Keyword And Return Status    Element Should Be Visible    xpath:${path_2}
            IF    not ${element2}
                IF    ${j}>1    BREAK
            END
            Log    'number of cylces: ${j}'
            # Max cycle count at level 2 j = 26 at i = 3
            # If the Sub-Category has a landing page, there must be a href link and enabled to it at this level of the menu
            Run Keyword And Ignore Error    Element Should Be Enabled    xpath:${path_2}
            # Check if the element has a href attribute
            ${href_attribute}=    Run Keyword And Ignore Error    Get Element Attribute    xpath:${path_2}    href
            # If there is no landing page, append the Sub-Category name to quangLuong.txt
            # This is an alternative to Should Not Be Empty, with the possibility to write the problematic category to file
            IF    ${href_attribute} == ('PASS', None)
                ${sub_category}=    Get Text    ${path_2}
                Append To File    ./1quangLuong.txt    Level 2: ${sub_category}\n
                # If there is a landing page, click on the link to open it to prepare for the next level
            ELSE
                # This is to open the Sub-Category link to view the content, also prepare for the next level of Sub-Sub-Category for further testing
                Go To    ${URL}
                Click Element    ${path_1}
                Run Keyword And Ignore Error    Click Element    ${path_2}
                # The landing page is expected to have at least an image
                Page Should Contain Element    xpath=//img
            END
        END
    END
    # Close the browser
    Close Browser

# NELSON

# 2.1 Nelson test case 1
Open Jimms
    Open Browser    ${URL}    Chrome
    ...    Chrome    options=add_experimental_option("detach", True)
    Maximize Browser Window

Search Feature On Main Page
    Click Element    id=searchinput
    Input Text    id=searchinput    ${KEYWORD_N}
    Press Keys    id=searchinput    RETURN
    Sleep    10s

Take ScreenShot of Product Page
    Capture Page Screenshot    screenshot.png

Match keyword
    Run Keyword And Ignore Error    Page Should Contain    ${KEYWORD_N}

# 2.2. Nelson test case 2
Return Home
    Click Image    xpath://html/body/header/div/div[2]/div/a/picture/img

Search For Product
    Click Element    id=searchinput
    Input Text    id=searchinput    ${PRODUCT_N}
    Press Keys    id=searchinput    RETURN

Click on the first search result
    Click Element    xpath:/html/body/main/div[2]/div/div[2]/div[5]/div/div[1]/product-box/div[2]/div[2]/h5/a/b
    Sleep    10s

Add Product to cart
    Click Element
    ...    xpath://html/body/main/div[1]/div[2]/div/jim-product-cta-box/div/div[3]/div[2]/addto-cart-wrapper/div/a

Open Cart and Take ScreenShot
    Click Element    xpath://html/body/header/div/div[3]/jim-cart-dropdown/div/a

    Capture Page Screenshot    screenshot2.png
    Close Browser

*** Test Cases ***
3.1 - Find Item by Title - Allan
    Open Browser    ${URL}    Chrome
    ...    Chrome    options=add_experimental_option("detach", True)
    Maximize Browser Window
    Execute JavaScript    document.querySelector('a[title="Lisää koriin"]').scrollIntoView();
    Sleep    3
    Close Browser

5 Add the items into the shopping basket and check 

    Open Browser    ${URL}    chrome    options=add_experimental_option("detach", True)
    Maximize Browser Window
    # Test 5.1: Add the items into the shopping basket - Minh Tuan
    Sleep    1
    #Ignore the error and scroll
    Run Keyword And Ignore Error    Scroll Element Into View    xpath:/html/body/main/div[4]/section[1]/div/ul
    Wait Until Element Is Visible    xpath://*[@id="fp-suggestions-carousel1-slide01"]/div/product-box/div[2]/div[3]/addto-cart-wrapper/div/a
    # Add item into the basket
    Click Element    xpath://*[@id="fp-suggestions-carousel1-slide01"]/div/product-box/div[2]/div[3]/addto-cart-wrapper/div/a
    sleep    2
    Click Element    xpath=/html/body/main/div[4]/section[1]/div[2]/ul/li[2]/div/product-box/div[2]/div[3]/addto-cart-wrapper/div/a
    sleep    2
    

    # Test 5.2: Check and compare number of items in cart and number show on the icon - Minh Tuan
    Click Element    xpath=/html/body/header/div/div[3]/jim-cart-dropdown/div/a
    # Take number display on the shopping cart
    ${number_show}    Get Text    xpath://*[@id="headercartcontainer"]/a/span/span
    # Count item in the cart
    ${elements}    Get Webelements    xpath=//*[@id="jim-main"]/div/div/div/div[1]/article
    ${element_count}    Get Length    ${elements}    
    # Compare
    Should Be Equal     ${element_count}    ${number_show}