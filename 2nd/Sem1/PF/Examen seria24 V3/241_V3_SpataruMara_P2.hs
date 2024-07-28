data Pereche a b = MyP a b deriving Show
newtype Lista a = MyL [a] deriving Show

class MyOp m where
    myZip :: m a -> m b -> m (Pereche a b)

instance MyOp Lista where
    --myZip xl yl = MyL [MyP x y | x <- xl , y <- yl]
    myZip xl yl = do
        x <- xl
        y <- yl
        return MyL [MyP $ x y]

