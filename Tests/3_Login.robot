*** Settings ***

Library    AppiumLibrary
Library    Process

Resource    ../Resources/base.resource
Resource    ../Resources/cfgMobile.resource
Resource    ../Resources/cfgGeral.resource


*** Test Cases ***

Logar no app
    [Tags]    Login
    ${loginField}      Set Variable    android=UiSelector().className("android.widget.EditText").instance(0)
    ${passField}       Set Variable    android=UiSelector().className("android.widget.EditText").instance(1)
    ${buttonEntrar}    Set Variable    //android.widget.TextView[@text="Entrar"]
    
    Wait Until Element Is Visible    ${loginField}    30
    Clear Text        ${loginField}
    Input Text        ${loginField}    engeman
    Clear Text        ${passField}
    Input Password    ${passField}     engeman
    
    Click Element    ${buttonEntrar}

    Wait Until Page Contains    Selecionar Filial    10

    Click Text   01
    Wait Until Page Contains    Início    10
    Remover Notificação

