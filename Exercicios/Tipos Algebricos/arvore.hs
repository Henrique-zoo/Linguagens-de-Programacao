-- NilT é o elemento nulo do espaço das árvores
data Tree t = NilT |
              Node t (Tree t) (Tree t)
              deriving (Eq, Ord, Show)

depth :: Tree t -> Int
depth NilT = 0
depth (Node _ l r) = max (depth l) (depth r)

collapse :: Tree t -> [t]
collapse NilT = []
collapse (Node n left right) = collapse left ++ [n] ++ collapse right

mapTree :: (t -> u) -> Tree t -> Tree u
mapTree _ NilT = NilT
mapTree f (Node n left right) = Node (f n) (mapTree f left) (mapTree f right)