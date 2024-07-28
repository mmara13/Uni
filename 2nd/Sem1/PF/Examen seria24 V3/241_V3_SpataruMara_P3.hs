newtype BM a = BM {getBM :: (String, Maybe a)} deriving Show

instance Monad BM where
    return x = BM("", Just x)
    ma >>= k = let (s1,a1) = getBM ma
                in case a1 of
                    Nothing -> BM (s1, Nothing)
                    Just val -> let (s2,a2) = getBM $ k val
                                in BM (s1 ++ s2, a2)

instance Functor BM where
    fmap f ma = f <$> ma

instance Applicative BM where
    pure = return
    mf <*> ma = do
        f <- mf
        f <$> ma

testBM :: BM Int
testBM = ma >>= f 
    where
        ma = BM ("ana are mere ", Just 7)
        f x = BM ("si pere!", if even x then Just x else Nothing)
--BM {getBM = ("ana are mere si pere!", Nothing)}