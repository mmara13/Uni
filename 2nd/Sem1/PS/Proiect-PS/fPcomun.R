# Functia pentru calculul probabilitatii de tipul P(x=1,y=2)
fPcomun <- function(x_val, y_val, rep_comuna) {
  
  p_cond <- rep_comuna[x_val, y_val]
  
  return(p_cond)
}
# Construiti repartitia comuna si repartitiile marginale
# Specificați dimensiunile matricei dorite 
n <- 5
m <- 6

# Creaza o matrice n x m cu valori aleatoare între 0 și 1
repartitie_comuna <- matrix(runif(n * m), nrow = n, ncol = m)

# Normalizeaza valorile astfel încât suma tuturor valorilor să fie 1
repartitie_comuna <- repartitie_comuna / sum(repartitie_comuna)
repartitie_comuna <- round(repartitie_comuna, 3)

# Calculați sumele pentru fiecare linie și fiecare coloană
rep_marginal_x <- round(rowSums(repartitie_comuna), 3)
rep_marginal_y <- round(colSums(repartitie_comuna), 3)

# Normalizaeaza sumele pentru fiecare linie și fiecare coloană astfel încât ele să fie 1
rep_marginal_x <- round(rep_marginal_x / sum(rep_marginal_x),3)
rep_marginal_y <- round(rep_marginal_y / sum(rep_marginal_y),3)

# round valorile la 3 zecimale
repartitie_comuna[sample(m * n, m * n * 0.3)] 
rep_marginal_x[sample(m, m * 0.3)] 
rep_marginal_y[sample(n, n * 0.3)] 

# Afișați rezultatele rotunjite la 3 zecimale
print("Repartitie comuna (matrice):")
print(repartitie_comuna)

print("Repartitie marginala pe x (sume normalizate):")
print(rep_marginal_x)

print("Repartitie marginala pe y (sume normalizate):")
print(rep_marginal_y)

# Testarea functiei
x_val <- 2  # Valoarea pentru X
y_val <- 2  # Valoarea pentru Y

# Afisarea rezultatului
print("Probabilitatea ceruta este:")
print(fPcomun(x_val, y_val, repartitie_comuna))
