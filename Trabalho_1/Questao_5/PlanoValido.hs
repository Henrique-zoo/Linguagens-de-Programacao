{-
QUESTÃO 5  VALOR: 1,0 ponto, sendo 0,5 para cada função.
    b) Inversamente, um plano de medicamentos é válido se, e somente se, todos seus horários também estão ordenados e são distintos, e para cada horário, os medicamentos são distintos e são ordenados lexicograficamente. Defina a função "planoValido".
-}

module Questao_5.PlanoValido where

import TiposDoProjeto ( PlanoMedicamento, Medicamento )
import Testes
    ( plano1,
      planoInvalido1,
      planoInvalido2,
      planoInvalido3,
      planoInvalido4 )

planoValido :: PlanoMedicamento -> Bool
planoValido [] = True
planoValido [(_, lM)] = medicamentosEmOrdem lM
planoValido ((h, lM) : ((h2, lM2) : resto))
    | (h < h2) && medicamentosEmOrdem lM = planoValido ((h2, lM2) : resto)
    | otherwise = False

medicamentosEmOrdem :: [Medicamento] -> Bool
medicamentosEmOrdem [] = True
medicamentosEmOrdem [m] = True
medicamentosEmOrdem (m : (m2 : ms))
    | m < m2 = medicamentosEmOrdem (m2 : ms)
    | otherwise = False

main :: IO()
main = do
    let caso5_1b = planoValido plano1
    let caso5_2b = planoValido plano1
    let caso5_3b = planoValido planoInvalido1
    let caso5_4b = planoValido planoInvalido2
    let caso5_5b = planoValido planoInvalido3
    let caso5_6b = planoValido planoInvalido4

    print caso5_1b
    print caso5_2b
    print caso5_3b
    print caso5_4b
    print caso5_5b
    print caso5_6b

    print (and [caso5_1b, caso5_2b, not caso5_3b, not caso5_4b, not caso5_5b, not caso5_6b])