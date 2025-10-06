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
    
    Teste
    
  
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

*** Keywords ***


Teste
    
    ${labelSuperior}    Set Variable             android=UiSelector().textContains("Rota de Coleta").instance(0)
    ${labelText}        Get Element Attribute    ${labelSuperior}    text

    ${parts}            Split String             ${labelText}
    
    ${regCount}         Set Variable    ${parts}[6]
    ${coletas}          Set Variable    0


    Log To Console    \nNúmero de Registros na Rota: ${regCount}\n    
    WHILE    ${coletas} < ${regCount}
        
        ${camposNaTela}    Get Matching Xpath Count       xpath=(//android.widget.TextView[contains(@text,"Valor")])
        Log To Console    \nCampos na Tela: ${camposNaTela}\n
        
        FOR    ${i}    IN RANGE    1    ${camposNaTela}+1
                
                ${item}    Set Variable         xpath=(//android.widget.TextView[contains(@text,"Valor")])[${i}]
                
                
                ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${item}
                
                IF    $is_visible == False
                    Swipe    ${450}    ${2000}    ${450}    ${1750}    1000
                    Sleep    0.5
                    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${item}
                END
                
                
                ${bounds}    Get Element Attribute    ${item}     bounds
                ${campo}    Set Variable        ${item}/following-sibling::android.widget.EditText[1]
                #${textValor}    Set Variable    ${item}/following-sibling::android.widget.TextView[3]
                ${iText}          Get Element Attribute    ${item}    text
                Log To Console    \n${iText}\n
                #Log To Console    ${bounds}
                ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${campo}
                
                IF    $is_visible == False
                    Swipe    ${450}    ${2000}    ${450}    ${1750}    1000
                    Sleep    0.5
                    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${item}
                END
                ${textoCampo}    Get Element Attribute    ${campo}    text
                
                IF    $textoCampo == ""
                    ${parts}               Split String             ${iText}
                    ${valor}               Set Variable             ${parts}[3]
                    ${valor}               Remove String            ${valor}    )
                    ${valor}               Replace String           ${valor}    ,    ${SPACE}
                        
                    ${partsValor}          Split String    ${valor}
                    ${valor}    Set Variable    ${partsValor}[0]
                    #Log To Console    \n${valor}\n
                        
                    ${newValor}    Evaluate    ${valor} + 1
                    Click Element    ${campo}
                    Input Text    ${campo}    ${newValor}

                    #Log To Console    \n${newValor}\n
                    ${coletas}    Evaluate    ${coletas} + 1
                    Log To Console    ${valor} -> ${newValor}
                    Log To Console    \nColetas: ${coletas}\n
                END
                
                
            
        END
        Swipe    ${450}    ${2000}    ${450}    ${1200}    1000
        Sleep    1
    END
    


Preenche Valor
    [Arguments]    ${labelValor}
        
    ${campoValor}    Set Variable    ${labelValor}/following-sibling::android.widget.EditText[1]
    ${text}          Get Element Attribute   ${labelValor}    text
    ${inputTest}     Get Element Attribute   ${campoValor}    text
    Log To Console    \n${text}\n
    Log To Console    \n${inputTest}\n
        
    ${parts}               Split String             ${text}
    ${valor}               Set Variable             ${parts}[3]
    ${valor}               Remove String            ${valor}    )
    ${valor}               Replace String           ${valor}    ,    ${SPACE}
        
    ${partsValor}          Split String    ${valor}
    ${valor}    Set Variable    ${partsValor}[0]
    Log To Console    \n${valor}\n
        
    ${newValor}    Evaluate    ${valor} + 1
       
    Log To Console    \n${newValor}\n
    
     IF    $inputTest == ""
            Click Element    ${campoValor}
            Input Text       ${campoValor}        ${newValor}
    END


Preenche Item Rota
    [Arguments]    ${item}
    ${tipo}    Get Element Attribute    ${item}    text
        
        
        ${parent}     Set Variable    ${item}/parent::*

        IF    $tipo == "Ponto Controle Tendência"
            
            ${sibling}    Set Variable    ${item}/following-sibling::android.widget.TextView[5]
            ${input}      Set Variable    ${item}/following-sibling::android.widget.EditText[1]

            ELSE
                ${sibling}    Set Variable    ${item}/following-sibling::android.widget.TextView[3]
                ${input}      Set Variable    ${item}/following-sibling::android.widget.EditText[1]
        END
        
        
        ${text}       Get Element Attribute   ${sibling}    text
        ${inputTest}    Get Element Attribute   ${input}    text
        Log To Console    \n${text}\n
        Log To Console    \n${inputTest}\n
        
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
        
        #Log To Console    \nx:${parts}[0] y:${parts}[1]\n
        #Log To Console    \nx:${parts}[2] y:${parts}[3]\n
        
        ${startY}        Convert To Number    ${parts}[3]
        ${endY}          Convert To Number    ${parts}[1]
        ${centerY}       Evaluate        ${startY} + ${endY}
        ${centerY}       Evaluate        ${centerY} / 2

        #Log To Console    Centered Y: ${centerY}
        
        #Encontrar o campo abaixo do label e verificar se tem valor
        IF    $inputTest == ""
            Click Element    ${input}
            Input Text     ${input}        ${newValor}
        END
        
         
          
        #Se tiver inserido ao menos 1 valor e todos estão preenchidos é feito o scroll
        #Se todos já tem valor antes do scroll e da inserção a rota está completa

Teste Rota
    
    #//*[contains(text(),'ABC')]
    ${listCount}      Get Matching Xpath Count    //*[contains(@text, "Valor")]

    Log To Console    \nItem Count: ${listCount}

    FOR    ${testCount}    IN RANGE    1    ${listCount}+1
        
        ${logTest}    Get Element Attribute    //*[contains(@text, "Valor")]    text    
        Log To Console     ${logTest},
    END
    
    Log To Console    \nCount: ${listCount}\n
    
    FOR    ${itemCount}    IN RANGE    1    ${listCount}
        
        Log To Console    \nItem ${itemCount}:\n
        
        ${itemPath}     Set Variable   (//android.widget.TextView[contains(@text, 'Valor')])[${itemCount}]
        #${textoItem}    Get Element Attribute    ${itemPath}    text
        
        Preenche Valor    ${itemPath}
        Click Element    ${itemPath}
    END
    #Escolhe um locator instance 0
    #Olha dentro se tem o text Valor
    #Se não tiver incrementa a instance e roda denovo
    #Se tiver, verifica se o campo valor está vazio
    #Calcula o valor, preenche e incrementa o instance
    #Se o instance tiver fora da range desce a tela
    #Se a tela tiver no final Salva
