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

Rota de Coleta Unificada
    [Tags]    Cadastro    Coleta    Rota
    
    ${sPlanoRota}         Set Variable    android=UiSelector().className("android.widget.ImageView").instance(3)
    ${btnCarregarRota}    Set Variable    android=UiSelector().text("Carregar Aplicações")
    
    Voltar Para    Início
    
    Menu Superior    Rotas de Coletas
    Wait Until Page Contains    Rota de Coleta Unificada

    Click Text    Rota de Coleta Unificada
    Wait Until Element Is Visible    ${sPlanoRota}
    
    Remover Notificação
    Campo Pesquisa    ${sPlanoRota}
    Wait Until Page Contains    Configuração para Rota de Coleta
    
    Click Element    ${btnCarregarRota}
    Preencher Rota de Coleta

    Click Salvar
    Wait Until Page Contains    Configuração para Rota de Coleta    60
    
    Navegar Menu Principal

Cadastro Coleta Acumulativa
    [Tags]    Cadastro    Coleta
    ${btnNew}    Set Variable    android=UiSelector().className("android.widget.Button")
    
    Skip
    
    Remover Notificação
    Menu Superior    Coletas
    Wait Until Page Contains    Coleta Acumulativa
    
    Click Text       Coleta Acumulativa
    Wait Until Page Contains    Pesquisa - Aplicação - Coleta Acumulativa
    
    Click Element    android=UiSelector().className("android.view.ViewGroup").instance(15)
    Wait Until Element Is Visible    ${btnNew}
    Click Element    ${btnNew}
    Wait Until Page Contains    Última Leitura:

    Coleta Acumulativa    2

    Navegar Menu Principal

Cadastro Coleta Tendência
    [Tags]    Cadastro    Coleta
    ${btnNew}    Set Variable    android=UiSelector().className("android.widget.Button")
    
    
    Skip
    
    
    Menu Superior    Coletas
    Wait Until Page Contains    Coleta de Tendência
    
    Click Text       Coleta de Tendência
    Wait Until Page Contains    Pesquisa - Aplicação - Coleta Tendência
    
    Click Element    android=UiSelector().className("android.view.ViewGroup").instance(15)
    Wait Until Element Is Visible    ${btnNew}
    Click Element    ${btnNew}
    Wait Until Page Contains    Última Leitura:

    Coleta Tendencia    1

    Navegar Menu Principal

