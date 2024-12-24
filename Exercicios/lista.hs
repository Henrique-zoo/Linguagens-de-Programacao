double :: [Int] -> [Int]
double [] = []
double (y:ys) = (2*y) : double ys

member :: [Int] -> Int -> Bool
member [] _ = False
member (l:ls) key
    | l == key = True
    | otherwise = member ls key

sumPairs :: [(Int, Int)] -> [Int]
sumPairs [] = []
sumPairs (elem:lista) = (f + s) : sumPairs lista
    where (f, s) = elem