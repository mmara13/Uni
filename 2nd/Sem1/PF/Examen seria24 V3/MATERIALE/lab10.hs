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
    deriving (Eq)
infixr 2 :|:
infixr 3 :&:
infixr 4 :->:
infixr 5 :<->:

p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not(Var "P") :&: Not(Var "Q"))

p3 :: Prop
p3 = (Var "P" :&: (Var "Q" :|: Var "R")) :&: ((Not(Var "P")) :|: Not(Var "Q")) :&: (Not(Var "P") :|: Not (Var"R"))

--Exercitiul 2
instance Show Prop where
    show (Var nume) = nume
    show (Not p) = "(~"++ show p ++ ")"
    show (p :|: q) = "("++ show p ++ "|" ++ show q ++ ")"
    show (p :&: q) = "("++ show p ++ "&" ++ show q ++ ")"
    show (p :->: q) = "(" ++ show p ++ "->" ++ show q ++ ")"
    show (p :<->: q) = "(" ++ show p ++ "<->" ++ show q ++ ")"

test_ShowProp :: Bool
test_ShowProp = show (Not (Var "P") :&: Var "Q") == "((~P)&Q)"

--evaluarea expresiilor logice
--exercitiul 3

type Env = [(Nume, Bool)]

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a = fromJust . lookup a

eval :: Prop -> Env -> Bool
eval (Var nume) env = impureLookup nume env
eval (Not p) env = not (eval p env)
eval (p :|: q) env = eval p env || eval q env
eval (p :&: q) env = eval p env && eval q env
eval (p :->: q) env = not(eval p env) || eval q env
eval (p :<->: q) env = eval(p :->: q) env && eval (q :->: p) env

test_eval = eval (Var"P" :|: Var "Q") [("P",True),("Q",False)] == True

--definiti o functie variabile care colecteaza lista tuturor variabilelor dintr o formula
--Hint: folositi functia nub (elimina duplicatele dintr o lista)
variabile :: Prop -> [Nume]
variabile (Var nume) = [nume]
variabile (Not p) = Data.List.nub(variabile p)
variabile (p :|: q) = Data.List.nub(variabile p ++ variabile q)
variabile (p :&: q) = Data.List.nub(variabile p ++ variabile q)
variabile (p :->: q) = nub(variabile p ++ variabile q)
variabile (p :<->: q) = nub(variabile p ++ variabile q)
variabile _ = []

test_variabile = variabile (Not(Var "P") :&: Var "Q") == ["P","Q"]

--exercitiul 5
envs :: [Nume] -> [Env]
envs [] =[[]]
envs (x:xs) = [(x,False):e | e<-envs xs] ++ [(x, True):e | e<-envs xs]

test_envs = envs ["P","Q"] == [[("P",False),("Q",False)],[("P",False),("Q",True)],[("P",True),("Q",False)],[("P",True),("Q",True)]]

--exercitiul 6
satisfiabila :: Prop -> Bool
satisfiabila prop = or [eval prop env | env <- envs (variabile prop)]

test_satisfiabila1 = satisfiabila (Not(Var "P") :&: Not(Var "Q")) == True
test_satisfiabila2 = satisfiabila (Not(Var "P") :&: Var "P") == False

--exercitiul 7
valida :: Prop -> Bool
valida prop = all (\env -> eval prop env) (envs (variabile prop))

test_valida1 = valida (Not(Var"P") :&: Var "Q") == False
test_valida2 = valida (Not(Var "P") :|: Var "P") == True

--implicatie si echivalenta
--exercitiul 9 extindem tipul de date Prop sus
--exercitiul 10 echivalenta
echivalenta :: Prop -> Prop -> Bool
echivalenta p1 p2 = all (\env -> eval p1 env == eval p2 env) (envs (nub (variabile p1 ++ variabile p2)))

test_echivalenta1 = True == (Var "P" :&: Var "Q") `echivalenta` (Not (Not (Var "P") :|: Not (Var "Q")))
test_echivalenta2 = False == (Var "P") `echivalenta` (Var "Q")
test_echivalenta3 = True == (Var "R" :|: Not (Var "R")) `echivalenta` (Var "Q" :|: Not (Var "Q"))