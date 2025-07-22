*** Settings ***

Library    AppiumLibrary

*** Variables ***

${START}    QAX
${hamburger}    //android.widget.ImageButton[@content-desc="Open navigation drawer"]
${backbutton}   //android.widget.ImageView[@resource-id="com.qaxperience.yodapp:id/ivBack"] 


*** Test Cases ***

Abrir Aplicação e entrar no menu principal

    Open App
    Click Button    QAX
        
Click Simples
    
    Click hamburger menu
    Navigate to     Clique em Botões
    Navigate to     Clique simples
    Click Button    CLIQUE SIMPLES
    Wait Until Page Contains    Isso é um clique simples

Long Click

    Click Back Button
    Click hamburger menu
    Navigate to    Clique em Botões
    Go to item  Clique longo
    Click Button    CLIQUE LONGO


Preencher Formulario Cadastro

    Click Back Button
    Click hamburger menu
    Navigate to    Formulários
    Navigate to    Cadastro
    Wait Until Page Contains    Email
    
    Type Text    Nome    Victor Faria
    Type Text    Email  victor.faria@engecompany.com
    Type Text    Senha   MinhaSenhaSuperSegura123
    Select Option    Jedi
    Click Button    CADASTRAR
    


Preencher Fomulario Login
    
    Click Back Button
    Click hamburger menu
    Navigate to    Formulários
    Navigate to    Login
    Wait Until Page Contains    Email
    Type Text    Email    victor.faria@engecompany.com
    Type Text    Senha secreta    MinhaSenhaSuperSegura123
    Click Button    ENTRAR
   


Preencher Checklist
    
    ${chckcontainer}    Set Variable    //android.widget.LinearLayout[@resource-id="com.qaxperience.yodapp:id/fragment"]/android.widget.FrameLayout

    Click Back Button
    Click hamburger menu
    Navigate to    Check e Radio
    Go to item    Checkbox
    
    Wait Until Element Is Visible    ${chckcontainer}    
    Click Text    Ruby
    Click Text    Python
    Click Text    Java
    Click Text    Javascript
    Click Text    Cobol
    Click Text    C#
    Click Text    Robot Framework
    
    

Clicar nos Botões de Radio
    
    ${radiocontainer}    Set Variable    //android.widget.LinearLayout[@resource-id="com.qaxperience.yodapp:id/fragment"]/android.widget.FrameLayout
    
    Click Back Button
    Go to item    Botões de radio

    Wait Until Element Is Visible    ${radiocontainer}
    Click Text    Java
    Click Text    C#
    Click Text    Ruby
    Click Text    Python
    Click Text    Javascript
    Click Text    Elixir
    Click Text    Go Lang

Fechar Aplicativo
    Sleep    5
    Close Application
*** Keywords ***

Open App
    Open Application   http://localhost:4723
    ...                strict_ssl=No
    ...                udid=emulator-5554
    ...                platformName=Android
    ...                deviceName=emulator-5554
    ...                automationName=UIAutomator2
    ...                app=C:/Qax/projects/yodapp-robot/app/yodapp-beta.apk
    ...                autoGrantPermissions=true
    
Click hamburger menu
    Wait Until Element Is Visible    ${hamburger}    5
    Click Element    ${hamburger}
    
    
Navigate to
    
    [Arguments]    ${item_text}
    ${menu_item}  Set Variable  //android.widget.TextView[@resource-id="com.qaxperience.yodapp:id/tvItemTitle" and @text="${item_text}"]

    
    Wait Until Element Is Visible    ${menu_item}
    Click Element    ${menu_item}
    
    
Go to item
    [Arguments]    ${item_text}
    ${menu_item}    Set Variable    //android.widget.TextView[@resource-id="com.qaxperience.yodapp:id/tvItemTitle" and @text="${item_text}"]
    
    Wait Until Element Is Visible    ${menu_item}
    Click Element    ${menu_item}
    
    
Click Button
    [Arguments]    ${item_text}
    ${button}    Set Variable    //android.widget.Button[@text="${item_text}"]
    
    Wait Until Element Is Visible    ${button}
    Click Element    ${button}    
    


Click Back Button
    Wait Until Element Is Visible    ${backbutton}
    Click Element    ${backbutton}

Type Text
    [Arguments]    ${field_text}    ${text_input}
    
    ${input_field}    Set Variable    //android.widget.EditText[@text="${field_text}"]

    Input Text    ${input_field}    ${text_input}
Select Option
    [Arguments]    ${option_text}

    Click Element    //android.widget.Spinner[@resource-id="com.qaxperience.yodapp:id/spinnerJob"]
    Click Text  ${option_text}