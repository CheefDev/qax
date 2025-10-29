*** Settings ***

Library    AppiumLibrary
Library    Process

Resource    ../Resources/base.resource
Resource    ../Resources/cfgMobile.resource
Resource    ../Resources/cfgGeral.resource

*** Variables ***

${appName}         Maui
${webservice}      10.12.1.5/ws${appName}
${saveButton}      //android.widget.ImageButton[@content-desc="Navigate up"] 

#${menuSuperior}    //android.widget.ImageButton[@content-desc="Open navigation drawer"]
#${menuOptions}     //android.widget.ImageView[@content-desc="More options"]
${btnVoltar}       android=UiSelector().description("Navigate up")
${btnSalvar}       android=UiSelector().description("Navigate up")
${message}         //android.widget.TextView[@resource-id="android:id/message"]
${appPackage}      com.engemanmaui.padrao
${gerarBanco}      ${null}
${idMobile}        TESTEAUTOMATIZADO


*** Test Cases ***

Abrir Tela Principal
    [Tags]    Sessao
    Iniciar Sessão    ${appName}    C:\\QAx\\projects\\Maui\\${appPackage}.apk    true


