{- A equação a ∙ x² + b ∙ x + c = 0.0 tem
    - Duas raízes reais se b² > 4∙a∙c
    - Uma raiz real se b² == 4∙a∙c
    - Nenhuma raiz real se b² < 4∙a∙c -}

-- Resolução bottom-up

oneRoot :: Float -> Float -> Float -> Float
oneRoot a b c = - (b / (2.0*a))

twoRoots :: Float -> Float -> Float -> (Float, Float)
twoRoots a b c = (d - e, d + e)
    where
        d = - (b / (2.0 * a))
        e = sqrt(b^2 - 4.0 * a * c) / (2.0 * a)

roots :: Float -> Float -> Float -> String
roots a b c
    | b^2 == 4.0 * a * c = show (oneRoot a b c)
    | b^2 > 4.0 * a * c = "(" ++ show f ++ ", " ++ show s ++ ")"
    | otherwise = "No roots!"
    where (f, s) = twoRoots a b c