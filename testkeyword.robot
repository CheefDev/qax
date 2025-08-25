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

Abrir Tela Principal

    Iniciar Sessão    Portocel    C:\\QAx\\projects\\maui\\engemanmaui.apk    true
Test Rota de Coleta
    
    
  #//*[contains(text(),'ABC')]

    
    ${list}      Set Variable    //*[contains(@text, "Ponto Controle")]
    FOR    ${item}    IN    ${list}
        
        
        ${parent}     Set Variable    ${item}/parent::*
        ${sibling}    Set Variable    ${item}/following-sibling::android.widget.TextView[3]
        ${text}       Get Element Attribute   ${sibling}    text
        Log To Console    \n${text}\n
        
        ${parts}               Split String             ${text}
        ${valor}               Set Variable             ${parts}[3]
        ${valor}               Remove String            ${valor}    )
        ${valor}               Replace String           ${valor}    ,    ${SPACE}
        
        ${partsValor}          Split String    ${valor}
        ${valor}    Set Variable    ${partsValor}[0]
        Log To Console    \n${valor}\n
        
        ${newValor}    Evaluate    ${valor} + 1
       
        Log To Console    \n${newValor}\n

        ${bounds}           Get Element Attribute    ${item}    bounds
        ${bounds}           Replace String    ${bounds}    [    ${SPACE}
        ${bounds}           Replace String    ${bounds}    ]    ${SPACE}
        ${bounds}           Replace String    ${bounds}    ,    ${SPACE}
        @{parts}            Split String      ${bounds}
        Log To Console    \nx:${parts}[0] y:${parts}[1]\n
        Log To Console    \nx:${parts}[2] y:${parts}[3]\n
        
        ${startY}        Convert To Number    ${parts}[3]
        ${endY}          Convert To Number    ${parts}[1]
        ${centerY}       Evaluate        ${startY} + ${endY}
        ${centerY}       Evaluate        ${centerY} / 2

        Log To Console    Centered Y: ${centerY}
        
        #Encontrar o campo abaixo do label e verificar se tem valor
        ${campoY}    Evaluate    ${centerY} + 80
        ${campoY}    Convert To Integer     ${campoY}
        @{first_finger_position}    Create List    300    ${campoY}
        @{positions}    Create List    ${first_finger_position}
        Tap With Positions    100    ${first_finger_position}
        Tap With Positions    100    ${first_finger_position}
        Sleep    1
        ${active_element}     Set Variable     //android.widget.EditText[@text=""]
        #Input Text     ${active_element}        ${newValor} 
          
        #Se tiver inserido ao menos 1 valor e todos estão preenchidos é feito o scroll
        #Se todos já tem valor antes do scroll e da inserção a rota está completa
        

    END

#Escolhe um locator instance 0
#Olha dentro se tem o text Valor
#Se não tiver incrementa a instance e roda denovo
#Se tiver, verifica se o campo valor está vazio
#Calcula o valor, preenche e incrementa o instance
#Se o instance tiver fora da range desce a tela
#Se a tela tiver no final Salva


Test Date Time
    Skip
    ${campo}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(2) 
    Campo Data    ${campo}    True

    ${campo}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(4)
    Campo Data    ${campo}    False
    
    ${campo}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(6)
    Campo Data   ${campo}    False

    Navegar Menu Principal

    