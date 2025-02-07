{-
QUESTÃO 3  VALOR: 1,0 ponto
    Defina a função "consultarMedicamento", cujo tipo é dado abaixo e que, a partir de um medicamento e de um estoque de medicamentos, retorne a quantidade desse medicamento no estoque. Se o medicamento não existir, retorne 0.
-}

module Questao_3.ConsultarMedicamento where

import TiposDoProjeto
    ( EstoqueMedicamentos, Medicamento, Quantidade )
import Testes ( med6, estoque1 )

consultarMedicamento :: Medicamento -> EstoqueMedicamentos -> Quantidade
consultarMedicamento _ [] = 0
consultarMedicamento medicamento ((m, q) : resto)
    | medicamento == m = q
    | otherwise = consultarMedicamento medicamento resto

main :: IO()
main = do
    let caso3_1 = consultarMedicamento med6 estoque1 == 5
    let caso3_2 = consultarMedicamento "Aas" estoque1 == 0

    print (caso3_1 && caso3_2)