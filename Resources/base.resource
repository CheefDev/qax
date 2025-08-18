*** Settings ***

Library    AppiumLibrary
Library    DateTime

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
    
    Log To Console    ${date}
    Log To Console    ${dateTime}
    
    
    IF    ${subtract} == True
        
        #Click no campo de Horas a partir do texto "H:" já que os minutos sao mais provaveis de mudar durante a execução
        Click Text    :
        
        #Acessar o campo Minutos pela localização a partir do Label
        ${location}=    Get Element Location    android=UiSelector().text("Minutos")
        ${offset}    Set Variable    100
        ${newY}=    Evaluate    ${location['y']} + ${offset}
        ${campoMinutes}     Set Variable    //android.widget.EditText[@text="${minutes}"]
        
        @{newPosition}=    Create List    ${location['x']}    ${newY}
        
        Tap With Positions    500    ${newPosition}
        
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

