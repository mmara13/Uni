data Expr = Var String | Val Int | Plus Expr Expr | Mult Expr Expr
    deriving (Show, Eq)

class Operations exp where
    simplify :: exp -> exp

instance Operations Expr where
    simplify expr =
        let simplified = simplifyOnce expr
        in if simplified == expr then expr else simplify simplified
        where
            simplifyOnce(Plus a (Val 0)) = a
            simplifyOnce(Plus (Val 0) a) = a
            simplifyOnce(Mult a (Val 0)) = Val 0
            simplifyOnce(Mult (Val 0) a) = Val 0
            simplifyOnce(Mult a (Val 1)) = a
            simplifyOnce(Mult (Val 1) a) = a
            simplifyOnce(Mult a1 a2) = Mult (simplify a1) (simplify a2)
            simplifyOnce(Plus a1 a2) = Plus (simplify a1) (simplify a2)
            simplifyOnce a = a


ex1 = Mult (Plus (Val 1) (Var "x")) (Val 1)
ex2 = Plus ex1 (Val 3)
ex3 = Plus (Mult (Val 0) (Val 2)) (Val 3)
ex4 = Mult ex3 (Val 5)

e2 :: String -> String
e2 [] = []
e2 (x:xs)
    | elem x "aeiouAEIOU-.,/ " = [x] ++ e2 xs
    |otherwise = [x] ++ "P" ++ [x] ++ e2 xs
e2M :: String -> String
e2M xs = concat $ xs >>= e2Char
    where
        e2Char x
            |elem x "aeiouAEIOU-.,/ " = [[x]] 
            |otherwise = [[x]] ++ ["P"] ++ [[x]] 

newtype ReaderM env a = ReaderM {runReaderM :: env -> Either String a}

instance Monad (ReaderM env) where
    return a = ReaderM $ \_ -> Right a
    m >>= k = ReaderM $ \env ->
        case runReaderM m env of
            Left err -> Left err
            Right a -> runReaderM (k a) env

instance Applicative (ReaderM env) where
    pure = return
    mf <*> ma = do
        f <- mf
        a <- ma
        return (f a)

instance Functor (ReaderM env) where
    fmap f m = ReaderM $ \r -> fmap f (runReaderM m r)