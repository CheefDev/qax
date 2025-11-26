*** Settings ***

Library    AppiumLibrary
Library    DateTime
Library    String
Library    Collections

*** Variables ***

#Configurações do Dispositivo:

#Menu Principal
${cfgmOrdServ}    True
${cfgmColAcu}     True
${cfgmEvento}     True
${cfgmRotaAcu}    True
${cfgmRequis}     True
${cfgmSLA}        True
${cfgmDocs}       True
${cfgmSolic}      True
${cfgmColTen}     True
${cfgmViagem}     True
${cfgmRotaTen}    True
${cfgmRelat}      True
${cfgmSolMat}     True
${cfgmDossie}     True
${cfgmInvent}     True
${cfgmCalend}     True
${cfgmMapa}       True

#Midia
${cfgmFoto}       True
${cfgmVideo}      True
${cfgmGaleria}    True
${cfgmArquivo}    True
${cfgmAudio}

#Ordem de Serviço
${cfgmOSOutroSetor}      True    #Permitir acesso a O.S. de outros setores executantes
${cfgmServSemFunc}       True    #Permitir lançamento de serviços sem registrar funcionário
${cfgmAlteraDescServ}    True    #Permitir alterar a descrição dos registros de serviço da O.S.
${cfgmDataManualFunc}    True    #Permitir informar manualmente data/hora do registro de funcionário
${cfgmAbrirOS}           True    #Permitir abrir Ordem de Serviço no Dispositivo
${cfgmAssObrigatoria}    N       #Assinatura Obrigatória na OS: N,F,L,FL,FLL 
${cfgmRelacFuncsServ}    True    #Relacionar todos os funcionários com todos os serviços na importação
${cfgmPerCadastro}       True    #Permitir Cadastro
${cfgmPerEncerra}        True    #Permitir Encerramento
${cfgmPerFunc}           True    #Permitir Registro de Funcionario
${cfgmPerServico}        True    #Permitir Registro e Serviço
${cfgmPerFechaOS}        True    #Permitir Fechar OS
${cfgmPerCancelaOS}      True    #Permitir Cancerlar OS
${cfgmDataFotos}         False   #Adicionar Data/Hora nas fotos