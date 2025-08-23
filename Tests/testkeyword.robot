*** Settings ***

Library    AppiumLibrary
Library    Process
Library    DateTime
Library    String
Library     ../Resources/function.py

Resource    ../Resources/base.resource


*** Test Cases ***


Abrir Tela Principal

    Iniciar Sessão    Portocel    C:\\QAx\\projects\\Maui\\com.engemanmaui.portocel.apk    true

Test Rota de Coleta
    
    ${appium_library_instance}=    BuiltIn.Get Library Instance    AppiumLibrary
    ${driver}=    Set Variable    ${appium_library_instance}._current_application()
    
  
    @{list}      Get Webelements     android=UiSelector().textContains("Valor")

    FOR    ${item}    IN    @{list}
        
        ${text}      Get Element Attribute    ${item}    text
        ${parent}    Set Variable    ${item}/parent::* 
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
        Input Text     ${active_element}        ${newValor} 
          
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

Teste Coleta Acumulativa
    Skip
    Coleta Acumulativa    50   
    

Test Date Time
    Skip
    ${campo}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(2) 
    Campo Data    ${campo}    True

    ${campo}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(4)
    Campo Data    ${campo}    False
    
    ${campo}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(6)
    Campo Data    ${campo}    False

