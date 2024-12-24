data Pairs t = Pair t t
Pair 6 8 :: Pairs Int
Pair True True :: Pairs Bool
Pair [] [1, 3] :: Pair [Int]

data List t = Nil | Cons t (List t)