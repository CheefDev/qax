*** Settings ***

Library    AppiumLibrary
Library    Process

Resource    ../Resources/base.resource


*** Test Cases ***


Abrir Tela Principal
    [Tags]    Sessao
    
    Iniciar Sessão    ${appName}    C:\\QAx\\projects\\Maui\\${appPackage}.apk    true
    Sleep    3