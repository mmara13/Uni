
data Expr = Const Int -- integer constant
          | Expr :+: Expr -- addition
          | Expr :*: Expr -- multiplication
           deriving Eq

data Operation = Add | Mult deriving (Eq, Show)

data Tree = Lf Int -- leaf
          | Node Operation Tree Tree -- branch
           deriving (Eq, Show)
           
instance Show Expr where
  show (Const x) = show x
  show (e1 :+: e2) = "(" ++ show e1 ++ " + "++ show e2 ++ ")"
  show (e1 :*: e2) = "(" ++ show e1 ++ " * "++ show e2 ++ ")"           

evalExp :: Expr -> Int
evalExp (Const x) = x
evalExp (e1 :+: e2) = evalExp e1 + evalExp e2
evalExp (e1 :*: e2) = evalExp e1 * evalExp e2

exp1 = ((Const 2 :*: Const 3) :+: (Const 0 :*: Const 5))
exp2 = (Const 2 :*: (Const 3 :+: Const 4))
exp3 = (Const 4 :+: (Const 3 :*: Const 3))
exp4 = (((Const 1 :*: Const 2) :*: (Const 3 :+: Const 1)) :*: Const 2)
test11 = evalExp exp1 == 6
test12 = evalExp exp2 == 14
test13 = evalExp exp3 == 13
test14 = evalExp exp4 == 16

evalArb :: Tree -> Int
evalArb (Lf x) = x
evalArb (Node Add l r) = evalArb l + evalArb r
evalArb (Node Mult l r) = evalArb l * evalArb r


arb1 = Node Add (Node Mult (Lf 2) (Lf 3)) (Node Mult (Lf 0)(Lf 5))
arb2 = Node Mult (Lf 2) (Node Add (Lf 3)(Lf 4))
arb3 = Node Add (Lf 4) (Node Mult (Lf 3)(Lf 3))
arb4 = Node Mult (Node Mult (Node Mult (Lf 1) (Lf 2)) (Node Add (Lf 3)(Lf 1))) (Lf 2)

test21 = evalArb arb1 == 6
test22 = evalArb arb2 == 14
test23 = evalArb arb3 == 13
test24 = evalArb arb4 == 16


expToArb :: Expr -> Tree
expToArb (Const x) = Lf x
expToArb (e1 :+: e2) = Node Add (expToArb e1) (expToArb e2)
expToArb (e1 :*: e2) = Node Mult (expToArb e1) (expToArb e2)


data IntSearchTree value
  = Empty
  | BNode
      (IntSearchTree value)     -- elemente cu cheia mai mica
      Int                       -- cheia elementului
      (Maybe value)             -- valoarea elementului
      (IntSearchTree value)     -- elemente cu cheia mai mare
  
lookup' :: Int -> IntSearchTree value -> Maybe value
lookup' _ Empty = Nothing
lookup' k (BNode l x v r)
    | k == x = v
    | k < x = lookup' k l
    | otherwise = lookup' k r

keys ::  IntSearchTree value -> [Int]
keys Empty = []
keys (BNode l k _ r) = keys l ++ [k] ++ keys r

values :: IntSearchTree value -> [value]
values Empty = []
values (BNode l _ (Just v) r) = values l ++ [v] ++ values r
values (BNode l _ Nothing r) = values l ++ values r

insert :: Int -> value -> IntSearchTree value -> IntSearchTree value
insert k v Empty = BNode Empty k (Just v) Empty
insert k v (BNode l x y r)
    | k == x = BNode l x (Just v) r
    | k < x  = BNode (insert k v l) x y r
    | k > x  = BNode l x y (insert k v r)

delete :: Int -> IntSearchTree value -> IntSearchTree value
delete _ Empty = Empty
delete k (BNode l x _ r)
    | k == x = BNode l x Nothing r
    | k < x  = BNode (delete k l) x Nothing r
    | k > x  = BNode l x Nothing (delete k r)

findMax :: IntSearchTree value -> (Int, Maybe value)
findMax (BNode _ k (Just v) Empty) = (k, Just v)
findMax (BNode _ _ _ r) = findMax r
findMax _ = error "Empty tree"

toList :: IntSearchTree value -> [(Int, value)]
toList = undefined

fromList :: [(Int,value)] -> IntSearchTree value 
fromList = undefined

printTree :: IntSearchTree value -> String
printTree = undefined

testtree :: Int -> Maybe value -> IntSearchTree value -> IntSearchTree value
testtree k v t = BNode 
    (BNode Empty 2 (Just "Two") Empty) 
    5
    (Just "Five")
    (BNode Empty 8 (Just "Eight") Empty)

-- balance :: IntSearchTree value -> IntSearchTree value
-- balance = undefined