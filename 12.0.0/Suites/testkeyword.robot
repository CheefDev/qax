*** Settings ***

Library    AppiumLibrary
Library    Process
Library    DateTime
Library    String
Library    Collections

#Library     ../Resources/function.py

Resource    ../Resources/base.resource



*** Test Cases ***


Sessão

   Iniciar Sessão    ${appName}    C:\\QAx\\projects\\Maui\\12.0.0\\APK\\${appPackage}.apk    true


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

    