{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}
module Maior4 where

maior4 :: Int -> Int -> Int -> Int -> Int
maior4 w x y z = maior2 (maior2 w x) (maior2 y z)

maior2 :: Int -> Int -> Int
maior2 a b = if a >= b then a else b

main :: IO ()
main = do
    entradas <- mapM (const getLine) [1..4]
    let numeros = map read entradas
    putStrLn ("O maior número digitado foi " ++ show (maior4 (numeros !! 0) (numeros !! 1) (numeros !! 2) (numeros !! 3)))