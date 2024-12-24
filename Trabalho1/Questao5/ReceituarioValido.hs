{-
QUESTÃO 5  VALOR: 1,0 ponto, sendo 0,5 para cada função.
    a) Um receituário é válido se, e somente se, todo os medicamentos são distintos e estão ordenados lexicograficamente e, para cada medicamento, seus horários também estão ordenados e são distintos. Defina a função "receituarioValido".
-}

module Questao5.ReceituarioValido where

import TiposDoProjeto ( Horario, Receituario )
import Testes
    ( receituario1,
      receituario2,
      receituarioInvalido1,
      receituarioInvalido2,
      receituarioInvalido3,
      receituarioInvalido4 )

receituarioValido :: Receituario -> Bool
receituarioValido [] = True
receituarioValido [(_, lH)] = horariosEmOrdem lH
receituarioValido ((m, lH) : ((m2, lH2) : resto))
    | (m < m2) && (horariosEmOrdem lH) = receituarioValido ((m2, lH2) : resto)
    | otherwise = False

horariosEmOrdem :: [Horario] -> Bool
horariosEmOrdem [] = True
horariosEmOrdem [h] = True
horariosEmOrdem (h : (h2 : hs))
    | h < h2 = horariosEmOrdem (h2 : hs)
    | otherwise = False

main :: IO()
main = do
    let caso5_1a = receituarioValido receituario1
    let caso5_2a = receituarioValido receituario2
    let caso5_3a = receituarioValido receituarioInvalido1
    let caso5_4a = receituarioValido receituarioInvalido2
    let caso5_5a = receituarioValido receituarioInvalido3
    let caso5_6a = receituarioValido receituarioInvalido4

    print caso5_1a
    print caso5_2a
    print caso5_3a
    print caso5_4a
    print caso5_5a
    print caso5_6a
    
    print (and [caso5_1a, caso5_2a, not caso5_3a, not caso5_4a, not caso5_5a, not caso5_6a])