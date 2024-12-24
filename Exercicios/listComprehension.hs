{- Exemplos triviais
doubleList :: [Int] -> [Int]
doubleList xs = [2*a | a <- xs]

sumPairs :: [(Int, Int)] -> [Int]
sumPairs lp = [a + b | (a, b) <- lp]
-}

type Person = String
type Book = String
type Database = [(Person, Book)]

books :: Database -> Person -> [Book]
books db per = [b | (p, b) <- db, p == per]
