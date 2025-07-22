*** Settings ***

Library    AppiumLibrary



*** Test Cases ***


Deve abrir a tela principal



    Open Application   http://localhost:4723
    ...                strict_ssl=No
    ...                udid=emulator-5554
    ...                platformName=Android
    ...                deviceName=emulator-5554
    ...                automationName=UIAutomator2
    ...                app=C:/Qax/projects/yodapp-robot/app/yodapp-beta.apk
    ...                autoGrantPermissions=true
    
    Wait Until Page Contains    Yodapp
    Wait Until Page Contains    Mobile Training

    Close Application