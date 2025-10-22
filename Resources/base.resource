*** Settings ***

Library    AppiumLibrary
Library    DateTime
Library    String
Library    Collections

*** Variables ***

${appName}    agrana
${webservice}      wshml.engeman.com/wsmaui${appName}  
${saveButton}      //android.widget.ImageButton[@content-desc="Navigate up"] 

${menuSuperior}    //android.widget.ImageButton[@content-desc="Open navigation drawer"]
${menuOptions}     //android.widget.ImageView[@content-desc="More options"]
${btnVoltar}       android=UiSelector().description("Navigate up")
${btnSalvar}       android=UiSelector().description("Navigate up")
${message}         //android.widget.TextView[@resource-id="android:id/message"]
${appPackage}      com.engemanmaui.${appName}
${deviceName}      emulator-5554    #21151FDF60007B
${usbMode}         False
#Configurações Gerais
#N - Nada
#B - Bloquear
#A - Avisar

#Config Gerais -> Geral -> Ordem De Serviço -> Segurança
${cfgMaterialNaoRelacionadoAplic}     N
${cfgFuncOutroSetor}                  B
${cfgFuncOutraFilial}                 B
${cfgFuncNaoQualificado}              B
${cfgFuncOutroCargo}                  B
${cfgFuncForaDaEscala}                B
${cfgAgrupamentoDivergAplic}          B
${cfgFuncAntesDataProg}               A    
${cfgAplicJaPossuiOS}                 N
${cfgAplicNaGarantia}                 A
${cfgAtDataManutencao}                N
${cfgPlanoNaoRelacAplicCont}          N
${cfgFuncQualifVencida}               A
${cfgFuncAntDataProg}                 A
${cfgPlanejHrsSuperiorAPrev}          N
${cfgPlanejHrsInferiorAPrev}          N
${cfgLimiteAlocacaoMaoDeObra}         11
${cfgDataParouInferorDataProg}        A
${cfgFechVerifAplicParouFuncionou}    N
${cfgFechOSReqPendente}               N
${cfgRegMatSMapeamento}               A
${cfgExigeMotLib}                     S
${cfgPerAvalOSdeSS}                   S
${cfgFecharServNExec}                 A
${cfgFecMatSemQuant}                  A
${cfgFecMatAdSemQuant}                A
${cfgFecMatSemAlm}                    A

#Configurações Gerais -> Dispositivos Móveis -> Segurança

${cfmMultiEmp}                True
${cfmUserNaAssinatura}        True
${cfmImportaAnexos}           True

#As Duas são a mesma configuração, porém há opção para bloquear só ao fechar ou liberar.
${cfmFecharSemDataTermino}     B
${cfmLiberarSemDataTermino}    N


${cfmFecharOSSemMidia}         B
${cfmLiberarOSSemMidia}        B
${cfgFechFuncPrev}             A
#Config Limite de Variação Mobile

${cfmLimiteAcumulativa}       10
${cfmLimiteTendencia}         10

${cfmImportObsPlano}          True


*** Keywords ***


Iniciar Sessão
    [Arguments]    ${appName}     ${appPath}    ${noReset}
    Open Application    http://localhost:4723
    ...            platformName=Android
    ...            automationName=UIAutomator2
    ...            app=${appPath}
    ...            deviceName=${deviceName}
    ...            autoGrantPermissions=true
    ...            noReset=${noReset}
    ...            autoDismissAlerts=true
    #...           enforce_xpath1=True
    
    IF    $deviceName == '21151FDF60007B'
        ${usbMode}    Set Variable    True
        
    END
    Log To Console    Device: ${deviceName} USBMode: ${usbMode}

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
    
    ${menuOptions}     Set Variable    //android.widget.ImageView[@content-desc="More options"]

    Wait Until Element Is Visible    ${menuOptions}    15
    Click Element    ${menuOptions}
    
    Wait Until Page Contains    ${option_text}
    Click Text    ${option_text}    

Campo Pesquisa
    [Arguments]    ${locator}    ${text}=1
    
    ${primeiroItem}        Set Variable    android=UiSelector().className("android.view.ViewGroup").instance(17)
    ${cFiltroPesquisa}     Set Variable    android=UiSelector().className("android.widget.EditText")
    ${btnPesquisar}        Set Variable    android=UiSelector().className("android.widget.ImageView").instance(2)
    
    
    Click Element    ${locator}
    Wait Until Page Contains    Pesquisa
    ${nomeCampo}    Get Element Attribute    android=UiSelector().textContains("Pesquisa")    text
    ${nomeCampo}    Remove String    Pesquisa -
    ${parts}    Split String    ${nomeCampo}
       

    IF    '${text}' == '1'
        #Seleciona o primeiro item
        Click Element    ${btnPesquisar}
        Wait Until Page Does Not Contain    Carregando    30
        Run Keyword And Ignore Error    Click Element  ${primeiroItem}
    ELSE
        
        ${visivel}=    Run Keyword And Return Status    Page Should Contain Text    ${text}
    
    IF    ${visivel}
        
        ${item}    Set Variable    android=UiSelector().textContains("${text}")
        ${textoItem}    Get Element Attribute    ${item}    text

        Click Text    ${text}
        Log To Console    \nSelecinado: ${textoItem}\n
        Sleep    5
    
    ELSE
        
        Input Text    ${cFiltroPesquisa}    ${text}
        Click Element    ${btnPesquisar}
        Wait Until Page Does Not Contain    Carregando
        ${item}    Set Variable    android=UiSelector().textContains("${text}").instance(1)
        ${textoItem}    Get Element Attribute    ${item}    text

        Click Element    ${item}
        Log To Console    \nSelecinado: ${textoItem}\n
        Sleep    5
    END

    END
  

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
    
    
    
        
        #Click no campo de Horas a partir do texto ":" já que os minutos são provaveis de mudar durante a execução
        Wait Until Page Contains    :
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
        
        
        IF     ${subtract}
            ${newMinutes}    Evaluate    ${minutes} - 1
            ELSE    
            
            ${newMinutes}    Evaluate    ${minutes} + 10 
        END
        
        IF    ${newMinutes} > 15
            Swipe    ${428}    ${1467}    ${450}    ${346}
            
        END
        IF    ${newMinutes} > 25
            Swipe    ${428}    ${1467}    ${450}    ${346}
            
        END
        IF    ${newMinutes} > 35
            Swipe    ${428}    ${1467}    ${450}    ${346}
            
        END
        IF    ${newMinutes} > 45
            Swipe    ${428}    ${1467}    ${450}    ${346}
            
        END
        IF    ${newMinutes} > 55
            Swipe    ${428}    ${1467}    ${450}    ${346}
            
        END
        ${selectMinutes}    Set Variable    //android.widget.TextView[@resource-id="android:id/text1" and @text="${newMinutes}"]
       
        
        Click Element    ${selectMinutes}
        Sleep    1
    
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
            
            
            Inserir Texto      ${campoColeta}    ${newValor}
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
    
    
    Inserir Texto        ${campoColeta}    ${newValor}
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
        #Log To Console    \nCampos na Tela: ${camposNaTela}\n
        
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
                #Log To Console    \n${iText}\n
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
                    
                    Inserir Texto    ${campo}    ${newValor}
                    
                    #Log To Console    \n${newValor}\n
                    ${coletas}    Evaluate    ${coletas} + 1
                    Log To Console    \n${iText}\n
                    Log To Console    ${valor} -> ${newValor}
                    Log To Console    \nColetas: ${coletas}\n
                END
                
                
            
        END
        Swipe    ${450}    ${2000}    ${450}    ${1200}    1000
        Sleep    1
    END

Preencher Coleta Unificada
    
    ${labelSuperior}    Set Variable             android=UiSelector().textContains("reg(s)").instance(0)
    Wait Until Element Is Visible        ${labelSuperior}
    ${labelText}        Get Element Attribute    ${labelSuperior}    text

    ${parts}            Split String             ${labelText}
    
    ${regCount}         Set Variable    ${parts}[4]
    ${coletas}          Set Variable    0


    Log To Console    \nNúmero de Registros na Rota: ${regCount}\n    
    WHILE    ${coletas} < ${regCount}
        
        ${camposNaTela}    Get Matching Xpath Count       xpath=(//android.widget.TextView[contains(@text,"Valor")])
        Log To Console    \nCampos na Tela: ${camposNaTela}\n
        ${jaPreenchidos}    Set Variable    0
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

                #Log To Console    \n${iText}\n
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
                    #Click Element    ${campo}
                    Inserir Texto    ${campo}    ${newValor}

                    #Log To Console    \n${newValor}\n
                    ${coletas}    Evaluate    ${coletas} + 1
                    Log To Console    \n${iText}\n
                    Log To Console    ${valor} -> ${newValor}
                    Log To Console    \nColetas: ${coletas}\n

                ELSE
                    ${jaPreenchidos}    Evaluate    ${jaPreenchidos} + 1
                END
                IF     ${jaPreenchidos} >= ${camposNaTela}
                    Click Salvar
                    Wait Until Page Contains    Registros
                    RETURN    True
                END
            
        END
        Swipe    ${450}    ${2000}    ${450}    ${1200}    1000
        Sleep    1
    END
    Click Salvar
    Wait Until Page Contains    Registros
    RETURN    True

Descartar Alterações
    
    Menu Options    Descartar Alterações

Anexo SS
    
    ${newAnexoButton}        Set Variable     //android.widget.Button
    ${optAnexoSimples}       Set Variable     //android.widget.TextView[@resource-id="android:id/text1" and @text="Anexo"]
    ${optAnexoMultiplo}      Set Variable     //android.widget.TextView[@resource-id="android:id/text1" and @text="Anexos múltiplos"]
    ${btnSelecionarAnexo}    Set Variable     android=UiSelector().text("Selecionar Anexo")
    ${btnCamera}             Set Variable     android=UiSelector().resourceId("com.android.camera2:id/shutter_button")
    ${btnDone}               Set Variable     android=UiSelector().resourceId("com.android.camera2:id/done_button")
    
    

    Menu Options    Anexo
    Wait Until Page Contains    Listagem de Anexo
    
    Click Element     ${newAnexoButton}
    Wait Until Page Contains    Inserir Anexo

    Click Element    ${optAnexoSimples}
    Wait Until Element Is Visible    ${btnSelecionarAnexo}

    Click Element    ${btnSelecionarAnexo}
    Wait Until Element Is Visible    android=UiSelector().resourceId("${appPackage}:id/parentPanel")
    Click Element    android=UiSelector().text("Câmera")

    Wait Until Element Is Visible    ${btnCamera}
    Click Element    ${btnCamera}

    Wait Until Element Is Visible    ${btnDone}
    Click Element    ${btnDone}

    Click Salvar
    
    
    Click Salvar
    

    Wait Until Page Contains    Solicitação de Serviço

Cadastro OS Basica
    
    Wait Until Page Contains    Cadastro da O.S.

    Swipe    ${325}    ${1751}    ${325}    ${505}

    ${searchTipoManut}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(9)
    ${searchSetor}        Set Variable    android=UiSelector().className("android.widget.ImageView").instance(12)

    Campo Pesquisa    ${searchTipoManut}    1
    Wait Until Element Is Visible    ${searchSetor}
    Campo Pesquisa    ${searchSetor}    1
    
    Click Salvar
    ${msg}    Set Variable    android=UiSelector().resourceId("android:id/message")
    Wait Until Page Contains    validada no servidor com sucesso!    30
    
    ${textoMsg}    Get Element Attribute    ${msg}    text
    ${parts}                   Split String             ${textoMsg}
    ${codigoOS}               Set Variable             ${parts}[4]
    Click Element    android=UiSelector().resourceId("android:id/button2")
    Log To Console    \nOS Gerada: ${codigoOS}
    Wait Until Page Contains    Solicitação de Serviço    20
    Click Salvar

Exportar Dados Pendentes

    ${text_present}=    Run Keyword And Return Status    Page Should Contain Text    exportar
    IF    ${text_present}
        Click Text    exportar
        Wait Until page Contains    Exportando
        Wait Until Page Contains    Processo concluído com sucesso!    120
        Click Text    Ok
    ELSE
        Log    Sem Dados para exportar
    END

    ${text_present}=    Run Keyword And Return Status    Page Should Contain Text    exportar
    IF    ${text_present}
        Click Text    exportar
        Wait Until page Contains    Exportando
        Wait Until Page Contains    Processo concluído com sucesso!    120
        Click Text    Ok
    ELSE
        Log    Sem Dados para exportar
    END

Mensagem
    [Arguments]    ${text}    ${option}

    ${visible}=    Run Keyword And Return Status    Wait Until Page Contains    ${text}    2
    ${mensagem}=    Get Element Attribute    android=UiSelector().resourceId("android:id/message")    text
    
    IF    ${visible}
        
        ${button}    Set Variable    //android.widget.Button[@text="${option}"]
        Click Element    ${button}
        Log To Console    \n${mensagem} -> ${option}\n
        RETURN    ${True}
        ELSE
            RETURN    ${False}
    END

Mensagem Configuracao
    [Arguments]    ${config}    ${mensagem}    ${opcao}
    #Permissão para Cadastro de Funcionários fora da escala de trabalho
    IF    "${config}" != "N"
        
        IF    "${config}" == "A"
        
        Mensagem    ${mensagem}    Sim
        
        ELSE IF    "${config}" == "B"
        
            ${bloqueado}    Run Keyword And Return Status   Mensagem    ${mensagem}    Ok
            IF    ${bloqueado}
                Menu Options    Descartar Alterações
                Click Salvar
                Wait Until Page Contains    O.S.
                Pass Execution    Funcionário fora da escala, Cadastro bloqueado por uma Configuração Geral!
            END
            
            
        END
    END

Anexo Servico
    [Arguments]    ${servico}
    
    ${newAnexoButton}        Set Variable     //android.widget.Button
    ${optAnexoSimples}       Set Variable     //android.widget.TextView[@resource-id="android:id/text1" and @text="Anexo"]
    ${optAnexoMultiplo}      Set Variable     //android.widget.TextView[@resource-id="android:id/text1" and @text="Anexos múltiplos"]
    ${btnSelecionarAnexo}    Set Variable     android=UiSelector().text("Selecionar Anexo")
    ${btnCamera}             Set Variable     android=UiSelector().resourceId("com.android.camera2:id/shutter_button")
    ${btnDone}               Set Variable     android=UiSelector().resourceId("com.android.camera2:id/done_button")
    
    Menu Options    Anexo
    Wait Until Page Contains    Listagem de Anexo
    
    Click Element     ${newAnexoButton}
    Wait Until Page Contains    Inserir Anexo

    Click Element    ${optAnexoSimples}
    Wait Until Element Is Visible    ${btnSelecionarAnexo}

    Click Element    ${btnSelecionarAnexo}
    Wait Until Element Is Visible    android=UiSelector().resourceId("${appPackage}:id/parentPanel")
    Click Element    android=UiSelector().text("Câmera")

    Wait Until Element Is Visible    ${btnCamera}
    Click Element    ${btnCamera}

    Wait Until Element Is Visible    ${btnDone}
    Click Element    ${btnDone}

    Click Salvar
    Wait Until Page Contains      Listagem    20   
    Click Salvar
    Wait Until Page Contains      Descrição Geral    
    Click Salvar
    Wait Until Page Contains    reg(s)  

Long Click   
    [Arguments]    ${element}    ${duration}=1000

    ${element_rect}=    Get Element Rect    ${element}

        # Get the top-left coordinates and dimensions from the returned dictionary
        ${x}=    Get From Dictionary    ${element_rect}    x
        ${y}=    Get From Dictionary    ${element_rect}    y
        ${width}=    Get From Dictionary    ${element_rect}    width
        ${height}=    Get From Dictionary    ${element_rect}    height

        # Calculate the center coordinates
        ${center_x}=    Evaluate    ${x} + ${width} / 2
        ${center_y}=    Evaluate    ${y} + ${height} / 2
        @{positions}    Create List    ${center_x}    ${center_y}   
        
        Tap With Positions    ${1000}    ${positions}

Inserir Texto
    [Arguments]    ${locator}    ${text}
    
    Click Element    ${locator}

    IF    ${usbMode}
      
        Input Text Into Current Element    ${text}
        Hide Keyboard

    ELSE
        
        Input Text    ${locator}    ${text}
        
    END
    
