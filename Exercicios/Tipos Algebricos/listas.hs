data List t = Nil |
              Cons t (List t)

toList :: List t -> [t]
toList Nil = []
toList (Cons e l) = e : (toList l)

fromList :: [t] -> List t
fromList [] = Nil
fromList (atual:resto) = (Cons atual (fromList resto))