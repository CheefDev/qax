*** Settings ***

Library    AppiumLibrary
Library    Process
Library    DateTime
Library    String

Resource    ../Resources/base.resource

*** Variables ***

${webservice}      wshml.engeman.com/wsmauiportocel  
${saveButton}      //android.widget.ImageButton[@content-desc="Navigate up"] 

${menuSuperior}    //android.widget.ImageButton[@content-desc="Open navigation drawer"]
${menuOptions}     //android.widget.ImageView[@content-desc="More options"]
${btnVoltar}       android=UiSelector().description("Navigate up")
${btnSalvar}       android=UiSelector().description("Navigate up")
${message}         //android.widget.TextView[@resource-id="android:id/message"]
${appPackage}      com.engemanmaui.portocel


*** Test Cases ***

Test String
    ${original_string}    Set Variable   Valor (Última Leitura: 100,000)
    ${stripped_string}    Set Variable   Valor (Última Leitura: 100,000)

    ${parts}    Split String    ${original_string}


    ${valor}      Set Variable    ${parts}[3]
    ${valor}=     Replace String    ${valor}    ,000)    .000
    Log To Console    ${parts}[3]
    Log To Console    ${valor}
    ${newValor}=    Evaluate    ${valor} + ${valor}
    Log To Console    ${newValor}
    

Abrir Tela Principal

    Iniciar Sessão    Portocel    C:\\QAx\\projects\\Maui\\com.engemanmaui.portocel.apk    true

Test Date Time
    
    ${campo}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(2) 
    Campo Data    ${campo}    True

    ${campo}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(4)
    Campo Data    ${campo}    False
    
    ${campo}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(6)
    Campo Data   ${campo}    False

    ${original_string}    Set Variable   Valor (Última Leitura: 100,000)
    ${stripped_string}    Set Variable   Valor (Última Leitura: 100,000)

    ${parts}    Split String    ${original_string}

    Log To Console    ${parts}[0]
    Log To Console    ${parts}[1]
    Log To Console    ${parts}[2]
    Log To Console    ${parts}[3]
    Log To Console    ${parts}[4]
    