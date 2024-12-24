module Matrizes where

import Control.Monad (replicateM)

matrizTransposta :: [[Int]] -> [[Int]]
matrizTransposta [] = []
matrizTransposta ((elemento : es) : linhas) = linhaAtual : proximasLinhas
    where
        linhaAtual = fst (formaLinha ((elemento : es) : linhas))
        proximasLinhas = matrizTransposta (snd (formaLinha ((elemento : es) : linhas)))

formaLinha :: [[Int]] -> ([Int], [[Int]])
formaLinha [] = ([], [[]])
formaLinha ((elemento : es) : []) = ([elemento], [es])
formaLinha ((elemento : es) : linhas) = (elemento : proxElem, es : resto)
    where
        (proxElem, resto) = formaLinha linhas

main :: IO()
main = do
    putStrLn "Digite o número de linhas da matriz:"
    n <- readLn :: IO Int
    putStrLn $ "Digite as " ++ show n ++ " linhas da matriz (valores separados por espaço):"
    matriz <- replicateM n $ do
        linha <- getLine
        return (map read (words linha) :: [Int])
    putStrLn "A matriz resultante é:"
    let matrizT = matrizTransposta matriz
    mapM_ print matrizT