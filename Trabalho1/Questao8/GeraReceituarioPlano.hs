{-
QUESTÃO 8  VALOR: 1,0 ponto
    Defina a função "geraReceituarioPlano", cujo tipo é dado abaixo e que retorna um receituário válido a partir de um plano de medicamentos válido.

    Dica: Existe alguma relação de simetria entre o receituário e o plano de medicamentos? Caso exista, essa simetria permite compararmos a função geraReceituarioPlano com a função geraPlanoReceituario ? Em outras palavras, podemos definir geraReceituarioPlano com base em geraPlanoReceituario ?
-}

module Questao8.GeraReceituarioPlano where

import TiposDoProjeto
    ( Horario, Medicamento, PlanoMedicamento, Receituario )
import Testes
    ( med4, med6, med7, med8, receituario1, receituario2 )
import Questao7.GeraPlanoReceituario ( geraPlanoReceituario )

geraReceituarioPlano :: PlanoMedicamento -> Receituario
geraReceituarioPlano planoMedicamento = ordenarReceituario (agruparHorarios expandePlano)
    where
        expandePlano :: [(Medicamento, Horario)]
        expandePlano = [(m, h) | (h, ms) <- planoMedicamento, m <- ms]

        agruparHorarios :: [(Medicamento, Horario)] -> Receituario
        agruparHorarios [] = []
        agruparHorarios ((m, h) : resto) = (m, h : [h' | (m', h') <- resto, m' == m]) : agruparHorarios (removerMedicamentos m resto)
            where
                removerMedicamentos :: Medicamento -> [(Medicamento, Horario)] -> [(Medicamento, Horario)]
                removerMedicamentos _ [] = []
                removerMedicamentos m ((m', h') : resto)
                    | m' == m = removerMedicamentos m resto
                    | otherwise = (m', h') : removerMedicamentos m resto
        
        ordenarReceituario :: Receituario -> Receituario
        ordenarReceituario [] = []
        ordenarReceituario (x : xs) = ordenarReceituario menores ++ [x] ++ ordenarReceituario maiores
            where
                menores = [y | y <- xs, fst y < fst x]
                maiores = [y | y <- xs, fst y > fst x]

main :: IO()
main = do
    let caso8_1 = geraReceituarioPlano (geraPlanoReceituario receituario1)
    let teste1 = caso8_1 == receituario1

    print caso8_1
    print teste1

    let caso8_2 = geraReceituarioPlano (geraPlanoReceituario receituario2)
    let teste2 = caso8_2 == receituario2

    print caso8_2
    print teste2

    print (teste1 && teste2)