import Data.Char
nrVocale :: [String] -> Int
nrVocale = sum . map (length . filter (`elem` "aeiouAEIOU")) . filter (\s -> s == reverse s)


adauga :: Int -> [Int] -> [Int]
adauga n [] = []
adauga n (x:xs) 
    | even x    = x : n : adauga n xs
    | otherwise = x : adauga n xs

divizori :: Int -> [Int]
divizori n = [x | x <- [1..n], n `mod` x == 0]

listadiv :: [Int] -> [[Int]]
listadiv xs = [ divizori x| x <-xs ]

inIntervalRec :: Int -> Int -> [Int] -> [Int]
inIntervalRec x y [] = []
inIntervalRec x y (n:ns)
    | n `elem` [x..y] = n : inIntervalRec x y ns
    | otherwise       = inIntervalRec x y ns


inIntervalComp :: Int -> Int -> [Int] -> [Int]
inIntervalComp x y xs = [n| n<-[x..y], n `elem` xs]


pozitiveRec :: [Int] -> Int
pozitiveRec [] = 0 
pozitiveRec (x:xs)
    | x>0        = pozitiveRec xs + 1
    | otherwise  = pozitiveRec xs 

pozitiveComp :: [Int] -> Int
pozitiveComp xs = length [x | x<-xs , x>0]


pozitiiImpareAux :: Int -> [Int]->[Int]
pozitiiImpareAux _ [] = []
pozitiiImpareAux i (x:xs)
    | odd x = i : pozitiiImpareAux(i+1) xs
    | otherwise = pozitiiImpareAux(i+1) xs

pozitiiImpareRec :: [Int]->[Int]
pozitiiImpareRec xs = pozitiiImpareAux 0 xs


pozitiiImpareComp :: [Int] -> [Int]
pozitiiImpareComp xs = [fst p | p <- zip [0..] xs, odd (snd p)]

multDigitsRec :: String -> Int
multDigitsRec [] = 1
multDigitsRec (x:xs)
    | x `elem` ['0'..'9'] = digitToInt(x) * multDigitsRec xs
    | otherwise          = multDigitsRec xs

multDigitsComp :: String -> Int
multDigitsComp xs = product [digitToInt x | x <- xs, x `elem` ['0'..'9']]

