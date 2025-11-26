*** Settings ***

Library    AppiumLibrary
Library    Process

Resource    ../Resources/base.resource



*** Test Cases ***

Cadastro S.S.
    [Tags]    Cadastro    Anexo    SS

    @{permissao}    Create List    ${cfgmSolic}
    ${acesso}    Permissao Acesso Mobile    @{permissao}

    ${newSsButton}         Set Variable     android=UiSelector().className("android.widget.Button")
    
    ${campoSolicitacao}    Set Variable     android=UiSelector().className("android.widget.EditText").instance(0)
    ${btnDataParou}        Set Variable     android=UiSelector().className("android.widget.ImageView").instance(5)
    ${btnPrazo}            Set Variable     android=UiSelector().className("android.widget.ImageView").instance(7)
    ${campoUrgencia}       Set Variable     android=UiSelector().className("android.widget.EditText").instance(5)
    ${searchAplicacao}     Set Variable     android=UiSelector().className("android.widget.ImageView").instance(9)
    
    Voltar Para    Início
    Sleep    1
    Remover Notificação
    
    Menu Superior    Solicitação de Serviço
    Wait Until Page Contains    S.S. Mobile

    Click Text    S.S. Mobile
    Wait Until Page Contains    Lista de S.S.  

    Wait Until Element Is Visible    ${newSsButton}
    Click Element    ${newSsButton}
    
    Wait Until Element Is Visible    ${campoSolicitacao}
    ${newSsButton}          Set Variable     android=UiSelector().className("android.widget.Button")
    ${campoSolicitacao}     Set Variable     android=UiSelector().className("android.widget.EditText").instance(0)
    ${btnDataParou}         Set Variable     android=UiSelector().className("android.widget.ImageView").instance(5)
    ${btnPrazo}             Set Variable     android=UiSelector().className("android.widget.ImageView").instance(7)
    ${campoUrgencia}        Set Variable     android=UiSelector().className("android.widget.EditText").instance(5)
    ${searchAplicacao}      Set Variable     android=UiSelector().className("android.widget.ImageView").instance(9)
    ${searchCentroCusto}    Set Variable     android=UiSelector().className("android.widget.ImageView").instance(12)
    ${btnSim}               Set Variable     android=UiSelector().resourceId("android:id/button1")
    ${btnNao}               Set Variable     android=UiSelector().resourceId("android:id/button2")
        
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

    ${searchCliente}        Set Variable    android=UiSelector().className("android.widget.ImageView").instance(13)
    ${searchSetor}          Set Variable    android=UiSelector().className("android.widget.ImageView").instance(16)
    ${searchTipoManut}      Set Variable    android=UiSelector().className("android.widget.ImageView").instance(19)
    ${searchLocalizacao}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(22)
    #Campo Pesquisa    ${searchCliente}    1
    #Campo Pesquisa    ${searchSetor}    1
    #Campo Pesquisa    ${searchTipoManut}    1
    #Campo Pesquisa    ${searchLocalizacao}    1

    #Tratar Configuracao ${cfgAplicJaPossuiSS}    
    Anexo SS

    Click Salvar

    Wait Until Page Contains    A S.S. já foi salva e sincronizada com o servidor.    30
    Wait Until Element Is Visible    ${btnSim}   
    Click Element    ${btnSim}
    Wait Until Page Contains    Lista de S.S.'s    20

Aprovar e Gerar O.S.
    [Tags]    Cadastro    SS    OS

    @{permissao}    Create List    ${cfgmOrdServ}    ${cfgmAbrirOS}    ${cfgmSolic}
    ${acesso}    Permissao Acesso Mobile    @{permissao}


    ${cardSS}    Set Variable   android=UiSelector().className("android.view.ViewGroup").instance(16)


    Click Element    ${cardSS}
    Wait Until Page Contains    Solicitação de Serviço

    Menu Options    Aprovar e Gerar O.S.

    IF    ${cfgmAbrirOS} == False
    
        Mensagem  Essa funcionalidade encontra-se bloqueada    Ok  
        Skip    Dispositivo não tem permissão para abrir O.S.

    END
    
    #Tratamento caso já exista O.S. aberta nessa S.S.
    Run Keyword And Ignore Error    Wait Until Page Contains    Existe outra O.S.
    Run Keyword And Ignore Error    Click Text    Sim
    
    Cadastro OS Basica
    
    Navegar Menu Principal
