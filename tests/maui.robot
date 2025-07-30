*** Settings ***

Library    AppiumLibrary

*** Variables ***

${webservice}    wshml.engeman.com/wsmauiportocel  
${saveButton}    //android.widget.ImageButton[@content-desc="Navigate up"] 

${menuSuperior}    //android.widget.ImageView[@content-desc="More options"]


*** Test Cases ***

Abrir Tela Principal

    Open Application    http://localhost:4723
    ...            platformName=Android
    ...            automationName=UIAutomator2
    ...            app=C:\\QAx\\projects\\maui\\engemanmaui.apk
    ...            autoGrantPermissions=true
    
    Wait Until Page Contains    Portocel    20


Digitar Webservice
    ${cfgButton}    Set Variable     //androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[1]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ImageView[1]
    ${wsField}      Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[1]/android.widget.EditText
    ${lastField}    Set Variable     //android.widget.EditText[@text="Escolher"]
    ${check1}       Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[6]/android.widget.Switch
    ${check2}       Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[7]/android.widget.Switch

    Wait Until Element Is Visible    ${cfgButton}    20
    Click Element    ${cfgButton}
    

    Wait Until Element Is Visible    ${wsField}    20
    Input Text    ${wsField}    ${webservice}

    Click Salvar


Gerar Banco de Dados
    

    Wait Until Page Contains    Importar Dados
    Click Text    Importar Dados
    
    Wait Until Page Contains    Verificando webservice
    
    Wait Until Page Contains    Selecionar Filial    60
    Menu Superior    Marcar Todas

    Menu Superior    Continuar

    Wait Until Page Contains    Prosseguir sem importar O.S.    60
    Click Text    Prosseguir sem importar O.S.

    Wait Until Page Contains    Banco de dados gerado e baixado com sucesso!    120
    Click Text    Ok

    Sleep    2
Reabrir Aplicação

    Activate Application    com.engemanmaui.portocel
    Sleep    5

Logar no app

    ${loginField}      Set Variable    //android.widget.EditText[@text="Usuário"]
    ${passField}       Set Variable    //android.widget.EditText[@text="Senha"]
    ${buttonEntrar}    Set Variable    //android.widget.TextView[@text="Entrar"]
    
    Wait Until Element Is Visible    ${loginField}    30
    Input Text    ${loginField}    engeman
    Input Password    ${passField}    engeman
    
    Click Element    ${buttonEntrar}

    Wait Until Page Contains    Selecionar Filial    10

    Click Text   01
    Wait Until Page Contains    Notificações    10


*** Keywords ***

Scroll to
    [Arguments]    ${element}
    

    Run Keyword And Ignore Error    Scroll Down    ${element}

Click Salvar


    Wait Until Element Is Visible    ${saveButton}    20
    Click Element    ${saveButton}
    Wait Until Page Contains      Configurações


Menu Superior
    [Arguments]    ${option_text}

    Wait Until Element Is Visible    ${menuSuperior}    15
    Click Element    ${menuSuperior}
    
    Wait Until Page Contains    ${option_text}
    Click Text    ${option_text}
    
