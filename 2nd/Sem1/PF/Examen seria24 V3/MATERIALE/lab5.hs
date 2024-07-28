--folosind map filter si fold fara recursivitate sau selectie

sumapatratelor :: [Int] -> Int
sumapatratelor xs = sum(map(\x -> if odd x then x^2 else 0) xs )

sumapatratelor1 :: [Int]-> Int
sumapatratelor1 xs = sum(map (^2) (filter odd xs))

--2
verifTrue :: [Bool] -> Bool
verifTrue xs = foldr (&&) True xs

allVerifies :: (Int -> Bool) -> [Int] -> Bool
allVerifies p xs = foldr (\x acc -> p x && acc) True xs


anyVerifies :: (Int -> Bool) -> [Int] -> Bool
anyVerifies p xs = foldr (\x acc -> p x || acc) False xs


--redefinire map folosind foldr
mapFoldr :: (a -> b) -> [a] -> [b]
mapFoldr f xs = foldr (\x acc -> f x : acc) [] xs

filterFoldr :: (a -> Bool) -> [a] -> [a]
filterFoldr p xs = foldr (\x acc -> if p x then x : acc else acc) [] xs


listToInt :: [Int] -> Int
listToInt xs = foldl (\acc x -> acc * 10 + x) 0 xs


--7a
rmChar :: Char -> String -> String
rmChar c s = filter (/= c) s

--b
rmCharsRec :: String -> String -> String
rmCharsRec [] s = s
rmCharsRec (c:cs) s = rmCharsRec cs (rmChar c s)

--c
rmCharsFold :: String -> String -> String
rmCharsFold cs s = foldr rmChar s cs

--8
myReverse :: [Int] -> [Int]
myReverse xs = foldl (\acc x -> x : acc) [] xs

--9
myElem :: Int -> [Int]-> Bool
myElem nr lista = elem nr lista

--10
myUnzip :: [(a,b)] -> ([a],[b])
myUnzip xs = foldr (\(a,b) (as,bs) -> (a:as, b:bs)) ([],[]) xs

--11 
union :: [Int] -> [Int] -> [Int]
union [] ys = ys
union (x:xs) ys
    | elem x ys = union xs ys
    | otherwise = x : union xs ys


intersect :: [Int]->[Int]->[Int]
intersect [] _ = []
intersect (x:xs) ys
    | elem x ys = x : intersect xs ys
    | otherwise = intersect xs ys


permutations :: [Int] -> [[Int]]
permutations [] = [[]]
permutations xs = [x:ys | x <- xs, ys <- permutations (filter (/=x) xs)]
