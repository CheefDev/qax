*** Settings ***

Library    AppiumLibrary

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

    Open Application    http://localhost:4723
    ...            platformName=Android
    ...            automationName=UIAutomator2
    ...            app=C:\\QAx\\projects\\Maui\\com.engemanmaui.portocel.apk
    ...            autoGrantPermissions=true
    
    Wait Until Page Contains    Portocel    20


Digitar Webservice
    ${cfgButton}    Set Variable     //androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[1]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ImageView[1]
    ${wsField}      Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[1]/android.widget.EditText
    ${lastField}    Set Variable     //android.widget.EditText[@text="Escolher"]
    ${check1}       Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[6]/android.widget.Switch
    ${check2}       Set Variable     //androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[7]/android.widget.Switch

    Wait Until Element Is Visible    ${cfgButton}    20
    Click Element    ${cfgButton}
    

    Wait Until Element Is Visible    ${wsField}    20
    Input Text    ${wsField}    ${webservice}

    Click Salvar


Gerar Banco de Dados
    
    ${btnNao}    Set Variable    //android.widget.Button[@resource-id="android:id/button2"]
    
    
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


Reabrir Aplicação

    Activate Application    com.engemanmaui.portocel
    Sleep    5

Logar no app

    ${loginField}      Set Variable    //android.widget.EditText[@text="Usuário"]
    ${passField}       Set Variable    //android.widget.EditText[@text="Senha"]
    ${buttonEntrar}    Set Variable    //android.widget.TextView[@text="Entrar"]
    
    Wait Until Element Is Visible    ${loginField}    30
    Input Text    ${loginField}    engeman
    Input Password    ${passField}    engeman
    
    Click Element    ${buttonEntrar}

    Wait Until Page Contains    Selecionar Filial    10

    Click Text   01
    Wait Until Page Contains    Notificações    10

    
Cadastro OS Local
    
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

    Click Element    ${btnVoltar}

    Menu Superior    Ordem de Serviço
    Wait Until Page Contains    O.S. Mobile

    Click Text    O.S. Mobile
    Wait Until Page Contains    Lista de O.S.
    
    Click Element    android=UiSelector().className("android.view.ViewGroup").instance(14)
    
Cadastrar Anexo

    ${btnAnexo}              Set Variable     android=UiSelector().text("Anexos")
    ${newAnexoButton}        Set Variable     //android.widget.Button
    ${optAnexoSimples}       Set Variable     //android.widget.TextView[@resource-id="android:id/text1" and @text="Anexo"]
    ${optAnexoMultiplo}      Set Variable     //android.widget.TextView[@resource-id="android:id/text1" and @text="Anexos múltiplos"]
    ${btnSelecionarAnexo}    Set Variable     android=UiSelector().text("Selecionar Anexo")
    ${btnCamera}             Set Variable     android=UiSelector().resourceId("com.android.camera2:id/shutter_button")
    ${btnDone}               Set Variable     android=UiSelector().resourceId("com.android.camera2:id/done_button")
    
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

    Wait Until Element Is Visible    ${btnSalvar}
    Click Element    ${btnSalvar}
    
    
    ${btnVoltar}    Set Variable    android=UiSelector().description("Navigate up")
    Wait Until Element Is Visible    ${btnVoltar}
    Click Element    ${btnVoltar}
    

    Wait Until Page Contains    O.S.

Cadastrar Assinatura
    ${btnAssinatura}         Set Variable     android=UiSelector().text("Assinatura")
    ${btnNovaAssinatura}     Set Variable     android=UiSelector().className("android.widget.Button")
    ${campoDescricao}        Set Variable     android=UiSelector().className("android.widget.EditText").instance(0)
    ${btnSalvar}             Set Variable     android=UiSelector().description("Navigate up")
    
    
    Click Element    ${btnAssinatura}
    Wait Until Element Is Visible    ${btnNovaAssinatura}

    Click Element    ${btnNovaAssinatura}
    Wait Until Element Is Visible    ${campoDescricao}

    Input Text    ${campoDescricao}    Assinatura Automatizada
    
    Swipe    ${124}    ${815}    ${834}    ${2087}
    Swipe    ${834}    ${944}    ${124}    ${2018}
    
    Sleep    1

    Click Element    android=UiSelector().description("Navigate up")
    Wait Until Page Contains    Listagem de Assinaturas
    
    Click Element    android=UiSelector().description("Navigate up")
    Wait Until Page Contains    O.S.


*** Keywords ***

Scroll to
    [Arguments]    ${element}
    

    Run Keyword And Ignore Error    Scroll Down    ${element}

Click Salvar

    ${saveButton}    Set Variable    android=UiSelector().description("Navigate up")
    
    Wait Until Element Is Visible    ${saveButton}    20
    Click Element    ${saveButton}
    Wait Until Page Contains      Configurações


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
    Sleep    1
    Click Element    //android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ImageView[1]
    Sleep    2
    Run Keyword And Continue On Failure    
    ...    Click Element    //androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[${elementPosition}]/android.view.ViewGroup

Descer Tela
    
    Swipe    ${486}    ${1982}    ${486}    ${954}