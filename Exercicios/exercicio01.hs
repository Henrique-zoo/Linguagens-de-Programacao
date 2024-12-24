makeSpaces :: Int -> String
makeSpaces n
    | n <= 0 = ""
    | otherwise = " " ++ makeSpaces (n-1)

pushRight :: Int -> String -> String
pushRight n s = makeSpaces n ++ s