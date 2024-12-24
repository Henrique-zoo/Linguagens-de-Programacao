{-
QUESTÃO 4  VALOR: 1,0 ponto
    Defina a função "demandaMedicamentos", cujo tipo é dado abaixo e que computa a demanda de todos os medicamentos por um dia a partir do receituario. O retorno é do tipo EstoqueMedicamentos e deve ser ordenado lexicograficamente pelo nome do medicamento.
    
    Dica: Observe que o receituario lista cada remédio e os horários em que ele deve ser tomado no dia. Assim, a demanda de cada remédio já está latente no receituario, bastando contar a quantidade de vezes que cada remédio é tomado.
-}

module Questao4.DemandaMedicamentos where

import TiposDoProjeto (
    Medicamento,
    Quantidade,
    EstoqueMedicamentos,
    Receituario )
import Testes
    ( med4, med6, med7, med8, receituario1, receituario2 )

demandaMedicamentos :: Receituario -> EstoqueMedicamentos
demandaMedicamentos receituario = quickSort ([(m, length h) | (m, h) <- receituario])

quickSort :: EstoqueMedicamentos -> EstoqueMedicamentos
quickSort [] = []
quickSort (x:xs) = quickSort menores ++ [x] ++ quickSort maiores
    where
        menores = [y | y <- xs, y < x]
        maiores = [y | y <- xs, y > x]

-- Só para testar melhor
mostrarEstoque :: EstoqueMedicamentos -> String
mostrarEstoque [] = ""
mostrarEstoque ((med, q) : resto)
    | null resto = "[(" ++ show med ++ ", " ++ show q ++ ")]" ++ mostrarEstoque resto
    | otherwise = "[(" ++ show med ++ ", " ++ show q ++ "); " ++ mostrarEstoque resto

main :: IO()
main = do
    let caso4_1 = demandaMedicamentos receituario1
    let teste1 = caso4_1 == [(med4, 2), (med6, 1), (med7, 1)]
    putStrLn (mostrarEstoque caso4_1)
    print teste1

    let caso4_2 = demandaMedicamentos receituario2
    let teste2 = caso4_2 == [(med4, 2), (med6, 1), (med7, 1), (med8, 3)]
    putStrLn (mostrarEstoque caso4_2)
    print teste2

    print (teste1 && teste2)