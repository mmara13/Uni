import System.Posix.Internals (rtsIsThreaded_)
import System.Win32 (xBUTTON1)
class Collection c where
  empty :: c key value
  singleton :: key -> value -> c key value
  insert
      :: Ord key
      => key -> value -> c key value -> c key value
  clookup :: Ord key => key -> c key value -> Maybe value
  delete :: Ord key => key -> c key value -> c key value
  keys :: c key value -> [key]
  values :: c key value -> [value]
  toList :: c key value -> [(key, value)]
  fromList :: Ord key => [(key,value)] -> c key value
  
  keys c = [fst p | p <- toList c]
  values c = [snd p | p <- toList c]
  fromList [] = empty
  fromList ((k,v):xs) = insert k v (fromList xs)



newtype PairList k v
  = PairList { getPairList :: [(k, v)] }

instance Collection PairList where  
    empty = PairList [] 
    singleton k v = PairList [(k,v)]
    insert k v (PairList l) = PairList $ (k,v) : filter ((/=k).fst) l
    delete k (PairList l) = PairList $ filter ((/=k).fst) l
    clookup k = lookup k.getPairList
 

data SearchTree key value
  = Empty
  | BNode
      (SearchTree key value) -- elemente cu cheia mai mica
      key                    -- cheia elementului
      (Maybe value)          -- valoarea elementului
      (SearchTree key value) -- elemente cu cheia mai mare
instance Collection SearchTree where
    empty = Empty
    singleton k v = BNode Empty k (Just v) Empty
    insert k v = go
        where   
            go Empty = singleton k v
            go (BNode lt k1 v1 rt)
                | k == k1 = BNode lt k1 (Just v) rt
                | k < k1 = BNode (go lt) k1 v1 rt
                | otherwise = BNode lt k1 v1 (go rt)
    toList Empty = []
    toList (BNode lt k v rt)
        = toList lt ++ go k v ++ toList rt
            where 
                go k (Just v) = [(k,v)]
                go _ _ = []


data Punct = Pt [Int]

data Arb = Vid | F Int | N Arb Arb
          deriving Show

class ToFromArb a where
 toArb :: a -> Arb
 fromArb :: Arb -> a
-- Pt [1,2,3]
-- (1, 2, 3)

instance Show Punct where
    show(Pt[]) = "()"
    show (Pt l) = "(" ++ f l ++ ")"
        where 
            f [] = "" 
            f [x] = show x
            f(x:y:xs) = show x ++ ", " ++  f(y:xs)

-- Pt []
-- ()

-- toArb (Pt [1,2,3])
-- N (F 1) (N (F 2) (N (F 3) Vid))
-- fromArb $ N (F 1) (N (F 2) (N (F 3) Vid)) :: Punct
--  (1,2,3)

instance ToFromArb Punct where
    toArb (Pt[]) = Vid
    toArb (Pt (x:xs)) = N(F x)(toArb (Pt xs))

    fromArb Vid = Pt []
    fromArb (F x) = Pt [x]
    fromArb (N l r) = Pt(p1 ++ p2)
        where 
            Pt p1 = fromArb l
            Pt p2 = fromArb r



data Geo a = Square a | Rectangle a a | Circle a
    deriving Show

class GeoOps g where
  perimeter :: (Floating a) => g a -> a
  area :: (Floating a) =>  g a -> a


instance GeoOps Geo where
    perimeter (Square a) = 4 * a
    perimeter (Rectangle a b) = 2 * (a + b)
    perimeter (Circle r) = 2 * pi * r

    area (Square a) = a * a
    area (Rectangle a b) = a * b
    area (Circle r) = pi * r * r
    
instance (Eq a, Floating a) => Eq (Geo a) where
    fig1 == fig2 = perimeter(fig1)==perimeter(fig2)
    fig1 /= fig2 = perimeter(fig1) /= perimeter(fig2)
    


-- ghci> pi
-- 3.141592653589793
