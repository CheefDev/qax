*** Settings ***

Library    AppiumLibrary
Library    Process

Resource    ../Resources/base.resource

*** Variables ***

${appName}         Agrana
${webservice}      wshml.engeman.com/wsmaui${appName}
${saveButton}      //android.widget.ImageButton[@content-desc="Navigate up"] 

#${menuSuperior}    //android.widget.ImageButton[@content-desc="Open navigation drawer"]
#${menuOptions}     //android.widget.ImageView[@content-desc="More options"]
${btnVoltar}       android=UiSelector().description("Navigate up")
${btnSalvar}       android=UiSelector().description("Navigate up")
${message}         //android.widget.TextView[@resource-id="android:id/message"]
${appPackage}      com.engemanmaui.${appName}
${gerarBanco}      ${null}
${idMobile}        TESTEAUTOMATIZADO


*** Test Cases ***

Abrir Tela Principal
    [Tags]    Sessao
    Iniciar Sessão    ${appName}    C:\\QAx\\projects\\Maui\\${appPackage}.apk    true


Digitar Webservice
    [Tags]    Geração do Banco    Configuração
    ${cfgButton}    Set Variable     //androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[1]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ImageView[1]
    ${wsField}      Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[1]/android.widget.EditText
    ${lastField}    Set Variable     //android.widget.EditText[@text="Escolher"]
    ${check1}       Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[6]/android.widget.Switch
    ${check2}       Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[7]/android.widget.Switch
    
    Wait Until Page Contains    Build    10
    ${gerarBanco}    Run Keyword And Return Status    Page Should Not Contain Text  Login do Sistema
    
    
    IF    ${gerarBanco} == False
        Pass Execution    Banco já configurado!
    END
    Wait Until Element Is Visible    ${cfgButton}    20
    Click Element    ${cfgButton}
    

    Wait Until Element Is Visible    ${wsField}    20
    Clear Text    ${wsField}
    Input Text    ${wsField}    ${webservice}


ID Mobile
    [Tags]    Configuração    Geração do Banco
    
    
    IF    ${gerarBanco} == False   
    
        Pass Execution    Banco já configurado!
    END

    IF    $idMobile == ''    
    
        Click Salvar
        Skip
    END
    
    ${cIdMobile}    Set Variable    android=UiSelector().className("android.widget.EditText").instance(2)
    Click Element    ${cIdMobile}
    Clear Text       ${cIdMobile}
    Input Text       ${cIdMobile}    ${idMobile}

    Click Salvar
    Mensagem    Deseja realmente salvar as configurações com um ID diferente do ID gerado pelo sistema operacional?    Sim

Gerar Banco de Dados
    [Tags]    Geração do Banco
    
    ${btnNao}    Set Variable    //android.widget.Button[@resource-id="android:id/button2"]
    
    Wait Until Page Contains    Build    10
    
    ${gerarBanco}=    Run Keyword And Return Status    Page Should Not Contain Text  Login do Sistema 
    
    IF    ${gerarBanco} == False
        Pass Execution    Banco já configurado!
    END
    
    Wait Until Page Contains    Importar Dados
    Click Text    Importar Dados
    Wait Until Page Contains    Verificando webservice
    
    Run Keyword And Ignore Error       Wait Until Element Is Visible    ${btnNao}    15
    Run Keyword And Ignore Error       Click Element    ${btnNao}
    
    Wait Until Page Contains    Selecionar Filial    60
    Menu Options    Marcar Todas
    Sleep    1
    Menu Options    Continuar

    Wait Until Page Contains    Prosseguir sem importar O.S.    60
    Click Text    Prosseguir sem importar O.S.

    Wait Until Page Contains    Banco de dados gerado e baixado com sucesso!    120
    Click Text    Ok

    Sleep    2

    Activate Application    ${appPackage}
    Sleep    5

Logar no app
    [Tags]    Login
    ${loginField}      Set Variable    android=UiSelector().className("android.widget.EditText").instance(0)
    ${passField}       Set Variable    android=UiSelector().className("android.widget.EditText").instance(1)
    ${buttonEntrar}    Set Variable    //android.widget.TextView[@text="Entrar"]
    
    Wait Until Element Is Visible    ${loginField}    30
    Clear Text        ${loginField}
    Input Text        ${loginField}    engeman
    Clear Text        ${passField}
    Input Password    ${passField}     engeman
    
    Click Element    ${buttonEntrar}

    Wait Until Page Contains    Selecionar Filial    10

    Click Text   01
    Wait Until Page Contains    Notificações    10
    Remover Notificação

Rota de Coleta Unificada
    [Tags]    Cadastro    Coleta    Rota
    
    ${sPlanoRota}         Set Variable    android=UiSelector().className("android.widget.ImageView").instance(2)
    ${btnCarregarRota}    Set Variable    android=UiSelector().text("Carregar Aplicações")
    
    Menu Superior    Rotas de Coletas
    Wait Until Page Contains    Rota de Coleta Unificada

    Click Text    Rota de Coleta Unificada
    Wait Until Element Is Visible    ${sPlanoRota}

    Campo Pesquisa    ${sPlanoRota}
    Wait Until Page Contains    Configuração para Rota de Coleta
    
    Click Element    ${btnCarregarRota}
    Preencher Rota de Coleta

    Click Salvar
    Wait Until Page Contains    Configuração para Rota de Coleta    60
    
    Navegar Menu Principal

Cadastro Coleta Acumulativa
    [Tags]    Cadastro    Coleta
    ${btnNew}    Set Variable    android=UiSelector().className("android.widget.Button")
    
    Skip
    
    Remover Notificação
    Menu Superior    Coletas
    Wait Until Page Contains    Coleta Acumulativa
    
    Click Text       Coleta Acumulativa
    Wait Until Page Contains    Pesquisa - Aplicação - Coleta Acumulativa
    
    Click Element    android=UiSelector().className("android.view.ViewGroup").instance(15)
    Wait Until Element Is Visible    ${btnNew}
    Click Element    ${btnNew}
    Wait Until Page Contains    Última Leitura:

    Coleta Acumulativa    2

    Navegar Menu Principal

Cadastro Coleta Tendência
    [Tags]    Cadastro    Coleta
    ${btnNew}    Set Variable    android=UiSelector().className("android.widget.Button")
    
    
    Skip
    
    
    Menu Superior    Coletas
    Wait Until Page Contains    Coleta de Tendência
    
    Click Text       Coleta de Tendência
    Wait Until Page Contains    Pesquisa - Aplicação - Coleta Tendência
    
    Click Element    android=UiSelector().className("android.view.ViewGroup").instance(15)
    Wait Until Element Is Visible    ${btnNew}
    Click Element    ${btnNew}
    Wait Until Page Contains    Última Leitura:

    Coleta Tendencia    1

    Navegar Menu Principal



Cadastro OS Local
    [Tags]    Cadastro    OS
    
    ${sResponsavel}        Set Variable    android=UiSelector().className("android.widget.ImageView").instance(4)
    ${sSolicitante}        Set Variable    android=UiSelector().className("android.widget.ImageView").instance(7)
    ${Solicitacao}         Set Variable    //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText[4]
    ${editSolicitacao}     Set Variable    //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[4]/android.view.ViewGroup
    ${sFornecedor}         Set Variable    android=UiSelector().className("android.widget.ImageView").instance(11)
    ${sPlano}              Set Variable    android=UiSelector().className("android.widget.ImageView").instance(14)
    ${sTipoManut}          Set Variable    android=UiSelector().className("android.widget.ImageView").instance(9)
    ${sSetorExec}          Set Variable    android=UiSelector().className("android.widget.ImageView").instance(12)
    ${sAplicacao}          Set Variable    android=UiSelector().className("android.widget.ImageView").instance(15)
    ${sCentroCusto}        Set Variable    android=UiSelector().className("android.widget.ImageView").instance(18)
    
    ${btnOk}               Set Variable    //android.widget.Button[@resource-id="android:id/button2"]
    ${btnSim}              Set Variable    //android.widget.Button[@resource-id="android:id/button1"]
    ${newOSButton}         Set Variable    //android.widget.Button
    
        
    Menu Superior    Ordem de Serviço
    Wait Until Page Contains    O.S. Mobile

    Click Text    O.S. Mobile
    Wait Until Page Contains    Lista de O.S.

    
    
    Click Element    ${newOSButton}
    Wait Until Page Contains    Cadastro da O.S.

    Campo Pesquisa    ${sResponsavel}
    Wait Until Page Contains    Cadastro da O.S.

    Campo Pesquisa    ${sSolicitante}
    Wait Until Page Contains    Cadastro da O.S.

    Campo Pesquisa    ${sFornecedor}
    Wait Until Page Contains    Cadastro da O.S.

    Campo Pesquisa    ${sPlano}
    Wait Until Page Contains    Cadastro da O.S.
    
    Descer Tela
    Sleep    2
    Campo Pesquisa    ${sTipoManut}
    Wait Until Page Contains    Cadastro da O.S.

    Campo Pesquisa    ${sSetorExec}
    Wait Until Page Contains    Cadastro da O.S.

    Campo Pesquisa    ${sAplicacao}
    Wait Until Page Contains    Cadastro da O.S.

    Campo Pesquisa    ${sCentroCusto}
    Wait Until Page Contains    Cadastro da O.S.
    
    Click Element    ${saveButton}
    Wait Until Page Contains    Salvando registro

    ${msg}    Set Variable    android=UiSelector().resourceId("android:id/message")
    Wait Until Page Contains    validada no servidor com sucesso!    30
    
    ${textoMsg}    Get Element Attribute    ${msg}    text
    ${parts}                   Split String             ${textoMsg}
    ${codigoOS}               Set Variable             ${parts}[4]
    Click Element    ${btnOk}
    Log To Console    \nOS Gerada: ${codigoOS}
    
    Run Keyword And Ignore Error    Wait Until Page Contains    Deseja realizar o preenchimento automático desta O.S. baseado no plano informado?   
    Run Keyword And Ignore Error    Click Element    ${btnSim}
    

    Wait Until Page Contains       Lista de O.S.'s    30

    Click Salvar

    Menu Superior    Ordem de Serviço
    Wait Until Page Contains    O.S. Mobile

    Click Text    O.S. Mobile
    Wait Until Page Contains    Lista de O.S.
    
    Click Element    android=UiSelector().className("android.view.ViewGroup").instance(17)
    

Encerramento    
    [Tags]    Cadastro    OS    Encerramento
    Skip
    ${aplParou}              Set Variable    android=UiSelector().className("android.widget.ImageView").instance(2)
    ${aplFuncionou}          Set Variable    android=UiSelector().className("android.widget.ImageView").instance(4)
    ${dataRecebimento}       Set Variable    android=UiSelector().className("android.widget.ImageView").instance(6)
    ${recebidoPor}           Set Variable    android=UiSelector().className("android.widget.ImageView").instance(8)
    ${produto}               Set Variable    android=UiSelector().className("android.widget.ImageView").instance(11)
    ${motAtraso}             Set Variable    android=UiSelector().className("android.widget.ImageView").instance(14)
    ${interfReal}            Set Variable    android=UiSelector().className("android.widget.EditText").instance(6)
    ${interfRealpc}          Set Variable    android=UiSelector().className("android.widget.EditText").instance(7)
    ${tempoTotalParada}      Set Variable    android=UiSelector().className("android.widget.EditText").instance(8)
    
    Wait Until Page Contains    Encerramento
    Click Text    Encerramento
    Wait Until Page Contains    Encerramento da O.S.

    #Campo Data        ${aplFuncionou}       ${True}
    #Click Salvar
    #Mensagem    Valores inconsistentes!    Ok
    
    #Campo Data        ${aplParou}           ${True}

    Campo Data        ${dataRecebimento}    ${True}
    Campo Pesquisa    ${recebidoPor}        JULINHO
    Campo Pesquisa    ${produto}            BATATA
    #Campo Pesquisa   ${motAtraso}
    #Click Element     ${interfReal}
    Inserir Texto        ${interfReal}      5
    #Click Element     ${interfRealpc}
    Inserir Texto        ${interfRealpc}    100     

    Click Salvar
    Wait Until Page Contains    Cadastro

Cadastrar Anexo
    [Tags]    Cadastro    OS    Anexo
    
    ${btnAnexo}              Set Variable     android=UiSelector().text("Anexos")
    ${newAnexoButton}        Set Variable     //android.widget.Button
    ${optAnexoSimples}       Set Variable     //android.widget.TextView[@resource-id="android:id/text1" and @text="Anexo"]
    ${optAnexoMultiplo}      Set Variable     //android.widget.TextView[@resource-id="android:id/text1" and @text="Anexos múltiplos"]
    ${btnSelecionarAnexo}    Set Variable     android=UiSelector().text("Selecionar Anexo")
    ${btnCamera}             Set Variable     android=UiSelector().resourceId("com.android.camera2:id/shutter_button")
    ${btnCameraUSB}          Set Variable     //android.widget.ImageButton[@content-desc="Take photo"]
    ${btnDone}               Set Variable     android=UiSelector().resourceId("com.android.camera2:id/done_button")
    ${btnDoneUSB}            Set Variable     //android.widget.ImageButton[@content-desc="Done"]
    
    Wait Until Element Is Visible    ${btnAnexo}
    Click Element    ${btnAnexo}
    Wait Until Page Contains    Listagem de Anexo
    
    Click Element     ${newAnexoButton}
    Wait Until Page Contains    Inserir Anexo

    Click Element    ${optAnexoSimples}
    Wait Until Element Is Visible    ${btnSelecionarAnexo}

    Click Element    ${btnSelecionarAnexo}
    Wait Until Element Is Visible    android=UiSelector().resourceId("${appPackage}:id/parentPanel")
    Click Element    android=UiSelector().text("Câmera")

    Wait Until Element Is Visible    ${btnCameraUSB}
    Click Element    ${btnCameraUSB}

    Wait Until Element Is Visible    ${btnDoneUSB}
    Click Element    ${btnDoneUSB}

    Click Salvar
    
    
    Click Salvar
    

    Wait Until Page Contains    O.S.

Cadastrar Assinatura
    [Tags]    Cadastro    OS    Assinatura
    
    ${btnAssinatura}         Set Variable     android=UiSelector().text("Assinatura")
    ${btnNovaAssinatura}     Set Variable     android=UiSelector().className("android.widget.Button")
    ${campoDescricao}        Set Variable     android=UiSelector().className("android.widget.EditText").instance(0)
    ${btnSalvar}             Set Variable     android=UiSelector().description("Navigate up")
    
    
    Click Element    ${btnAssinatura}
    Wait Until Element Is Visible    ${btnNovaAssinatura}

    Click Element    ${btnNovaAssinatura}
    Wait Until Element Is Visible    ${campoDescricao}

    Inserir Texto    ${campoDescricao}    Assinatura Automatizada
    
    Swipe    ${124}    ${815}    ${834}    ${2087}    500
    Swipe    ${834}    ${815}    ${124}    ${2087}    500
    
    Sleep    1

    Click Element    android=UiSelector().description("Navigate up")
    Wait Until Page Contains    Listagem de Assinaturas
    
    Click Element    android=UiSelector().description("Navigate up")
    Wait Until Page Contains    O.S.


Cadastro Registro Funcionario
    [Tags]    Cadastro    OS    Funcionario
    
    ${btnFuncionario}       Set Variable    android=UiSelector().text("Funcionários")
    ${btnNewFuncionario}    Set Variable    android=UiSelector().className("android.widget.Button")
    ${sFuncionario}         Set Variable    android=UiSelector().className("android.widget.ImageView").instance(2)
    ${option1}              Set Variable    android=UiSelector().className("android.view.ViewGroup").instance(59)
    ${calendarInicio}       Set Variable    android=UiSelector().className("android.widget.ImageView").instance(5)
    ${calendarTermino}      Set Variable    android=UiSelector().className("android.widget.ImageView").instance(7)
    ${btnData}              Set Variable    android=UiSelector().className("android.widget.Button").instance(0)
    ${btnHorario}           Set Variable    android=UiSelector().className("android.widget.Button").instance(1)
    ${btnHora}              Set Variable    android=UiSelector().className("android.widget.EditText").instance(3)
    ${list}                 Set Variable    android=UiSelector().resourceId("com.engemanmaui.portocel:id/select_dialog_listview")
    ${btnOK}                Set Variable    android=UiSelector().text("OK")
    ${btnCancel}            Set Variable    android=UiSelector().text("Cancelar")
    ${btnSim}               Set Variable    android=UiSelector().resourceId("android:id/button1")
    ${primeiroRegistro}     Set Variable    android=UiSelector().className("android.view.ViewGroup").instance(14)
    
    Click Element    ${btnFuncionario}
    Wait Until Element Is Visible    ${btnNewFuncionario}
    
    Click Element    ${primeiroRegistro}
    #${menuOptions}          Set Variable    //android.widget.ImageView[@content-desc="More options"]
    #Wait Until Element Is Visible    ${menuOptions}
    Sleep    1
    Menu Options    Excluir
    Wait Until Page Contains    Confirma a exclusão desse registro?
    
    Click Element    ${btnSim}
    Wait Until Element Is Visible    ${btnNewFuncionario}

    Click Element    ${btnNewFuncionario}
    Wait Until Element Is Visible    ${sFuncionario}

    Campo Pesquisa    ${sFuncionario}    JOAQUIM

    Wait Until Element Is Visible    ${calendarInicio}

    Click Element    ${calendarInicio}
    Wait Until Element Is Visible    ${btnOK}
    Click Element    ${btnOK}

    Click Element    ${calendarTermino}
    Wait Until Element Is Visible    ${btnOK}
    Click Element    ${btnOK}

    Wait Until Element Is Visible    android=UiSelector().description("Navigate up")    10
    Click Element    android=UiSelector().description("Navigate up")
    
      
    #Run Keyword And Ignore Error    Wait Until Element Is Visible    ${btnSim}
    #Run Keyword And Ignore Error    Click Element    ${btnSim}
    Mensagem Configuracao    ${cfgFuncQualifVencida}   Qualif.    Sim
    
    #Permissão para Cadastro de Funcionários fora da escala de trabalho
    Mensagem Configuracao    ${cfgFuncForaDaEscala}    O horário informado está fora da escala de trabalho deste funcionário!    Sim
    

    
    
    Wait Until Page Contains    Registros de Funcionários
    Wait Until Element Is Visible    android=UiSelector().description("Navigate up")    10
    Click Element    android=UiSelector().description("Navigate up")
    Wait Until Page Contains    O.S. - 

    

Cadastro Requisição
    [Tags]    Cadastro    Requisição    OS
    
    #Swipe para o botão aparecer na tela
    Swipe    ${479}    ${1345}    ${479}    ${1076}

    ${btnOSRequisicao}      Set Variable    android=UiSelector().text("Requisição/Devolução")
    ${btnRequisicao}        Set Variable    android=UiSelector().text("Requisição")
    ${btnNewRequisicao}     Set Variable    android=UiSelector().className("android.widget.Button")
    
    ${sAlmoxarifado}        Set Variable    android=UiSelector().className("android.widget.ImageView").instance(2)

    Click Element    ${btnOSRequisicao}

    Wait Until Page Contains    Menu Requisição
    Click Element    ${btnRequisicao}

    Wait Until Page Contains    Pesquisa de Requisições
    Click Element    ${btnNewRequisicao}

    Wait Until Page Contains    Reduzido

    Campo Pesquisa    ${sAlmoxarifado}    CENTRAL

    Menu Options    Itens da Requisição
    Wait Until Page Contains    Pesquisa Item Requisição

    ${btnNewItem}    Set Variable    android=UiSelector().className("android.widget.Button")
    Click Element    ${btnNewItem}
    Wait Until Page Contains    Itens da Requisição
    
    ${cMaterial}      Set Variable    android=UiSelector().className("android.widget.EditText").instance(1)
    ${sMaterial}      Set Variable    android=UiSelector().className("android.widget.ImageView").instance(2)
    ${cUnidade}       Set Variable    android=UiSelector().className("android.widget.EditText").instance(2)
    ${sUnidade}       Set Variable    android=UiSelector().className("android.widget.ImageView").instance(5)
    ${cQuantidade}    Set Variable    android=UiSelector().className("android.widget.EditText").instance(3)

    Campo Pesquisa    ${sMaterial}     PNEU
    Inserir Texto        ${cQuantidade}   1  
    
    Click Salvar
    Mensagem    O item não foi relacionado a um registro de serviço. Deseja relacionar o item de requisição a um registro de serviço ?    Não
    
    Wait Until Page Contains  Pesquisa Item  
    Click Salvar
    Wait Until Page Contains   Reduzido
    
    Menu Options    Finalizar
    Mensagem    Deseja realmente finalizar a Requisição?    Sim
    
    Wait Until Page Contains    Pesquisa de Requisições

    Click Salvar
    Click Text    Atualizar

    Mensagem    Deseja realizar a atualização das requisições e posteriormente exportar as pendentes ?    Sim

    Wait Until Page Contains    Processo concluído com sucesso!   120
    Mensagem    Processo concluído com sucesso!    Ok
    
    Click Salvar

Cadastro Registro Servico
    [Tags]    Cadastro    OS    Registro Servico
    
    ${btnServico}          Set Variable    android=UiSelector().text("Serviços")
    ${btnNewServico}       Set Variable    android=UiSelector().className("android.widget.Button").instance(3)
    ${campoDescricao}      Set Variable    android=UiSelector().className("android.widget.EditText").instance(0)
    ${btnSim}              Set Variable    android=UiSelector().resourceId("android:id/button1")
    
    Wait Until Element Is Visible    ${btnServico}
    Click Element    ${btnServico}
    Wait Until Element Is Visible    ${btnNewServico}

    Click Element    ${btnNewServico}
    Wait Until Element Is Visible    ${campoDescricao}

    Inserir Texto    ${campoDescricao}    Descrição Automatizada
    Click Salvar
    


Marcar Registros Serviço Como Executado
    [Tags]    Serviço    Anexo    Executado
    
    Wait Until Page Contains    Registros de Serviços - reg(s)

    ${lista}    Set Variable    //androidx.recyclerview.widget.RecyclerView
    @{servicos}    Create List    ${lista}//
    
    ${label}    Set Variable    android=UiSelector().textContains("Registros de Serviços").instance(0)
    ${text}    Get Element Attribute    ${label}    text
    @{parts}    Split String    ${text}
    ${totalServicos}    Set Variable    ${parts}[5]

    ${count}=    Get Matching Xpath Count    xpath=(${lista}/android.view.ViewGroup)
    ${verificados}=    Set Variable    0
    @{listaVerificados}    Create List
    
    ${prevCount}   Set Variable    -1
    #Log To Console    \nServiços na Tela: ${count}
    
    WHILE   ${verificados} < ${totalServicos}
        
        #Interação com os serviços atualmente na tela
        IF     ${verificados} > ${prevCount}
            ${prevCount}    Set Variable    ${verificados}
            FOR    ${i}    IN RANGE    1    ${count}+1

                ${servico}          Set Variable               ${lista}/android.view.ViewGroup[${i}]
                ${imgAnexo}         Set Variable               ${servico}//android.widget.ImageView
                ${codigoServico}    Set Variable               //androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[${i}]//android.widget.TextView
                ${codigoServico}    Get Element Attribute      ${codigoServico}    text
                ${labelAplicacao}   Set Variable               ${servico}//(android.widget.TextView[@text="Aplicação: "])
                ${aplicacao}        Get Element Attribute      ${labelAplicacao}/following-sibling::*    text

                ${jaVerificado}    Run Keyword And Return Status    List Should Contain Value    ${listaVerificados}    ${codigoServico}
                
                #Caso o código não exista na lista ele é verificado e adicionado a lista.
                IF    ${jaVerificado} == False
                        
                Append To List    ${listaVerificados}    ${codigoServico}
                
                ${anexoObrig}      Run Keyword And Return Status    Page Should Contain Element    ${imgAnexo}
                ${naoExecutado}    Run Keyword And Return Status    Page Should Contain Element    ${servico}//android.widget.TextView[@text="Não"]
                
                    IF    ${naoExecutado} == True
                        
                        Log To Console    \nServiço: ${codigoServico}
                        Long Click    ${servico}
                        
                        Wait Until Page Contains    Marcar Como Executado
                        Click Text    Marcar Como Executado
                        
                        ${verificados}    Evaluate    ${verificados} + 1
                        Log To Console    \nVerificados: ${verificados} de ${totalServicos}\n
                    END
                    

                    IF    ${anexoObrig} == True
                        Log To Console    \nAnexo Obrigatorio!

                        ${naTela}     Run Keyword And Return Status    Page Should Contain Text    Descrição Geral
                        
                        IF     ${naTela} == False
                            Click Element    ${servico}
                            Wait Until Page Contains    Descrição Geral
                        END
                        
                        Anexo Servico     ${servico}
                    END
                END
            
            
            END
            
        ELSE 
            Pass Execution    Fim do Scroll atingido!
        END

        Swipe    ${103}    ${1401}    ${111}    ${918}
    END

Coleta Unificada
    [Tags]    OS    Coleta
    Wait Until Page Contains     reg(s)
    Menu Options    Coleta Unificada

    Preencher Coleta Unificada
    Wait Until Page Contains    reg(s)
    
    Click Salvar
    Wait Until Page Contains    O.S.


Interação
    [Tags]    OS    Interação    Cadastro
    Swipe    ${391}    ${2178}    ${416}    ${394}

    Wait Until Page Contains    Interação
    Click Text     Interação

    Wait Until Page Contains    Interação - reg(s)
    Menu Options    Novo
    Wait Until Page Contains    Observações   
    
    ${cTipo}     Set Variable    //android.widget.EditText[1]
    ${cObservacoes}    Set Variable   //android.widget.EditText[2] 
    
    Click Element    ${cTipo}
    Wait Until Page Contains    Cancel
    Click Text    Telefone
    
    Menu Options    Anexos
    Wait Until Page Contains   O campo Observações é obrigatório, verifique.

    #Click Element    ${cObservacoes}
    Inserir Texto    ${cObservacoes}    Observações Automatizadas!

    Menu Options    Anexos
    Wait Until Page Contains    Selecionar Anexo

    Click Text    Selecionar Anexo
    Wait Until Element Is Visible    android=UiSelector().resourceId("${appPackage}:id/parentPanel")
    Click Element    android=UiSelector().text("Câmera")
    
    ${btnCamera}             Set Variable     android=UiSelector().resourceId("com.android.camera2:id/shutter_button")
    ${btnDone}               Set Variable     android=UiSelector().resourceId("com.android.camera2:id/done_button")

    Wait Until Element Is Visible    ${btnCamera}
    Click Element    ${btnCamera}

    Wait Until Element Is Visible    ${btnDone}
    Click Element    ${btnDone}

    Click Salvar
    Wait Until Page Contains      Interação    20   
    Click Salvar
    Wait Until Page Contains      reg(s)   
    Click Salvar
    Wait Until Page Contains    O.S.

Fechar O.S.
    [Tags]    OS    Fechamento
    ${btnSim}            Set Variable    android=UiSelector().resourceId("android:id/button1")
    ${msgExportar}       Set Variable    //android.widget.TextView[@text="Há dados de O.S.'s a exportar. Toque aqui para exportar."]
    ${btnOK}             Set Variable    android=UiSelector().resourceId("android:id/button2")
    
    Wait Until Page Contains    O.S.
    Menu Options    Fechar O.S.

    
    Wait Until Page Contains   Atenção    10
    
    Wait Until Page Contains   Atenção    10

    Mensagem Configuracao    ${cfgFuncAntesDataProg}    A Data de Programação:    Sim
    
    Mensagem Configuracao    ${cfgFechFuncPrev}         Há registros de funcionários previstos! Confirma o fechamento desta OS?    Sim
    
    Mensagem Configuracao    ${cfgFecharServNExec}      Não há lançamento de registro de serviços para essa OS    Sim
    
    Mensagem Configuracao    ${cfgFecMatSemQuant}       Existem registros de serviço com a quantidade do material não informada.    Sim

    Mensagem Configuracao    ${cfgFecMatAdSemQuant}     Existem registros de serviço com materiais adicionais que estão com a quantidade não informada.    Sim
    
    Mensagem Configuracao    ${cfgFecMatSemAlm}         Esta O.S. possui materiais sem almoxarifado informado. Estes materiais não poderão ser requisitados. Deseja continuar?    Sim
    
    Wait Until Page Contains    Confirma o fechamento desta OS?
    Mensagem    Confirma o fechamento desta OS?    Sim
   
    Wait Until Page Contains    Lista de O.S.'s

    Navegar Menu Principal
    Run Keyword And Ignore Error    Wait Until Page Contains  ${msgExportar}
    Run Keyword And Ignore Error    Click Element    ${msgExportar}  
    
    Wait Until Page Contains    Exportando tabelas    15
    Wait Until Page Contains    Processo concluído com sucesso!    30

    Click Element    ${btnOK}
    Sleep    20

Cadastro S.S.
    [Tags]    Cadastro    Anexo    SS
    ${newSsButton}         Set Variable     android=UiSelector().className("android.widget.Button")
    
    ${campoSolicitacao}    Set Variable     android=UiSelector().className("android.widget.EditText").instance(0)
    ${btnDataParou}        Set Variable     android=UiSelector().className("android.widget.ImageView").instance(4)
    ${btnPrazo}            Set Variable     android=UiSelector().className("android.widget.ImageView").instance(6)
    ${campoUrgencia}       Set Variable     android=UiSelector().className("android.widget.EditText").instance(5)
    ${searchAplicacao}     Set Variable     android=UiSelector().className("android.widget.ImageView").instance(8)
    
    Menu Superior    Solicitação de Serviço
    Wait Until Page Contains    S.S. Mobile

    Click Text    S.S. Mobile
    Wait Until Page Contains    Lista de S.S.  

    Wait Until Element Is Visible    ${newSsButton}
    Click Element    ${newSsButton}
    
    Wait Until Element Is Visible    ${campoSolicitacao}
    ${newSsButton}          Set Variable     android=UiSelector().className("android.widget.Button")
    ${campoSolicitacao}     Set Variable     android=UiSelector().className("android.widget.EditText").instance(0)
    ${btnDataParou}         Set Variable     android=UiSelector().className("android.widget.ImageView").instance(4)
    ${btnPrazo}             Set Variable     android=UiSelector().className("android.widget.ImageView").instance(6)
    ${campoUrgencia}        Set Variable     android=UiSelector().className("android.widget.EditText").instance(5)
    ${searchAplicacao}      Set Variable     android=UiSelector().className("android.widget.ImageView").instance(8)
    ${searchCentroCusto}    Set Variable     android=UiSelector().className("android.widget.ImageView").instance(11)
    ${btnSim}    Set Variable    android=UiSelector().resourceId("android:id/button1")
    ${btnNao}    Set Variable    android=UiSelector().resourceId("android:id/button2")
        
    Wait Until Element Is Visible    ${campoSolicitacao}
    #Click Element     ${campoSolicitacao}
    Inserir Texto        ${campoSolicitacao}    Teste Solicitação Automatizada

    #Campo Data    ${btnDataParou}    True
    #Campo Data    ${btnPrazo}        False
    #Modificar a função Campo Data para alterar horas
        
    Campo Pesquisa    ${searchAplicacao}
    Wait Until Page Contains    Solicitação de Serviço
    Campo Pesquisa    ${searchCentroCusto}
    Wait Until Page Contains    Solicitação de Serviço
        
    Click Element    ${campoUrgencia}
    Wait Until Page Contains    2 - Alta
    Click Text    2 - Alta

    Swipe    ${383}    ${2127}    ${391}    ${450}

    ${searchCliente}        Set Variable    android=UiSelector().className("android.widget.ImageView").instance(12)
    ${searchSetor}          Set Variable    android=UiSelector().className("android.widget.ImageView").instance(15)
    ${searchTipoManut}      Set Variable    android=UiSelector().className("android.widget.ImageView").instance(18)
    ${searchLocalizacao}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(21)
    #Campo Pesquisa    ${searchCliente}    1
    #Campo Pesquisa    ${searchSetor}    1
    #Campo Pesquisa    ${searchTipoManut}    1
    #Campo Pesquisa    ${searchLocalizacao}    1
        
    Anexo SS

    Click Salvar

    Wait Until Page Contains    A S.S. já foi salva e sincronizada com o servidor.    30
    Wait Until Element Is Visible    ${btnSim}   
    Click Element    ${btnSim}
    Wait Until Page Contains    Lista de S.S.'s    20

Aprovar e Gerar O.S.
    [Tags]    Cadastro    SS    OS
    ${cardSS}    Set Variable   android=UiSelector().className("android.view.ViewGroup").instance(14)


    Click Element    ${cardSS}
    Wait Until Page Contains    Solicitação de Serviço

    Menu Options    Aprovar e Gerar O.S.
    
    #Tratamento caso já exista O.S. aberta nessa S.S.
    Run Keyword And Ignore Error    Wait Until Page Contains    Existe outra O.S.
    Run Keyword And Ignore Error    Click Text    Sim
    
    Cadastro OS Basica

    Wait Until Page Contains    Lista de S.S.'s
    Navegar Menu Principal

Cancelar O.S.  
    [Tags]    OS
    Menu Superior        Ordem de Serviço
    Wait Until Page Contains    O.S. Mobile
    Click Text    O.S. Mobile
    Wait Until Page Contains    Lista de O.S.'s

    Click Element   android=UiSelector().textContains("Aberta")

    Wait Until Page Contains    Cadastro

    Menu Options    Cancelar O.S.
    
    #IF ${perMobCancelar}

    ${sMotCancel}     Set Variable    android=UiSelector().className("android.widget.ImageView").instance(2)
    ${cMotCancel}     Set Variable    android=UiSelector().className("android.widget.EditText").instance(0)
    ${sAutorizado}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(5)
    ${cAutorizado}    Set Variable    android=UiSelector().className("android.widget.EditText").instance(1)
    ${cObservacao}    Set Variable    android=UiSelector().className("android.widget.EditText").instance(2)
    
    Wait Until Element Is Visible    ${sMotCancel}
    Campo Pesquisa    ${sMotCancel}     OS EM DUPLICIDADE
    Campo Pesquisa    ${sAutorizado}    TERCEIRO
    
    #Click Element    ${cObservacao}
    Inserir Texto     ${cObservacao}    Observacao Automatizada
    
    Menu Options    Confirmar
    Mensagem        Confirma o cancelamento dessa OS?    Sim
    Wait Until Page Contains    Lista de O.S.'s

Liberar O.S.  
    [Tags]    OS
    Wait Until Page Contains    Lista de O.S.'s
    Click Element   android=UiSelector().textContains("Aberta")

    Wait Until Page Contains    Cadastro

    Menu Options    Liberar O.S.
    Mensagem        Liberando essa OS a mesma não poderá ser mais alterada e no próximo sincronismo será enviada ao servidor.Deseja continuar?    Sim
    
    Wait Until Page Contains    Motivo Liberação
    Click Text      SERA REPROGRAMADA  
    
    Wait Until Page Contains    Justificativa

    ${cJustificativa}    Set Variable    android=UiSelector().className("android.widget.EditText")
    ${btnOK}             Set Variable    android=UiSelector().resourceId("android:id/button1")
    
    
    Inserir Texto       ${cJustificativa}    Justificativa Automatizada
    Click Element    ${btnOK}

    Wait Until Page Contains    Lista de O.S.'s

Voltar ao Menu Principal
    
    Navegar Menu Principal
    Exportar Dados Pendentes
