import Data.List (isPrefixOf)
import Data.Char
-- 
--data Expr = X | Const Int | Expr :+: Expr | Expr :*: Expr 
--     deriving (Show,Eq)
-- class Operations exp where
--     compute :: exp -> exp

-- rec :: Expr -> Int -> Expr
-- rec e n 
--     | n == 1 = e
--     | n>1 = e :+: rec e (n-1)

-- instance Operations Expr where
--     compute X = X
--     compute (Const a) = Const a
--     compute (Const 0 :*: exp) = Const 0
--     compute (Const 1 :*: exp) = compute exp
--     compute (Const n :*: exp) = rec exp n
--     compute (exp1 :+: exp2) = (compute exp1) :+: (compute exp2)
--     compute (exp1 :*: exp2) = (compute exp1) :*: (compute exp2)

-- exxx =  (Const 3 :*: X) :+: (Const 0 :*: X)
-- exx =  Const 2 :*: (X :+: Const 1)

--rezolvare model examen

ex1 :: [Int] -> Int
ex1 [] = 0
ex1 [x] = 0
ex1 (x:y:xs) = if mod x 3 == 0 && mod y 3 == 0 
                then x-y + ex1 (y:xs)
                else x*y + ex1 (y:xs)

nrVoc :: String -> Int
nrVoc [] = 0
nrVoc (x:xs) = if elem x "aeiouAEIOU" 
                then 1 + nrVoc xs
                else nrVoc xs

nrCons :: String -> Int
nrCons [] = 0
nrCons (x:xs) = if not (elem x "aeiouAEIOU,.?! ") 
                then 1 + nrCons xs
                else nrCons xs

ex2 :: [String] -> Int -> Bool
ex2 [] _ = True
ex2 (x:xs) n =
     if length x > n --daca lg > n
                    then if (nrVoc x == nrCons x)
                        then True && ex2 xs n
                    else False && ex2 xs n
                else ex2 xs n

sums :: [Int] -> Int
sums [] = 0
sums (x:xs) 
    |mod x 2 == 0 = x + sums xs
    |otherwise = sums xs
ex3 :: [[Int]] -> Int
ex3 [] = 1
ex3 (x:xs) = sums x * ex3 xs


ex4 :: [String] -> String -> Bool
ex4 xs s = allEvenLength (filter (isPrefixOf s) xs)
    where
        allEvenLength [] = True
        allEvenLength (x:xs) = even (length x) && allEvenLength xs


--exercitiul 5

type Name = String
type Def = String
data Dictionar = I Name Def
    | Ld Name [Dictionar]
    deriving Show


d1 = Ld "animal"[Ld "mamifer"[I "elefant" "acesta e un elefant", I "caine" "acesta este un caine", I "pisica" "aceasta este o pisica"], I "animale domestice" "definitie"]
d2 = Ld "Animal"[Ld "Mamifer"[I "Elefant" "acesta e un elefant",I "calne" "acesta este un caine",I "piSIca" "aceasta este o pisica"],I "animale domestice" "definitie"]
d3 = Ld "animal"[Ld "mamifer" [I "elefant" "Acesta e un Elefant", I "caine" "acesta este un caine", I "pisica" "aceasta este o pisica"], I "animale domestice" "definitie"]

--sa se scrie o functie care primeste ca parametru un dictionar si intoarce
--o lista cu  titlurile intrarilor din acesta
--titluri d1 = ["elefant", "caine", "pisica", "animale domestice"]
titluri :: Dictionar -> [Name]
titluri (I name _) = [name]
--titluri (Ld name list) = name : concatMap titluri list
titluri (Ld _ list) = foldr (\x acc -> titluri x ++ acc) [] list

--sa se instantieze clasa Eq astfel incat sa se verifice egalitatea inrte doua dicitonare
--comparand componentele lor in ordinea in care apar
--Titlurile intrarilor sunt verificate fara a tine cont de litere mici sau mari
-- I "caine" "animal" == I "CaiNe" "animal" = True
instance Eq Dictionar where
    (I name1 def1) == (I name2 def2) = map(toLower) name1 == map(toLower) name2 &&  def1 == def2


-- Sa se scrie o functie care primeste o lista de liste de numere intregi si doua numere intregi n si m si verifica daca numarul sublistelor care au doar elemente divizibile cu 3 este cuprins intre n si m (sau m si n, in functie de ordinea in care sunt date).
ex6 :: [[Int]] -> Int -> Int -> Bool
ex6 list n m =
  let filteredSublists = filter (\x -> all (\y -> mod y 3 == 0) x) list
      numFilteredSublists = length filteredSublists
      aux = if n > m then n else m
      n' = if n > m then m else n
      m' = aux
  in n' <= numFilteredSublists && numFilteredSublists <= m'


--ex 7
data Tree = Empty 
  | Node Int Tree Tree Tree -- arbore vid cu valoare de tip Int in radacina si 3 fii

extree :: Tree
extree = Node 4 (Node 5 Empty Empty Empty) (Node 3 Empty Empty (Node 1 Empty Empty Empty)) Empty

--Sa se instantieze clasa urmatoare pentru tipul Tree. 
class ArbInfo t where
  level :: t-> Int -- intoarce inaltimea arborelui; pt un arbore vid se considera ca are inaltimea 0
  sumval:: t -> Int -- intoarce suma valorilor din arbore
  nrFrunze :: t -> Int -- intoarce nr de frunze al arborelui

-- exemple:
-- > level extree
-- 3
-- > sumval extree
-- 13
-- > nrFrunze extree
-- 9
instance ArbInfo Tree where
    level Empty = 0
    level (Node _ left right middle) = 1 + maximum [level left, level right, level middle]
    sumval Empty = 0
    sumval (Node val left right middle) = val + sumval left + sumval right + sumval middle
    nrFrunze Empty = 0
    nrFrunze (Node _ Empty Empty Empty) = 1
    nrFrunze (Node _ left right middle) = nrFrunze left + nrFrunze right + nrFrunze middle
    
    