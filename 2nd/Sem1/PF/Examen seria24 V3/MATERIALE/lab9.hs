import Data.List (nub)
import Data.Maybe (fromJust)
import Distribution.Simple.Command (OptDescr(BoolOpt))

type Nume = String
data Prop
 = Var Nume
    | F
    | T
    | Not Prop
    | Prop :|: Prop
    | Prop :&: Prop
    | Prop :->: Prop
    | Prop :<->: Prop
    deriving (Eq, Read)
infixr 2 :|:
infixr 3 :&:
infixr 4 :->:
infixr 5 :<->:

p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

p3 :: Prop
p3 = (Var "P" :&: (Var "Q" :|: Var "R")) :&: ((Not (Var "P") :|: Not (Var "Q")) :&: (Not (Var "P") :|: Not(Var "R")))

instance Show Prop where
    show (Var nume) = nume
    show (Not p) = "(~" ++ show p ++")"
    show (p :|: q) = "(" ++ show p ++ "|" ++ show q ++ ")"
    show (p :&: q) = "(" ++ show p ++ "&" ++ show q ++ ")"
    show (p :->: q) = "(" ++ show p ++ "->" ++ show q ++ ")"
    show (p :<->: q) = "(" ++ show p ++ "<->" ++ show q ++ ")"
 
test_ShowProp :: Bool
test_ShowProp =
    show (Not (Var "P") :&: Var "Q") == "((~P)&Q)"

type Env = [(Nume, Bool)]

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a = fromJust . lookup a

eval :: Prop -> Env -> Bool
eval (Var nume) env = impureLookup nume env
eval (Not p) env = not (eval p env)
eval (p :|: q) env = eval p env || eval q env
eval (p :&: q) env = eval p env && eval q env
eval (p :->: q) env = not (eval p env) || eval q env
eval (p :<->: q) env = eval (p :->: q) env && eval (q :->: p) env
 
test_eval = eval  (Var "P" :|: Var "Q") [("P", True), ("Q", False)] == True

variabile :: Prop -> [Nume]
variabile (Var nume) = [nume]
variabile (Not p) = nub(variabile p)
variabile (p :|: q) = nub (variabile p ++ variabile q) --nub functioneaza ca set in py, nu ia duplicate
variabile (p :&: q) = nub (variabile p ++ variabile q)
variabile _ = []
 
test_variabile =
  variabile (Not (Var "P") :&: Var "Q") == ["P", "Q"]

envs :: [Nume] -> [Env]
envs [] = [[]]
envs (x:xs) = [(x, False):e | e <- envs xs] ++ [(x, True):e | e <- envs xs]
 
test_envs = 
    envs ["P", "Q"]
    ==
    [ [ ("P",False)
      , ("Q",False)
      ]
    , [ ("P",False)
      , ("Q",True)
      ]
    , [ ("P",True)
      , ("Q",False)
      ]
    , [ ("P",True)
      , ("Q",True)
      ]
    ]

satisfiabila :: Prop -> Bool
satisfiabila prop = or [eval prop env | env <- envs (variabile prop)]
 
test_satisfiabila1 = satisfiabila (Not (Var "P") :&: Var "Q") == True
test_satisfiabila2 = satisfiabila (Not (Var "P") :&: Var "P") == False

valida :: Prop -> Bool
valida prop = all (\env -> eval prop env) (envs (variabile prop))

test_valida1 = valida (Not (Var "P") :&: Var "Q") == False
test_valida2 = valida (Not (Var "P") :|: Var "P") == True


echivalenta :: Prop -> Prop -> Bool
echivalenta p1 p2 = all (\env -> eval p1 env == eval p2 env) (envs (nub (variabile p1 ++ variabile p2)))
test_echivalenta1 =
  True
  ==
  (Var "P" :&: Var "Q") `echivalenta` (Not (Not (Var "P") :|: Not (Var "Q")))
test_echivalenta2 =
  False
  ==
  (Var "P") `echivalenta` (Var "Q")
test_echivalenta3 =
  True
  ==
  (Var "R" :|: Not (Var "R")) `echivalenta` (Var "Q" :|: Not (Var "Q"))

impl :: Bool -> Bool -> Bool
impl False _ = True
impl _ x     = x

echiv :: Bool -> Bool -> Bool
echiv x y = x == y


