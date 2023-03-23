*** Settings ***
Library    SeleniumLibrary
Library    Screenshot

*** Test Cases ***
TEST_OPENGMAIL
    Open Browser    https://mail.google.com/mail/u/0/#inbox    headlesschrome     options=add_argument("--disable-gpu"); add_argument("--no-sandbox"); add_argument("--disable-extensions")
    Maximize Browser Window
    Wait Until Page Contains    Verify
    Click Button    Continue
    
