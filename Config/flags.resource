*** Settings ***

Library    AppiumLibrary
Library    DateTime
Library    String
Library    Collections



*** Variables ***

#Modo USB
${usbMode}         False

${flagRegSalvo}=    ${False}
${flagTagOS}=    ${null}
${flagTagSS}=    ${null}

