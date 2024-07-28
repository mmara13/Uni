import System.Win32 (xBUTTON1)
class Functor f where
    fmap :: (a -> b) -> f a -> f b

newtype Identity a = Identity a

instance Prelude.Functor Identity where
    fmap f (Identity x) = Identity (f x)

data Pair a = Pair a a 
instance Prelude.Functor Pair where
    fmap :: (a -> b) -> Pair a -> Pair b
    fmap f (Pair x y)= Pair (f x) (f y)

data Constant a b = Constant b
instance Prelude.Functor (Constant a) where
    fmap f(Constant a) = Constant (f a)

data Two a b = Two a b
instance Prelude.Functor (Two a) where 
    fmap f(Two a b) = Two a (f b)

data Three a b c = Three a b c
instance Prelude.Functor (Three a b) where
    fmap f(Three x y z) = Three x y (f z)

data Three' a b = Three' a b b
instance Prelude.Functor(Three' a) where
    fmap f(Three' x y z) = Three' x (f y) (f z)

data Four a b c d = Four a b c d
instance Prelude.Functor(Four a b c) where
    fmap :: (a2 -> b2) -> Four a1 b1 c a2 -> Four a1 b1 c b2
    fmap f(Four x y z w) = Four x y z (f w)

data Four'' a b = Four'' a a a b
instance Prelude.Functor(Four'' a) where
    fmap f(Four'' x y z w) = Four'' x y z (f w)


data Quant a b = Finance | Desk a | Bloor b
instance Prelude.Functor(Quant a) where
    fmap _ Finance = Finance
    fmap f (Desk x) = Desk x
    fmap f (Bloor y) = Bloor (f y)


data LiftItOut f a = LiftItOut (f a)
instance Prelude.Functor f => Prelude.Functor (LiftItOut f) where
    fmap f (LiftItOut x) = LiftItOut (Prelude.fmap f x)


