import Data.Maybe (isJust, fromJust)
import Language.Haskell.TH (safe)
import Data.Text.Internal.Encoding.Utf32 (validate)
--import Prelude.lappend
data List a = Nil 
            | Cons a (List a)
        deriving (Eq, Show)

instance Functor List where
    fmap f Nil = Nil
    fmap f (Cons x xs) = Cons (f x) (fmap f xs)

instance Applicative List where
    pure x = Cons x Nil
    Nil <*> _ = Nil
    _ <*> Nil = Nil
--    Cons f fs <*> xs = --append (fmap f xs) (fs <*> xs) 

--exercitiul 2
data Cow = Cow {
    name :: String
    , age :: Int
    , weight :: Int
    } deriving (Eq, Show)

--a) noEmpty si noNegative care valideaza un string, 
--respectiv un numar intreg
noEmpty :: String -> Maybe String
noEmpty "" = Nothing
noEmpty str = Just str

noNegative :: Int -> Maybe Int
noNegative n
    | n < 0 = Nothing
    | otherwise = Just n

test21 = noEmpty "abc" == Just "abc"
test22 = noNegative(-5) == Nothing
test23 = noNegative 5 == Just 5

--b) construieste un element de tip Cow verificand numele
--varsta si greutatea folosind functiile de la A)
-- cowFromString :: String -> Int -> Int -> Maybe Cow
-- cowFromString n a w 
--     | isValid = Just (Cow {name = name', age = age', weight = weight'})
--     | otherwise = Nothing
--     where 
--         isValid = noEmpty n /= Nothing && noNegative a /= Nothing && noNegative w /= Nothing
--         name' = if isJust (noEmpty n) then fromJust (noEmpty n) else ""
--         age' = if isJust (noNegative a) then fromJust (noNegative a) else -1
--         weight' = if isJust (noNegative w) then fromJust (noNegative w) else -1

test24 = cowFromString "Milka" 5 100 == Just (Cow {name="Milka", age = 5, weight = 100})

--acelasi lucru cu fmap si <*>
cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString n a w = 
    if isValid  
        then Cow <$> name' <*> age' <*> weight'
        else Nothing
    where 
        isValid = isJust (noEmpty n) && isJust (noNegative a) && isJust (noNegative w)
        name' = noEmpty n
        age' = noNegative a
        weight' = noNegative w


--exercitiul 3
newtype Name = Name String deriving (Eq,Show)
newtype Address = Address String deriving (Eq, Show)

data Person = Person Name Address
    deriving(Eq,Show)
--a
validateLength :: Int -> String -> Maybe String
validateLength n s
    | length s <= n = Just s
    | otherwise = Nothing
test31 = validateLength 5 "abc" == Just "abc"
--b
mkName :: String -> Maybe Name
mkName s 
    | validateLength 26 s == Just s = Just (Name s)
    | otherwise = Nothing

mkAddress :: String -> Maybe Address
mkAddress s
    | validateLength 101 s == Just s = Just (Address s)
    | otherwise = Nothing

test32 = mkName "Gigel" == Just (Name "Gigel")
test33 = mkAddress "Str Academiei" == Just (Address "Str Academiei")

--c implementati mkPerson care primeste ca argumente doua siruri de caractere
--si formeaza un element de tip Person daca sunt validate conditiile
--(functiile implementate mai sus)
mkPerson :: String -> String -> Maybe Person
mkPerson n a
    | mkAddress a == Just (Address a) && mkName n == Just (Name n) = Just (Person (Name n) (Address a))
    | otherwise = Nothing

test34 = mkPerson "Gigel" "Str Academiei" == Just (Person (Name "Gigel") (Address "Str Academiei"))

--d) aceleasi functii mk dar cu fmap si <*>
mkName2 :: String -> Maybe Name
mkName2 s = Name <$> validateLength 26 s

mkAddress2 :: String -> Maybe Address
mkAddress2 s = Address <$> validateLength 101 s

mkPerson2 :: String -> String -> Maybe Person
mkPerson2 n a = Person <$> mkName2 n <*> mkAddress2 a

test35 = mkName2 "Gigel" == Just (Name "Gigel")
test36 = mkAddress2 "Str Academiei" == Just (Address "Str Academiei")
test37 = mkPerson2 "Gigel" "Str Academiei" == Just (Person (Name "Gigel") (Address "Str Academiei"))


