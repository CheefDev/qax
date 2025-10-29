*** Settings ***

Library    AppiumLibrary
Library    Process

Resource    ../Resources/base.resource
Resource    ../Resources/cfgMobile.resource
Resource    ../Resources/cfgGeral.resource


*** Test Cases ***

Cancelar O.S.  
    [Tags]    OS
    
    Voltar Para    Início
    Sleep    1
    Remover Notificação
    
    Menu Superior        Ordem de Serviço
    Wait Until Page Contains    O.S. Mobile
    Click Text    O.S. Mobile
    Wait Until Page Contains    Lista de O.S.'s

    Click Element   android=UiSelector().textContains("Aberta")

    Wait Until Page Contains    Cadastro

    Menu Options    Cancelar O.S.
    
    #IF ${perMobCancelar}

    ${sMotCancel}     Set Variable    android=UiSelector().className("android.widget.ImageView").instance(3)
    ${cMotCancel}     Set Variable    android=UiSelector().className("android.widget.EditText").instance(0)
    ${sAutorizado}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(6)
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
    
Exportar Dados

    ${btnNotificacoes}    Set Variable    android=UiSelector().resourceId("com.engemanmaui.padrao:id/navigation_bar_item_icon_view").instance(1)

    Wait Until Page Contains Element    ${btnNotificacoes}
    Click Element    ${btnNotificacoes}

    Wait Until Page Contains    Há dados de O.S.'s a exportar. Toque aqui para exportar.
    Click Text                  Há dados de O.S.'s a exportar. Toque aqui para exportar.

    Wait Until Page Contains    Processo concluído com sucesso!    120
    Click Text    Ok
    
    Sleep    1
    Page Should Not Contain Text    Há dados de O.S.'s a exportar. Toque aqui para exportar.
