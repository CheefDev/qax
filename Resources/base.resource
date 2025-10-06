*** Settings ***

Library    AppiumLibrary
Library    DateTime
Library    String

*** Variables ***

${webservice}      wshml.engeman.com/wsmauiportocel  
${saveButton}      //android.widget.ImageButton[@content-desc="Navigate up"] 

${menuSuperior}    //android.widget.ImageButton[@content-desc="Open navigation drawer"]
${menuOptions}     //android.widget.ImageView[@content-desc="More options"]
${btnVoltar}       android=UiSelector().description("Navigate up")
${btnSalvar}       android=UiSelector().description("Navigate up")
${message}         //android.widget.TextView[@resource-id="android:id/message"]
${appPackage}      com.engemanmaui.portocel


*** Keywords ***


Iniciar Sessão
    [Arguments]    ${appName}     ${appPath}    ${noReset}
    Open Application    http://localhost:4723
    ...            platformName=Android
    ...            automationName=UIAutomator2
    ...            app=${appPath}
    ...            autoGrantPermissions=true
    ...            noReset=${noReset}
    ...            autoDismissAlerts=true
    #...            enforce_xpath1=True
Click Salvar

    ${saveButton}    Set Variable    android=UiSelector().description("Navigate up")
    
    Wait Until Element Is Visible    ${saveButton}    20
    Click Element    ${saveButton}
    Sleep    1


Menu Superior
    [Arguments]    ${option_text}
    
    Sleep    1
    Wait Until Element Is Visible    ${menuSuperior}    15
    Click Element    ${menuSuperior}
    
    Wait Until Page Contains    ${option_text}
    Click Text    ${option_text}

Menu Options
    [Arguments]    ${option_text}

    Wait Until Element Is Visible    ${menuOptions}    15
    Click Element    ${menuOptions}
    
    Sleep    2
    Click Text    ${option_text}    

Campo Pesquisa
    [Arguments]    ${locator}    ${elementPosition}

    Click Element    ${locator}
    Wait Until Page Contains    Pesquisa
    Click Element    //android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ImageView[1]
    Sleep    1
    Run Keyword And Continue On Failure    
    ...    Click Element    //androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[${elementPosition}]/android.view.ViewGroup

Descer Tela
    
    Swipe    ${486}    ${1982}    ${486}    ${954}

Navegar Menu Principal
    ${continue}    Set Variable    True

    WHILE    ${continue} == True
        
        Click Salvar

        ${status}=    Run Keyword And Return Status     Wait Until Element Is Visible   ${btnSalvar}
        
        IF    ${status} == False 
            
            ${continue}    Set Variable    False    

        END
 
    END
    
    Remover Notificação
    
Campo Data
    [Arguments]    ${locator}    ${subtract}
    
    Click Element    ${locator}
    ${dateTime}=       Get Current Date    result_format=%H:%M
    ${hour}=           Get Current Date    result_format=%H
    ${minutes}=        Get Current Date    result_format=%M
    ${date}=           Get Current Date    result_format=%d/%m/%Y
    ${day}=            Get Current Date    result_format=%d
    ${month}=          Get Current Date    result_format=%m
    ${year}=           Get Current Date    result_format=%Y
    
    Log To Console     ${date}
    Log To Console     ${dateTime}
    
    
    IF    ${subtract} == True
        
        #Click no campo de Horas a partir do texto ":" já que os minutos são provaveis de mudar durante a execução
        Click Text    :
        
        #Acessar o campo Minutos pela localização a partir do Label
        ${location}         Get Element Location    android=UiSelector().text("Minutos")
        ${offset}           Set Variable    100
        ${newY}             Evaluate       ${location['y']} + ${offset}
        ${campoMinutes}     Set Variable   //android.widget.EditText[@text="${minutes}"]
        @{newPosition}      Create List    ${location['x']}    ${newY}
        Tap With Positions    500          ${newPosition}
        
        ${15}    Set Variable    15
        ${0}     Set Variable    0
        ${newMinutes}=    Evaluate    ${minutes} - 10
        
        IF    ${newMinutes} > ${15}
            
            ${newMinutes}    Set Variable    ${15}
            
        END
        
        IF    ${newMinutes} < ${0}
            
            ${newMinutes}    Set Variable    ${0}
            
        END
        
        
        ${selectMinutes}    Set Variable    //android.widget.TextView[@resource-id="android:id/text1" and @text="${newMinutes}"]
        
        Click Element    ${selectMinutes}
        Sleep    1
    END
    
    Wait Until Element Is Visible   //*[contains(@text,"OK")] 
    Click Text     OK

Coleta Acumulativa
    [Arguments]    ${incremento}    ${defeito}=${False}
    
    ${aplicacao}           Get Text          android=UiSelector().className("android.widget.EditText").instance(0)
    ${pontoControle}       Get Text          android=UiSelector().className("android.widget.EditText").instance(1)
    ${stringOriginal}      Get Text          android=UiSelector().textContains("Valor")
    ${campoColeta}         Set Variable      android=UiSelector().className("android.widget.EditText").instance(3)
    ${sDefeito}            Set Variable      android=UiSelector().className("android.widget.ImageView").instance(10)
    
    IF    ${defeito} == True
        
        Campo Pesquisa    ${sDefeito}    1
        Click Salvar
        Wait Until Page Contains    Consultando limite de desvio
        Wait Until Page Contains    Coletas Acumulativas
        Log To Console              \nDefeito Selecionado Para o Ponto de Controle ${pontoControle}\n
    
        ELSE
            #Extrair do label o valor da última coleta e trocar , por . para permitir o cálculo.
            ${parts}              Split String      ${stringOriginal}
            ${valor}              Set Variable      ${parts}[3]
            ${valor}              Remove String     ${valor}     )
            ${valor}              Remove String     ${valor}     .
            Log To Console        \n${parts}[3] -> ${valor}\n
            
            ${newValor}    Evaluate    ${valor} + ${incremento}
            
            
            Click Element     ${campoColeta}
            Input Text        ${campoColeta}    ${newValor}
            Click Salvar
            
            IF    ${newValor} < ${valor}
                
                Wait Until Page Contains    Deseja inserir um 'Valor' inferior ao da coleta anterior?
                Click Text                  Sim
                Wait Until Page Contains    Coletas Acumulativas
                Set Test Message            Informada Virada de Medidor!\n Aplicação: ${aplicacao}\n Ponto de Controle: ${pontoControle}\n Valor: ${valor} -> ${newValor}
            END
        
            Wait Until Page Contains        Consultando limite de desvio
        
            Wait Until Page Contains        Coletas Acumulativas
            Log To Console                  Coleta registrada:\n Aplicação: ${aplicacao}\n Ponto de Controle: ${pontoControle}\n Valor: ${valor} -> ${newValor}
    
    END
    
Coleta Tendencia
    [Arguments]    ${incremento}
    
    ${aplicacao}           Get Text          android=UiSelector().className("android.widget.EditText").instance(0)
    ${pontoControle}       Get Text          android=UiSelector().className("android.widget.EditText").instance(1)
    ${stringOriginal}      Get Text          android=UiSelector().textContains("Valor")
    ${campoColeta}         Set Variable      android=UiSelector().className("android.widget.EditText").instance(4)
    
    #Extrair do label o valor da última coleta e trocar , por . para permitir o cálculo.
    ${parts}               Split String      ${stringOriginal}
    ${valor}               Set Variable      ${parts}[3]
    ${valor}               Remove String     ${valor}    )
    ${valor}               Replace String    ${valor}    ,    .
    
    ${newValor}    Evaluate    ${valor} + ${incremento}
    
    Click Element     ${campoColeta}
    Input Text        ${campoColeta}    ${newValor}
    Click Salvar
    Wait Until Page Contains    Coleta Tendência
    Log To Console              Coleta registrada:\n Aplicação: ${aplicacao}\n Ponto de Controle: ${pontoControle}\n Valor: ${valor} -> ${newValor}

Remover Notificação
    
    Swipe    ${246}    ${280}    ${810}    ${280}    200

Preencher Rota de Coleta
    
    ${labelSuperior}    Set Variable             android=UiSelector().textContains("Rota de Coleta").instance(0)
    Wait Until Element Is Visible        ${labelSuperior}
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
    
Descartar Alterações
    
    Menu Options    Descartar Alterações
