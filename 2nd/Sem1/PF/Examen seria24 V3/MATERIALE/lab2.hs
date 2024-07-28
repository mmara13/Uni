poly :: Double -> Double -> Double -> Double -> Double
poly a b c x = a*(x*x) + b*x + c

eeny :: Int -> String
eeny n
    | even n    = "eeny"
    | otherwise = "meeny"

fizzbuzz :: Int -> String
fizzbuzz k 
    | k `mod` 15 == 0 = "fizzbuzz"
    | k `mod` 3 == 0  = "fizz"
    | k `mod` 5 == 0  = "buzz"
    | otherwise       = ""


tribonacci :: Integer -> Integer
tribonacci 0 = 1
tribonacci 1 = 1
tribonacci 2 = 2
tribonacci n = tribonacci (n-1) + tribonacci (n-2) + tribonacci (n-3)


binomial :: Integer -> Integer -> Integer
binomial n k
    | k == 0    = 1
    | k == n    = 1
    | otherwise = binomial (n-1) (k-1) + binomial (n-1) k

verifL :: [a] -> Bool
verifL xs = even (length xs)


takefinal :: Int -> [a] -> [a]
takefinal n xs
    | length xs <= n = xs
    | otherwise      = drop (length xs - n) xs

remove :: Int -> [a] -> [a]
remove n xs = take n xs ++ drop (n+1) xs



myreplicate :: Int -> a -> [a]
myreplicate n v
    | n <= 0    = []
    | otherwise = v : myreplicate (n-1) v


sumImp :: [Int] -> Int
sumImp [] = 0
sumImp (x:xs)
    | odd x     = x + sumImp xs
    | otherwise = sumImp xs


totalLen :: [String] -> Int
totalLen xs = sum [length x | x <- xs, head x == 'A']
