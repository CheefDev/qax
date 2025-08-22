*** Settings ***

Library    AppiumLibrary
Library    Process
Library    DateTime
Library    String

Resource    ../Resources/base.resource


*** Test Cases ***


Abrir Tela Principal

    Iniciar Sessão    Portocel    C:\\QAx\\projects\\Maui\\com.engemanmaui.portocel.apk    true

Teste Coleta Acumulativa

    Coleta Acumulativa    50   
    

Test Date Time
    
    ${campo}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(2) 
    Campo Data    ${campo}    True

    ${campo}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(4)
    Campo Data    ${campo}    False
    
    ${campo}    Set Variable    android=UiSelector().className("android.widget.ImageView").instance(6)
    Campo Data    ${campo}    False
