import Data.Maybe
import System.Win32 (COORD(xPos), dUPLICATE_CLOSE_SOURCE)
import GHC.Exts.Heap (GenClosure(FloatClosure))
import GHC.Base (noinline)
import Language.Haskell.TH.Ppr (bytesToString)
import Control.Monad.Reader
pos :: Int -> Bool
pos x = if (x>=0) then True else False

fct ::Maybe Int -> Maybe Bool
fct mx = mx >>= (\x -> Just (pos x))

fct2 :: Maybe Int -> Maybe Bool
fct2 mx = do
   x <- mx
   return (pos x)

--a) 
addM :: Maybe Int -> Maybe Int -> Maybe Int
addM mx my 
    | isJust mx && isJust my = Just (fromJust mx + fromJust my)
    | otherwise = Nothing
--b) cu notatia do
addD :: Maybe Int -> Maybe Int -> Maybe Int
addD mx my = do
   if isJust mx && isJust my then return (fromJust mx + fromJust my) else Nothing

--3 rescrieti functiile folosind notatia do

cartesianproduct xs ys = xs >>= (\x -> (ys >>= \y -> return (x,y)))

cartprod xs ys = do
   x<-xs
   y<-ys
   return (x,y)

prod f xs ys = [f x y | x<-xs, y<-ys]

prd f xs ys = do
   x <- xs
   y <- ys
   return (f x y) 

myGetLine :: IO String
myGetLine = getChar >>= \x ->
   if x== '\n' then
      return []
   else 
      myGetLine >>= \xs -> return (x:xs)

myGetLine2 :: IO String
myGetLine2 = do
   x <- getChar 
   if x == '\n' then return [] else (x:) <$> myGetLine2

--4) rescrieti urm functie folosind notatia cu secventiere
prelNo noin = sqrt noin
ioNumber = do
   noin <- readLn :: IO Float
   putStrLn $ "Intrare\n" ++ (show noin)
   let noout = prelNo noin
   putStrLn $ "Iesire"
   print noout

--e deja cu notatia secventiala?
--5
newtype WriterS a =Writer {runWriter :: (a,String)}
--logIncrement
logIncrement :: Int -> WriterS Int
logIncrement x = Writer (x, "increment:" ++ show x)
--logIncrement2
logIncrement2 :: Int -> Int -> WriterS Int
logIncrement2 x y = Writer (x+y, "increment:" ++ show x ++ "\nincrement:" ++ show y)
--logIncrementN
logIncrementN :: Int -> Int -> WriterS Int
logIncrementN x n = foldl (\w i -> let (acc, msg) = runWriter w in Writer (acc + 1, msg ++ "increment:" ++ show (x + i) ++ "\n")) (Writer (x, "")) [0..n-1]
--c) lista de mesaje in loc de concatenarea lor ??
-- logIncrementN2 :: Int -> Int -> WriterS Int
-- logIncrementN2 x n = foldl (\w i -> let (acc, msgs) = runWriter w in Writer (acc + 1, msgs ++ [show (acc + 1)])) (Writer (x, [])) [0..n-1]

--6 
data Person = Person {name :: String, age :: Int}

--a) showPersonN showPersonA
showPersonN :: Person -> String
showPersonN (Person n _) = "NAME: " ++ n

showPersonA :: Person -> String
showPersonA (Person _ a) = "AGE: " ++ show(a)

--b) folosind 5a si 5b showPerson care afiseaza frumos persoanele
showPerson :: Person -> String
showPerson (Person n a) = "(NAME: " ++ n ++ ", AGE: " ++ show(a) ++ ")"

--c) monada Reader def variantele monadice
mshowPersonN :: Reader Person String
mshowPersonN = do
   person <- ask
   let n = name person
   return $ "NAME:" ++ n 

mshowPersonA :: Reader Person String
mshowPersonA = do
   person <- ask
   let a = age person
   return $ "AGE:"++ show a

mshowPerson :: Reader Person String
mshowPerson = do
   person <- ask
   let n = name person
   let a = age person
   return $ "(NAME: " ++ n ++ ", AGE: " ++ show a ++ ")"