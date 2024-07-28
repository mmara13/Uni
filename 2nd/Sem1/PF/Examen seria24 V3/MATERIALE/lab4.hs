{-[x^2 | x<-[1..10], x `rem` 3 == 2]
//toate numerele de la 1 la 10 care la imp cu 3 dau rest 2, ridicate la patrat
[ (x,y) | x <- [1..5], y <- [x..(x+2)] ]
//(1,1) (1,2) (1,3) , (2,2) , 2, 3   (2,4) etc
[ (x,y) | x <- [1..3], let k = xˆ2, y <- [1..k] ]
(1, 1) (2,2) (2,3) (2,4) ... (3,9)  
[ x | x <- "Facultatea de Matematica si Informatica", elem x ['A'..'Z'] ]
[ [x..y] | x <- [1..5], y <- [1..5], x < y ]
//[1,2] [1,2,3] [1..5], .... ,[4,5]
-}

factori :: Int -> [Int]
factori n = [ x | x <- [1..n], n `mod` x ==0]

prim :: Int -> Bool
prim n = length (factori n) == 2

numerePrime :: Int -> [Int]
numerePrime n = [x | x<-[2..n], prim x]

myzip3 :: [a] -> [b] -> [c] -> [(a,b,c)]
myzip3 l1 l2 l3 = [(a,b,c) | (a,(b,c))<- zip l1 (zip l2 l3)]

firstEl :: [(a,b)] -> [a]
firstEl xs = map fst xs

sumList :: [[Int]] -> [Int]
sumList = map sum 
--sumList xs = map sum xs

pre12 :: [Int] -> [Int]
pre12 = map (\x -> if odd x then 2*x else x `div` 2)

ex9 :: Char -> [[Char]] -> [[Char]]
ex9 c = filter (elem c)

ex10 :: [Int] -> [Int]
ex10 = map (\x -> if odd x then x*x else x)

-- patrateimpare :: [Int] -> [Int]
-- patrateimpare xs = map (^2) $ filter indeximpar (zip xs [0..])
--   where indeximpar (_, i) = odd i


numaivocale :: [[Char]] -> [[Char]]
numaivocale = map (filter (`elem` "AEIOUaeiou"))

mymap :: (a -> b) -> [a] -> [b]
mymap f [] = []
mymap f (x:xs) = f x : mymap f xs

myfilter :: (a -> Bool) -> [a] -> [a]
myfilter _ [] = []
myfilter p (x:xs)
    | p x       = x : myfilter p xs
    | otherwise = myfilter p xs
