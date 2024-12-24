{-# OPTIONS_GHC -Wno-overlapping-patterns #-}

sumSquares :: Int -> Int -> Int

-- Bottom-up
sumSquares x y = sqX + sqY
    where sqX = x * x
          sqY = y * y
          
sumSquares x y = sq x + sq y
    where sq z = z * z

-- Top-down
sumSquares x y = 
    let sqX = x * x
        sqY = y * y
    in sqX + sqY