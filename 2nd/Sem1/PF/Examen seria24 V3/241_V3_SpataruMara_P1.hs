p1 :: [Int] -> [Int]
p1 [] = [] 
p1 (x:xl)
    | x >=0 && x<=9 = [x] ++ [x] ++ p1 xl
    | x >= 10 && even x = p1 xl
    | elem x [11,33,55] = [x^2] ++ p1 xl

--rezolvarea cu Monada
p1M :: [Int] -> [Int]
p1M xl = concat $ xl >>= p1Int
    where
        p1Int x
            | x >=0 && x<=9 = [[x]] ++ [[x]] 
            | x >= 10 && even x = []
            | elem x [11,33,55] = [[x^2]] 