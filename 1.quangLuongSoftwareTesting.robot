*** Comments ***
# Group 4 members in ABC order:

# Allan Omoregbee (test 3)
# Andrejs Kavalans (test 4)
# Njoku Nelson (test 2)
# Quang Luong (test 1 - mandatory 1.1, optional 1.2)
# Tuan Dang (test 5)

# Software Testing
# Group Project Work


*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem


*** Variables ***
# The product to test
${URL}    https://www.jimms.fi/


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
            Page Should Contain Element  xpath=//img
        END
    # Closing of the loop
    END
    # Close the browser
    Close Browser

# 1.2. Optional Test: Check if Product Sub Category (level 2) items have Landing Page:
1.2 Optional - Quang Check If All Sub-Categories Have A Landing Page
#1.2.1. Open the Browser to the tested URL
    Open Browser    ${URL}    Chrome
    ...    Chrome    options=add_experimental_option("detach", True)
    Maximize Browser Window

    # 1st loop through the Categories (level 1, similar to Test 1.1 but not testing here)
    FOR    ${i}    IN RANGE    1    15     # Limit to 15 cycles to save time, actually there's only 10 elements to test
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
                Page Should Contain Element  xpath=//img

            END
        END
    END
    # Close the browser
    Close Browser