{-
QUESTÃO 7  VALOR: 1,0 ponto
    Defina a função "geraPlanoReceituario", cujo tipo é dado abaixo e que, a partir de um receituario válido, retorne um plano de medicamento válido.

    Dica: enquanto o receituário lista os horários que cada remédio deve ser tomado, o plano de medicamentos  é uma disposição ordenada por horário de todos os remédios que devem ser tomados pelo paciente em um certo horário.
-}

module Questao_7.GeraPlanoReceituario where

import TiposDoProjeto
    ( PlanoMedicamento, Receituario, Horario, Medicamento )
import Testes
    ( med4, med6, med7, med8, receituario1, receituario2 )

geraPlanoReceituario :: Receituario -> PlanoMedicamento
geraPlanoReceituario receituario = ordenarPlano (agruparMedicamentos expandeReceituario)
    where
        expandeReceituario :: [(Horario, Medicamento)]
        expandeReceituario = [(h, m) | (m, hs) <- receituario, h <- hs]

        agruparMedicamentos :: [(Horario, Medicamento)] -> PlanoMedicamento
        agruparMedicamentos [] = []
        agruparMedicamentos ((h, m) : resto) = (h, m : [m' | (h', m') <- resto, h' == h]) : agruparMedicamentos (removerHorarios h resto)
            where
                removerHorarios :: Horario -> [(Horario, Medicamento)] -> [(Horario, Medicamento)]
                removerHorarios _ [] = []
                removerHorarios h ((h', m') : resto)
                    | h == h' = removerHorarios h resto
                    | otherwise = (h', m') : removerHorarios h resto

        ordenarPlano :: PlanoMedicamento -> PlanoMedicamento
        ordenarPlano [] = []
        ordenarPlano (x:xs) = ordenarPlano menores ++ [x] ++ ordenarPlano maiores
            where
                menores = [y | y <- xs, fst y < fst x]
                maiores = [y | y <- xs, fst y > fst x]

main :: IO()
main = do
    let caso7_1 = geraPlanoReceituario receituario1
    print caso7_1
    let teste_1 = caso7_1 == [(6, [med6]), (8, [med4]), (17, [med4]), (22, [med7])]
    print teste_1

    let caso7_2 = geraPlanoReceituario receituario2
    print caso7_2
    let teste_2 = caso7_2 == [(6, [med6]), (8, [med4, med8]), (17, [med4]), (22, [med7, med8]), (23, [med8])]
    print teste_2

    print (teste_1 && teste_2)