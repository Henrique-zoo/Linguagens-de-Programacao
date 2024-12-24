{-
QUESTÃO 2, VALOR: 1,0 ponto
   Defina a função "tomarMedicamento", cujo tipo é dado abaixo e que, a partir de um medicamento e de um estoque de medicamentos, retorna um novo estoque de medicamentos, resultante de 1 comprimido do medicamento ser ministrado ao paciente. Se o medicamento não existir no estoque, Nothing deve ser retornado. Caso contrário, deve se retornar Just v, onde v é o novo estoque.
-}
module Questao2.TomarMedicamento where

import TiposDoProjeto ( EstoqueMedicamentos, Medicamento )
import Testes ( med4, med6, med7, med8, estoque1 )

tomarMedicamento :: Medicamento -> EstoqueMedicamentos -> Maybe EstoqueMedicamentos
tomarMedicamento _ [] = Nothing -- O medicamento não está no estoque
tomarMedicamento medicamento ((m, q) : resto)
   | medicamento == m && q > 0 = Just ((m, q - 1) : resto) -- Encontramos o medicamento no estoque, mas sua quantidade é 0
   | medicamento == m && q <= 0 = Nothing -- Encontramos o medicamento no estoque e sua quantidade é > 0
   | otherwise = case tomarMedicamento medicamento resto of -- Ainda não encontramos o mediamento no estoque
      Nothing -> Nothing -- Se a chamada recursiva da linha anterior da função tomarMedicamento com o resto do estoque retornar Nothing, isto é, se o medicamento não estiver no estoque ou sua quantidade for 0, a função retorna Nothing 
      Just novoResto -> Just ((m, q) : novoResto) -- Se a chamada recursiva retornar o Just do resto da lista atualizado (ou seja, o medicamento foi encontrado e consumido), a função retorna o Just do estoque atualizado.

main :: IO()
main = do
   let caso2_1 = tomarMedicamento med4 estoque1
   print caso2_1

   let caso2_2 = tomarMedicamento med8 estoque1
   print caso2_2

   print (caso2_1 == Just [(med4, 9), (med6, 5), (med7, 0)] && caso2_2 == Nothing)