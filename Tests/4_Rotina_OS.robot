*** Settings ***

Library    AppiumLibrary
Library    Process

Resource    ../Resources/base.resource
Resource    ../Resources/cfgMobile.resource
Resource    ../Resources/cfgGeral.resource


*** Test Cases ***

Cadastro OS Local
    [Tags]    Cadastro    OS
    
    ${sResponsavel}        Set Variable    android=UiSelector().className("android.widget.ImageView").instance(5)
    ${sSolicitante}        Set Variable    android=UiSelector().className("android.widget.ImageView").instance(8)
    ${Solicitacao}         Set Variable    //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText[4]
    ${editSolicitacao}     Set Variable    //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[4]/android.view.ViewGroup
    ${sFornecedor}         Set Variable    android=UiSelector().className("android.widget.ImageView").instance(12)
    ${sPlano}              Set Variable    android=UiSelector().className("android.widget.ImageView").instance(15)
    ${sTipoManut}          Set Variable    android=UiSelector().className("android.widget.ImageView").instance(10)
    ${sSetorExec}          Set Variable    android=UiSelector().className("android.widget.ImageView").instance(13)
    ${sAplicacao}          Set Variable    android=UiSelector().className("android.widget.ImageView").instance(16)
    ${sCentroCusto}        Set Variable    android=UiSelector().className("android.widget.ImageView").instance(19)
    
    ${btnOk}               Set Variable    //android.widget.Button[@resource-id="android:id/button2"]
    ${btnSim}              Set Variable    //android.widget.Button[@resource-id="android:id/button1"]
    ${newOSButton}         Set Variable    //android.widget.Button
    
    Voltar Para    Início
    Sleep    1
    Remover Notificação
    Wait Until Page Contains   Início
    
    Sleep    1
    Remover Notificação    
    
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
    
    Click Salvar
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
    
    Click Element    android=UiSelector().className("android.view.ViewGroup").instance(22)
    
Encerramento    
    [Tags]    Cadastro    OS    Encerramento
    Skip
    ${aplParou}              Set Variable    android=UiSelector().className("android.widget.ImageView").instance(3)
    ${aplFuncionou}          Set Variable    android=UiSelector().className("android.widget.ImageView").instance(5)
    ${dataRecebimento}       Set Variable    android=UiSelector().className("android.widget.ImageView").instance(7)
    ${recebidoPor}           Set Variable    android=UiSelector().className("android.widget.ImageView").instance(9)
    ${produto}               Set Variable    android=UiSelector().className("android.widget.ImageView").instance(12)
    ${motAtraso}             Set Variable    android=UiSelector().className("android.widget.ImageView").instance(15)
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

    Wait Until Element Is Visible    ${btnCamera}
    Click Element    ${btnCamera}

    Wait Until Element Is Visible    ${btnDoneUSB}
    Click Element    ${btnDoneUSB}

    Click Salvar
    Wait Until Page Contains    Listagem
    
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

    Click Salvar
    Wait Until Page Contains    Listagem de Assinaturas
    
    Click Salvar
    Wait Until Page Contains    O.S.


Cadastro Registro Funcionario
    [Tags]    Cadastro    OS    Funcionario
    
    ${btnFuncionario}       Set Variable    android=UiSelector().text("Funcionários")
    ${btnNewFuncionario}    Set Variable    android=UiSelector().className("android.widget.Button")
    ${sFuncionario}         Set Variable    android=UiSelector().className("android.widget.ImageView").instance(3)
    ${option1}              Set Variable    android=UiSelector().className("android.view.ViewGroup").instance(59)
    ${calendarInicio}       Set Variable    android=UiSelector().className("android.widget.ImageView").instance(6)
    ${calendarTermino}      Set Variable    android=UiSelector().className("android.widget.ImageView").instance(8)
    ${btnData}              Set Variable    android=UiSelector().className("android.widget.Button").instance(0)
    ${btnHorario}           Set Variable    android=UiSelector().className("android.widget.Button").instance(1)
    ${btnHora}              Set Variable    android=UiSelector().className("android.widget.EditText").instance(3)
    ${list}                 Set Variable    android=UiSelector().resourceId("com.engemanmaui.padrao:id/select_dialog_listview")
    ${btnOK}                Set Variable    android=UiSelector().text("OK")
    ${btnCancel}            Set Variable    android=UiSelector().text("Cancelar")
    ${btnSim}               Set Variable    android=UiSelector().resourceId("android:id/button1")
    ${primeiroRegistro}     Set Variable    android=UiSelector().className("android.view.ViewGroup").instance(15)
    
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

    Click Salvar
    
      
    #Run Keyword And Ignore Error    Wait Until Element Is Visible    ${btnSim}
    #Run Keyword And Ignore Error    Click Element    ${btnSim}
    Mensagem Configuracao    ${cfgFuncQualifVencida}   Qualif.    Sim
    
    #Permissão para Cadastro de Funcionários fora da escala de trabalho
    Mensagem Configuracao    ${cfgFuncForaDaEscala}    O horário informado está fora da escala de trabalho deste funcionário!    Sim
    
    Mensagem Configuracao    ${cfgFuncAntesDataProg}    inferior à Data Programada:       Sim
    

    Wait Until Page Contains    Registros de Funcionários
    
    ${telaOS}=    Run Keyword And Return Status    Page Should Contain Text    O.S. - 
    
    WHILE    ${telaOS} == False
            Click Salvar
            Sleep    1
            ${telaOS}=    Run Keyword And Return Status    Page Should Contain Text    O.S. - 
    END
    
Cadastro Requisição
    [Tags]    Cadastro    Requisição    OS
    
    #Swipe para o botão aparecer na tela
    Swipe    ${479}    ${1345}    ${479}    ${1076}
    Skip
    ${btnOSRequisicao}      Set Variable    android=UiSelector().text("Requisição/Devolução")
    ${btnRequisicao}        Set Variable    android=UiSelector().text("Requisição")
    ${btnNewRequisicao}     Set Variable    android=UiSelector().className("android.widget.Button")
    
    ${sAlmoxarifado}        Set Variable    android=UiSelector().className("android.widget.ImageView").instance(3)

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
    ${sMaterial}      Set Variable    android=UiSelector().className("android.widget.ImageView").instance(3)
    ${cUnidade}       Set Variable    android=UiSelector().className("android.widget.EditText").instance(2)
    ${sUnidade}       Set Variable    android=UiSelector().className("android.widget.ImageView").instance(6)
    ${cQuantidade}    Set Variable    android=UiSelector().className("android.widget.EditText").instance(3)

    Campo Pesquisa    ${sMaterial}     OLEO
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

    Wait Until Page Contains    Processo concluído com sucesso!   90
    Mensagem    Processo concluído com sucesso!    Ok

    Mensagem    Não foi possível exportar todas informações    Ok
    
    Click Salvar

    Run Keyword If Test Failed    Click Salvar

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
    Wait Until Page Contains        Anexo

    
    Voltar Para      O.S. 

Fechar O.S.
    [Tags]    OS    Fechamento
    ${btnSim}            Set Variable    android=UiSelector().resourceId("android:id/button1")
    ${msgExportar}       Set Variable    //android.widget.TextView[@text="Há dados de O.S.'s a exportar. Toque aqui para exportar."]
    ${btnOK}             Set Variable    android=UiSelector().resourceId("android:id/button2")
    
    #Versão atual com erro após fechamento da O.S.
    Skip

    Wait Until Page Contains    O.S.
    Menu Options    Fechar O.S.

    
    Wait Until Page Contains   Atenção    10
    
    Wait Until Page Contains   Atenção    10

    Mensagem Configuracao    ${cfgFuncAntesDataProg}    A Data de Programação:    Sim
    Sleep    2
    Mensagem Configuracao    ${cfgFechFuncPrev}         Há registros de funcionários previstos! Confirma o fechamento desta OS?    Sim
    
    Mensagem Configuracao    ${cfgFecharServNExec}      Não há lançamento de registro de serviços para essa OS    Sim
    
    Mensagem Configuracao    ${cfgFecMatSemQuant}       Existem registros de serviço com a quantidade do material não informada.    Sim

    Mensagem Configuracao    ${cfgFecMatAdSemQuant}     Existem registros de serviço com materiais adicionais que estão com a quantidade não informada.    Sim
    
    Mensagem Configuracao    ${cfgFecMatSemAlm}         Esta O.S. possui materiais sem almoxarifado informado. Estes materiais não poderão ser requisitados. Deseja continuar?    Sim
    
    Wait Until Page Contains    Confirma o fechamento desta OS?
    Mensagem    Confirma o fechamento desta OS?    Sim
   
    ${coletaFechamento}    Run Keyword And Return Status    Wait Until Page Contains    Coleta Unificada
    IF    ${coletaFechamento} == True
        Preencher Coleta Unificada
    END
    
    Wait Until Page Contains    Lista de O.S.'s

    Navegar Menu Principal
    Run Keyword And Ignore Error    Wait Until Page Contains  ${msgExportar}
    Run Keyword And Ignore Error    Click Element    ${msgExportar}  
    
    Wait Until Page Contains    Exportando tabelas    15
    Wait Until Page Contains    Processo concluído com sucesso!    30

    Click Element    ${btnOK}
    Sleep    20
