*** Settings ***

Library    AppiumLibrary


*** Test Cases ***

Abrir Tela Principal

    Open Application    http://localhost:4723
    ...            platformName=Android
    ...            automationName=UIAutomator2
    ...            app=C:\\QAx\\projects\\yodapp-robot\\yodapp-beta.apk
    ...            autoGrantPermissions=true
    Wait Until Page Contains    Yodapp