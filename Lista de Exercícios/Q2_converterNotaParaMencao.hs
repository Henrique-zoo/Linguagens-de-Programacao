module ConverterNotaParaMencao where

converterNotaParaMencao :: Float -> String
converterNotaParaMencao nota
    | nota >= 3 && nota < 5 = "MI"
    | nota >= 5 && nota < 7 = "MM"
    | nota >= 7 && nota < 9 = "MS"
    | nota >= 9  && nota <= 10 = "SS"

main :: IO()
main = do
    entrada <- getLine
    let nota = read entrada
    putStrLn (converterNotaParaMencao nota)