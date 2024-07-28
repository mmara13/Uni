import Data.Char
import Control.Monad
data Prop = V String | T | F | Prop :&: Prop | Prop :|: Prop
    deriving (Show,Eq)

class Operations exp where
    simplify :: exp -> exp

instance Operations Prop where
    simplify exp = 
        let simplified = simplifyOnce exp
        in if simplified == exp then exp else simplify simplified
        where
            simplifyOnce (p :&: T) = p
            simplifyOnce (T :&: p) = p
            simplifyOnce (p :&: F) = F
            simplifyOnce (F :&: p) = F
            simplifyOnce (p :|: T) = T
            simplifyOnce (T :|: p) = T
            simplifyOnce (F :|: p) = p
            simplifyOnce (p :|: F) = p
            simplifyOnce (p1 :&: p2) = simplify p1 :&: simplify p2
            simplifyOnce (p1 :|: p2) = simplify p1 :|: simplify p2
            simplifyOnce p = p

-- instance Operations Prop where 
--     simplify (p1 :&: p2) = simplifyAnd (simplify p1) (simplify p2)
--     simplify (p1 :|: p2) = simplifyOr (simplify p1) (simplify p2)
--     simplify p = p 

-- simplifyAnd :: Prop -> Prop -> Prop 
-- simplifyAnd T p = p
-- simplifyAnd p T = p
-- simplifyAnd _ F = F
-- simplifyAnd F _ = F
-- simplifyAnd p1 p2 = p1 :&: p2 

-- simplifyOr :: Prop -> Prop -> Prop 
-- simplifyOr T _ = T
-- simplifyOr _ T = T
-- simplifyOr p F = p
-- simplifyOr F p = p
-- simplifyOr p1 p2 = p1 :|: p2

prop1 = ((V "p") :|: (V "q")) :&: T
prop2 = prop1 :|: (V "r")
prop3 = ((F :&: V "p") :|: (V "q"))
prop4 = prop3 :&: (V "q")

p2 :: String -> String
p2 [] = []
p2 (x:xs) 
    | isUpper x == True = [toLower x] ++ p2 xs
    | isLower x == True = [toUpper x] ++ p2 xs
    | isAlphaNum x == True = "*" ++ p2 xs
    | otherwise = p2 xs
    
p2M :: String -> String
p2M xs = concat $ xs >>= p2Char
    where
        p2Char x
            | isUpper x  = [[toLower x]] 
            | isLower x = [[toUpper x]] 
            | isAlphaNum x = ["*"]
            | otherwise = [""]

newtype WriterM a = MW {getMW :: (Maybe a, String)}
    deriving Show

instance Monad WriterM where
    return x = MW (Just x, "")
    ma >>= k = let (a1,s1) = getMW ma
                in case a1 of
                    Nothing -> MW (Nothing, s1)
                    Just val -> let (a2,s2) = getMW $ k val
                                in MW (a2, s1 ++ s2)
instance Applicative WriterM where
    pure = return
    mf <*> ma = do
        f <- mf
        a <- ma
        return (f a)

instance Functor WriterM where
    fmap f ma = pure f <*> ma

testWriterM :: WriterM Int
testWriterM = ma >>= k 
    where 
        ma = 
            MW (Just 7, "ana are mere")
        k x = 
            MW (if x `mod` 2 == 0 then Just x else Nothing, "si pere")