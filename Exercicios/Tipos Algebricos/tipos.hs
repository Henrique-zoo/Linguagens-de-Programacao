-- Cria o tipo Shape, que pode ser um círculo ou um retângulo
data Shape = Circle Float
           | Rectangle Float Float

-- Circle 4.9 :: Shape
-- Rectangle 4.2 2.0 :: Shape

-- A função isRound diz se uma forma é redonda
isRound :: Shape -> Bool
isRound (Circle _) = True
isRound (Rectangle _ _) = False

-- A função area retorna a área de uma forma
area :: Shape -> Float
area (Circle r) = pi*r*r
area (Rectangle h w) = h * w