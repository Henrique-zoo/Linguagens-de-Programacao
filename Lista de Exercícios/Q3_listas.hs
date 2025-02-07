module Q3_listas where

diferenca :: [Int] -> [Int] -> [Int]
diferenca (x:xs) (y:ys) = [z | z <- xs, not (search z ys)]

search :: Int -> [Int] -> Bool
search x [] = False
search x (l:resto) = search x resto 