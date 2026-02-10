*** Settings ***

Library    AppiumLibrary
Library    Process

Resource    ../Resources/base.resource


*** Test Cases ***

Abrir Tela Principal
    [Tags]    Sessao
    
    Iniciar Sessão    ${appName}    C:\\QAx\\projects\\Maui\\com.engemanmaui.${appName}.apk    true
    Start Screen Recording    1200s
    Sleep    10
    #Stop Screen Recording
