*** Settings ***

Library    AppiumLibrary
Library    Process

Resource    ../Resources/base.resource
Resource    ../Resources/cfgMobile.resource
Resource    ../Resources/cfgGeral.resource

*** Test Cases ***

Abrir Tela Principal
    [Tags]    Sessao
    
    Iniciar Sessão    ${appName}    C:\\QAx\\projects\\Maui\\${appPackage}.apk    true


