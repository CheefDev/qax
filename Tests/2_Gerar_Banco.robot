*** Settings ***

Library    AppiumLibrary
Library    Process

Resource    ../Resources/base.resource
Resource    ../Resources/cfgMobile.resource
Resource    ../Resources/cfgGeral.resource

*** Variables ***


${gerarBanco}      ${null}
${idMobile}        TESTEAUTOMATIZADO


*** Test Cases ***

Digitar Webservice
    [Tags]    Geração do Banco    Configuração
    ${cfgButton}    Set Variable     //androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[1]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ImageView[1]
    ${wsField}      Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[1]/android.widget.EditText
    ${lastField}    Set Variable     //android.widget.EditText[@text="Escolher"]
    ${check1}       Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[6]/android.widget.Switch
    ${check2}       Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[7]/android.widget.Switch
    
    Wait Until Page Contains    Build    10
    ${gerarBanco}    Run Keyword And Return Status    Page Should Not Contain Text  Login do Sistema
    
    
    IF    ${gerarBanco} == False
        Pass Execution    Banco já configurado!
    END
    Wait Until Element Is Visible    ${cfgButton}    20
    Click Element    ${cfgButton}
    

    Wait Until Element Is Visible    ${wsField}    20
    Clear Text    ${wsField}
    Input Text    ${wsField}    ${webservice}


ID Mobile
    [Tags]    Configuração    Geração do Banco
    
    
    ${gerarBanco}    Run Keyword And Return Status    Page Should Not Contain Text  Login do Sistema
    
    
    IF    ${gerarBanco} == False
        Pass Execution    Banco já configurado!
    END

    IF    $idMobile == ''    
    
        Click Salvar
        Skip
    END
    
    ${cIdMobile}    Set Variable    android=UiSelector().className("android.widget.EditText").instance(2)
    Click Element    ${cIdMobile}
    Clear Text       ${cIdMobile}
    Input Text       ${cIdMobile}    ${idMobile}

    Click Salvar
    Mensagem    Deseja realmente salvar as configurações com um ID diferente do ID gerado pelo sistema operacional?    Sim

Gerar Banco de Dados
    [Tags]    Geração do Banco
    
    ${btnNao}    Set Variable    //android.widget.Button[@resource-id="android:id/button2"]
    
    Wait Until Page Contains    Build    10
    
    ${gerarBanco}=    Run Keyword And Return Status    Page Should Not Contain Text  Login do Sistema 
    
    IF    ${gerarBanco} == False
        Pass Execution    Banco já configurado!
    END
    
    Wait Until Page Contains    Importar Dados
    Click Text    Importar Dados
    Wait Until Page Contains    Verificando webservice
    
    Run Keyword And Ignore Error       Wait Until Element Is Visible    ${btnNao}    15
    Run Keyword And Ignore Error       Click Element    ${btnNao}
    
    Wait Until Page Contains    Selecionar Filial    60
    Menu Options    Marcar Todas
    Sleep    1
    Menu Options    Continuar

    Wait Until Page Contains    Prosseguir sem importar O.S.    60
    Click Text    Prosseguir sem importar O.S.

    Wait Until Page Contains    Banco de dados gerado e baixado com sucesso!    120
    Click Text    Ok

    Sleep    2

    Activate Application    ${appPackage}
    Sleep    5
