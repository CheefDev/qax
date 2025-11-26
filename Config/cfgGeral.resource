*** Settings ***

Library    AppiumLibrary
Library    DateTime
Library    String
Library    Collections

*** Variables ***

#Configurações Gerais
#N - Nada
#B - Bloquear
#A - Avisar

#Config Gerais -> Geral -> Ordem De Serviço -> Segurança
${cfgMaterialNaoRelacionadoAplic}     N
${cfgFuncOutroSetor}                  B
${cfgFuncOutraFilial}                 B
${cfgFuncNaoQualificado}              B
${cfgFuncOutroCargo}                  B
${cfgFuncForaDaEscala}                A
${cfgAgrupamentoDivergAplic}          B
${cfgFuncAntesDataProg}               A    
${cfgAplicJaPossuiOS}                 A
${cfgAplicNaGarantia}                 A
${cfgAtDataManutencao}                N
${cfgPlanoNaoRelacAplicCont}          N
${cfgFuncQualifVencida}               A
${cfgFuncAntDataProg}                 A
${cfgPlanejHrsSuperiorAPrev}          N
${cfgPlanejHrsInferiorAPrev}          N
${cfgLimiteAlocacaoMaoDeObra}         11
${cfgDataParouInferorDataProg}        A
${cfgFechVerifAplicParouFuncionou}    N
${cfgFechOSReqPendente}               N
${cfgRegMatSMapeamento}               A
${cfgExigeMotLib}                     S
${cfgPerAvalOSdeSS}                   S
${cfgFecharServNExec}                 A
${cfgFecMatSemQuant}                  A
${cfgFecMatAdSemQuant}                A
${cfgFecMatSemAlm}                    A

#Config Gerais -> Geral -> Solicitação De Serviço -> Segurança

${cfgAplicJaPossuiSS}                 A    #Ao informar aplicação que possui SS abertas
${cfgUsrPossuiPendAprov}              N    #Usuário possui pendências de aprovação


#Configurações Gerais -> Dispositivos Móveis -> Segurança

${cfmMultiEmp}                True
${cfmUserNaAssinatura}        True
${cfmImportaAnexos}           True

#As Duas são a mesma configuração, porém há opção para bloquear só ao fechar ou liberar.
${cfmFecharSemDataTermino}     B
${cfmLiberarSemDataTermino}    N


${cfmFecharOSSemMidia}         B
${cfmLiberarOSSemMidia}        B
${cfgFechFuncPrev}             A
#Config Limite de Variação Mobile

${cfmLimiteAcumulativa}       10
${cfmLimiteTendencia}         10

${cfmImportObsPlano}          True
