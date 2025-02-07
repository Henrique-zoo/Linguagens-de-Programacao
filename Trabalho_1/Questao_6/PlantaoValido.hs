{-
QUESTÃO 6  VALOR: 1,0 ponto,
    Um plantão é válido se, e somente se, todas as seguintes condições são satisfeitas:

    1. Os horários da lista são distintos e estão em ordem crescente;
    2. Não há, em um mesmo horário, ocorrência de compra e medicagem de um mesmo medicamento (e.g. `[Comprar m1, Medicar m1 x]`);
    3. Para cada horário, as ocorrências de Medicar estão ordenadas lexicograficamente.

    Defina a função "plantaoValido" que verifica as propriedades acima e cujo tipo é dado abaixo:
-}

module Questao_6.PlantaoValido where

import TiposDoProjeto ( Cuidado(..), Plantao, Medicamento )
import Testes
    ( plantao1,
      plantao2,
      plantao3,
      plantaoInvalido1,
      plantaoInvalido2,
      plantaoInvalido3,
      plantaoInvalido4 )


plantaoValido :: Plantao -> Bool
plantaoValido [] = True
plantaoValido [(_, lA)] = mesmoMedicamento lA (listaMedicamentos lA) && medicarEmOrdem lA
plantaoValido ((h, lA) : ((h2, lA2) : resto))
    | (h < h2) && (mesmoMedicamento lA (listaMedicamentos lA) && medicarEmOrdem lA) = plantaoValido ((h2, lA2) : resto)
    | otherwise = False

listaMedicamentos :: [Cuidado] -> ([Medicamento], [Medicamento])
listaMedicamentos [] = ([], [])
listaMedicamentos (cuidado : xs) = (comprar, medicar)
    where
        (tdsComprar, tdsMedicar) = listaMedicamentos xs
        (comprar, medicar) = case cuidado of
            Comprar m _ -> (m : tdsComprar, tdsMedicar)
            Medicar m   -> (tdsComprar, m : tdsMedicar)

buscar :: Medicamento -> [Medicamento] -> Bool
buscar _ [] = False
buscar medicamento (m : ms)
    | medicamento == m = True
    | otherwise = False

mesmoMedicamento :: [Cuidado] -> ([Medicamento], [Medicamento]) -> Bool
mesmoMedicamento [] _ = True
mesmoMedicamento ((Comprar m q) : resto) (medC, medM)
    | not (buscar m medM) = mesmoMedicamento resto (medC, medM)
    | otherwise = False
mesmoMedicamento ((Medicar m) : resto) (medC, medM)
    | not (buscar m medC) = mesmoMedicamento resto (medC, medM)
    | otherwise = False

medicarEmOrdem :: [Cuidado] -> Bool
medicarEmOrdem [] = True
medicarEmOrdem [_] = True
medicarEmOrdem (Medicar m1 : Medicar m2 : ms)
    | m1 < m2   = medicarEmOrdem (Medicar m2 : ms)
    | otherwise = False
medicarEmOrdem (_ : ms) = medicarEmOrdem ms


main :: IO()
main = do
    let caso6_1 = plantaoValido plantao1
    print caso6_1
    let caso6_2 = plantaoValido plantao2
    print caso6_2
    let caso6_3 = plantaoValido plantao3
    print caso6_3
    let caso6_4 = plantaoValido plantaoInvalido1
    print caso6_4
    let caso6_5 = plantaoValido plantaoInvalido2
    print caso6_5
    let caso6_6 = plantaoValido plantaoInvalido3
    print caso6_6
    let caso6_7 = plantaoValido plantaoInvalido4
    print caso6_7

    print (and [caso6_1, caso6_2, caso6_3, not caso6_4, not caso6_5, not caso6_6, not caso6_7])