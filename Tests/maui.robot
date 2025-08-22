*** Settings ***

Library    AppiumLibrary
Library    Process

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
${gerarBanco}      ${False}

*** Test Cases ***

Abrir Tela Principal

    Iniciar Sessão    Portocel    C:\\QAx\\projects\\Maui\\com.engemanmaui.portocel.apk    true


Digitar Webservice
    [Tags]    Geracao Banco    Configuracao
    ${cfgButton}    Set Variable     //androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[1]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ImageView[1]
    ${wsField}      Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[1]/android.widget.EditText
    ${lastField}    Set Variable     //android.widget.EditText[@text="Escolher"]
    ${check1}       Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[6]/android.widget.Switch
    ${check2}       Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[7]/android.widget.Switch
    IF    ${gerarBanco} == False
        Pass Execution    Banco já configurado!
    END
    Wait Until Element Is Visible    ${cfgButton}    20
    Click Element    ${cfgButton}
    

    Wait Until Element Is Visible    ${wsField}    20
    Input Text    ${wsField}    ${webservice}

    Click Salvar


Gerar Banco de Dados
    [Tags]    Geracao Banco
    
    ${btnNao}    Set Variable    //android.widget.Button[@resource-id="android:id/button2"]
    
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

    Activate Application    com.engemanmaui.portocel
    Sleep    5

Logar no app
    [Tags]    Login
    ${loginField}      Set Variable    android=UiSelector().className("android.widget.EditText").instance(0)
    ${passField}       Set Variable    android=UiSelector().className("android.widget.EditText").instance(0)
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

Cadastro Coleta Acumulativa
    ${btnNew}    Set Variable    android=UiSelector().className("android.widget.Button")
    
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
    ${btnNew}    Set Variable    android=UiSelector().className("android.widget.Button")
    
    
    Menu Superior    Coletas
    Wait Until Page Contains    Coleta de Tendência
    
    Click Text       Coleta de Tendência
    Wait Until Page Contains    Pesquisa - Aplicação - Coleta Tendência
    
    Click Element    android=UiSelector().className("android.view.ViewGroup").instance(15)
    Wait Until Element Is Visible    ${btnNew}
    Click Element    ${btnNew}
    Wait Until Page Contains    Última Leitura:

    Coleta Tendencia    2.5

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

    Campo Pesquisa    ${sResponsavel}    2
    Wait Until Page Contains    Cadastro da O.S.

    Campo Pesquisa    ${sSolicitante}    3
    Wait Until Page Contains    Cadastro da O.S.

    Campo Pesquisa    ${sFornecedor}    1
    Wait Until Page Contains    Cadastro da O.S.

    Campo Pesquisa    ${sPlano}    1
    Wait Until Page Contains    Cadastro da O.S.
    
    Descer Tela
    Sleep    2
    Campo Pesquisa    ${sTipoManut}    1
    Wait Until Page Contains    Cadastro da O.S.

    Campo Pesquisa    ${sSetorExec}    1
    Wait Until Page Contains    Cadastro da O.S.

    Campo Pesquisa    ${sAplicacao}    1
    Wait Until Page Contains    Cadastro da O.S.

    Campo Pesquisa    ${sCentroCusto}    1
    Wait Until Page Contains    Cadastro da O.S.
    
    Click Element    ${saveButton}
    Wait Until Page Contains    Salvando registro

    Wait Until Page Contains    Uma O.S. com código    10
    Click Element    ${btnOk}
    
    Run Keyword And Ignore Error    Wait Until Page Contains    Deseja realizar o preenchimento automático desta O.S. baseado no plano informado?   
    Run Keyword And Ignore Error    Click Element    ${btnSim}
    

    Wait Until Page Contains       Lista de O.S.'s

    Click Salvar

    Menu Superior    Ordem de Serviço
    Wait Until Page Contains    O.S. Mobile

    Click Text    O.S. Mobile
    Wait Until Page Contains    Lista de O.S.
    
    Click Element    android=UiSelector().className("android.view.ViewGroup").instance(14)
    
Cadastrar Anexo
    [Tags]    Cadastro    OS    Anexo
    
    ${btnAnexo}              Set Variable     android=UiSelector().text("Anexos")
    ${newAnexoButton}        Set Variable     //android.widget.Button
    ${optAnexoSimples}       Set Variable     //android.widget.TextView[@resource-id="android:id/text1" and @text="Anexo"]
    ${optAnexoMultiplo}      Set Variable     //android.widget.TextView[@resource-id="android:id/text1" and @text="Anexos múltiplos"]
    ${btnSelecionarAnexo}    Set Variable     android=UiSelector().text("Selecionar Anexo")
    ${btnCamera}             Set Variable     android=UiSelector().resourceId("com.android.camera2:id/shutter_button")
    ${btnDone}               Set Variable     android=UiSelector().resourceId("com.android.camera2:id/done_button")
    
    Wait Until Element Is Visible    ${btnAnexo}
    Click Element    ${btnAnexo}
    Wait Until Page Contains    Listagem de Anexo
    
    Click Element     ${newAnexoButton}
    Wait Until Page Contains    Inserir Anexo

    Click Element    ${optAnexoSimples}
    Wait Until Element Is Visible    ${btnSelecionarAnexo}

    Click Element    ${btnSelecionarAnexo}
    Wait Until Element Is Visible    android=UiSelector().resourceId("com.engemanmaui.portocel:id/parentPanel")
    Click Element    android=UiSelector().text("Câmera")

    Wait Until Element Is Visible    ${btnCamera}
    Click Element    ${btnCamera}

    Wait Until Element Is Visible    ${btnDone}
    Click Element    ${btnDone}

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

    Input Text    ${campoDescricao}    Assinatura Automatizada
    
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
    ${option1}              Set Variable    android=UiSelector().className("android.view.ViewGroup").instance(14)
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
    Wait Until Element Is Visible    ${menuOptions}
    
    Menu Options    Excluir
    Wait Until Page Contains    Confirma a exclusão desse registro?
    
    Click Element    ${btnSim}
    Wait Until Element Is Visible    ${btnNewFuncionario}

    Click Element    ${btnNewFuncionario}
    Wait Until Element Is Visible    ${sFuncionario}

    Click Element    ${sFuncionario}
    Wait Until Element Is Visible    ${option1}

    Click Element    ${option1}
    Wait Until Element Is Visible    ${calendarInicio}

    Click Element    ${calendarInicio}
    Wait Until Element Is Visible    ${btnOK}
    Click Element    ${btnOK}

    Click Element    ${calendarTermino}
    Wait Until Element Is Visible    ${btnOK}
    Click Element    ${btnOK}


    Click Element    android=UiSelector().description("Navigate up")
    
      
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${btnSim}
    Run Keyword And Ignore Error    Click Element    ${btnSim}

    Wait Until Page Contains    Registros de Funcionários

    Click Element    android=UiSelector().description("Navigate up")
    Wait Until Page Contains    O.S.

Cadastro Registro Servico
    [Tags]    Cadastro    OS    Registro Servico

    ${btnServico}          Set Variable    android=UiSelector().className("android.view.ViewGroup").instance(39)
    ${btnNewServico}       Set Variable    android=UiSelector().className("android.widget.Button").instance(3)
    ${campoDescricao}      Set Variable    android=UiSelector().className("android.widget.EditText").instance(0)
    ${btnSim}              Set Variable    android=UiSelector().resourceId("android:id/button1")
    
    Click Element    ${btnServico}
    Wait Until Element Is Visible    ${btnNewServico}

    Click Element    ${btnNewServico}
    Wait Until Element Is Visible    ${campoDescricao}

    Input Text    ${campoDescricao}    Descrição Automatizada
    Click Salvar
    Wait Until Page Contains    Registros de Serviço
    
    Click Salvar
    Wait Until Page Contains    O.S.


Fechar O.S.
    [Tags]    OS    Fechamento
    ${btnSim}            Set Variable    android=UiSelector().resourceId("android:id/button1")
    ${msgExportar}       Set Variable    //android.widget.TextView[@text="Há dados de O.S.'s a exportar. Toque aqui para exportar."]
    ${btnOK}             Set Variable    android=UiSelector().resourceId("android:id/button2")
    
    Menu Options    Fechar O.S.

    Run Keyword And Ignore Error    Wait Until Page Contains    Há registros de funcionários previstos! Confirma o fechamento desta OS?    30
    Run Keyword And Ignore Error    Click Element    ${btnSim}
    
    Wait Until Page Contains    Confirma o fechamento desta OS?
    Click Element    ${btnSim}
    Wait Until Page Contains    Lista de O.S.'s

    Click Salvar
    Wait Until Element Is Visible  ${msgExportar}
    Click Element    ${msgExportar}  
    
    Wait Until Page Contains    Exportando tabelas    15
    Wait Until Page Contains    Processo concluído com sucesso!    30

    Click Element    ${btnOK}
    Sleep    20

    Run Keyword If Test Failed    Navegar Menu Principal