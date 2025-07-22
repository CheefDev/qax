*** Settings ***

Library    AppiumLibrary

*** Variables ***
${START}    QAX

*** Test Cases ***


Clicar no botao



    Open Application   http://localhost:4723
    ...                strict_ssl=No
    ...                udid=emulator-5554
    ...                platformName=Android
    ...                deviceName=emulator-5554
    ...                automationName=UIAutomator2
    ...                app=C:/Qax/projects/yodapp-robot/app/yodapp-beta.apk
    ...                autoGrantPermissions=true
    
    Wait Until Page Contains    ${START}    10
    Click Text    ${START}
    
    ${hamburger}    Set Variable    //android.widget.ImageButton[@content-desc="Open navigation drawer"]
    ${backbutton}    Set Variable    //android.widget.ImageView[@resource-id="com.qaxperience.yodapp:id/ivBack"]
    ${hclickbotoes}    Set Variable    //android.widget.TextView[@resource-id="com.qaxperience.yodapp:id/tvItemTitle" and @text="Clique em Botões"]
    ${menuclicksimples}    Set Variable    //android.widget.TextView[@resource-id="com.qaxperience.yodapp:id/tvItemTitle" and @text="Clique simples"]
    ${btnclicksimples}    Set Variable    //android.widget.Button[@resource-id="com.qaxperience.yodapp:id/short_click"]
    ${msgclicksimples}    Set Variable    //*[@text="Isso é um clique simples"]
   
    
    Wait Until Element Is Visible    ${hamburger}    5
    Click Element    ${hamburger}
    
    
    
    Wait Until Element Is Visible    ${hclickbotoes}
    Click Element    ${hclickbotoes}
    
    
    
    Wait Until Element Is Visible    ${menuclicksimples}
    Click Element    ${menuclicksimples}
    
    

    Wait Until Element Is Visible    ${btnclicksimples}
    Click Element    ${btnclicksimples}
    
    
Preencher Checklist
    
    ${hamburger}    Set Variable    //android.widget.ImageButton[@content-desc="Open navigation drawer"]
    ${backbutton}    Set Variable    //android.widget.ImageView[@resource-id="com.qaxperience.yodapp:id/ivBack"]
    ${hcheckradio}    Set Variable    //android.widget.TextView[@resource-id="com.qaxperience.yodapp:id/tvItemTitle" and @text="Check e Radio"]
    ${menucheckbox}    Set Variable    //android.widget.TextView[@resource-id="com.qaxperience.yodapp:id/tvItemTitle" and @text="Checkbox"]
    ${chckcontainer}    Set Variable    //android.widget.LinearLayout[@resource-id="com.qaxperience.yodapp:id/fragment"]/android.widget.FrameLayout

    Wait Until Element Is Visible    ${backbutton}    15
    Click Element    ${backbutton}

    Wait Until Element Is Visible    ${hamburger}    
    Click Element    ${hamburger}

    Wait Until Element Is Visible     ${hcheckradio}    
    Click Element     ${hcheckradio}

    Wait Until Element Is Visible    ${menucheckbox}    
    Click Element    ${menucheckbox}
    
    Wait Until Element Is Visible    ${chckcontainer}    
    Click Text    Ruby
    Click Text    Python
    Click Text    Java
    Click Text    Javascript
    Click Text    Cobol
    Click Text    C#
    Click Text    Robot Framework
    
    




Clicar nos Botões de Radio
    
    ${hamburger}    Set Variable    //android.widget.ImageButton[@content-desc="Open navigation drawer"]
    ${backbutton}    Set Variable    //android.widget.ImageView[@resource-id="com.qaxperience.yodapp:id/ivBack"]
    
    ${hcheckradio}    Set Variable    //android.widget.TextView[@resource-id="com.qaxperience.yodapp:id/tvItemTitle" and @text="Check e Radio"]
    ${menucheckbox}    Set Variable    //android.widget.TextView[@resource-id="com.qaxperience.yodapp:id/tvItemTitle" and @text="Checkbox"]
    ${menubtnradio}    Set Variable    //android.widget.TextView[@resource-id="com.qaxperience.yodapp:id/tvItemTitle" and @text="Botões de radio"]
    ${radiocontainer}    Set Variable    //android.widget.LinearLayout[@resource-id="com.qaxperience.yodapp:id/fragment"]/android.widget.FrameLayout
    
    Wait Until Element Is Visible    ${backbutton}
    Click Element    ${backbutton}
    
    
    Wait Until Element Is Visible    ${hamburger}    
    Click Element    ${hamburger}
    
    Wait Until Element Is Visible    ${hcheckradio}    
    Click Element    ${hcheckradio}


    Wait Until Element Is Visible    ${menubtnradio}    
    Click Element    ${menubtnradio}

    Wait Until Element Is Visible    ${radiocontainer}
    Click Text    Java
    Click Text    C#
    Click Text    Ruby
    Click Text    Python
    Click Text    Javascript
    Click Text    Elixir
    Click Text    Go Lang

    Sleep    5
    Close Application