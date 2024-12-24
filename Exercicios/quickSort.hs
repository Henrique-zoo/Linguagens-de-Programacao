-- Implementação Naive
quickSortNaive :: (Ord a) => [a] -> [a]
quickSortNaive [] = []
quickSortNaive (pivo:xs) = quickSortNaive menores ++ [pivo] ++ quickSortNaive maiores
    where
        menores = menoresQuePivo xs pivo
        maiores = maioresQuePivo xs pivo

menoresQuePivo :: (Ord a) => [a] -> a -> [a]
menoresQuePivo [] _ = []
menoresQuePivo (x:xs) pivo
    | x <= pivo = x : menoresQuePivo xs pivo
    | otherwise = menoresQuePivo xs pivo

maioresQuePivo :: (Ord a) => [a] -> a -> [a]
maioresQuePivo [] _ = []
maioresQuePivo (x:xs) pivo
    | x > pivo = x : maioresQuePivo xs pivo
    | otherwise = maioresQuePivo xs pivo


-- List Comprehension
quickSort :: Ord t => [t] -> [t]
quickSort [] = []
quickSort (x : xs) = quickSort [y | y <- xs, y <= x] ++ [x] ++ quickSort [y | y <- xs, y > x]