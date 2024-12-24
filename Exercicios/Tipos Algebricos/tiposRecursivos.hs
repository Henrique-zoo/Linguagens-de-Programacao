-- Cria o tipo expressão, que pode ser um inteiro, um Add de duas expressões ou um Sub de duas expressões
data Expr = Lit Int
          | Add Expr Expr
          | Sub Expr Expr

-- A função eval realiza as operações descritas por cada valor do tipo Expr
eval :: Expr -> Int
eval (Lit n) = n
eval (Add n m) = (eval n) + (eval m)
eval (Sub n m) = (eval n) - (eval m)

-- Exibe uma Expr como uma String em linguagem matemática
showExpr :: Expr -> String
showExpr (Lit n) = show n
showExpr (Add n m) = showExpr n ++ " + " ++ showExpr m
showExpr (Sub n m) = showExpr n ++ " + " ++ showExpr m

