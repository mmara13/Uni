
fpropcov <- function(a, b, c, d, repartitie_comuna, rep_marginal_x, rep_marginal_y) {
  # Calculați E[X], E[Y], E[X^2], E[Y^2]
  medie_x <- sum(rep_marginal_x * seq_along(rep_marginal_x))
  medie_y <- sum(rep_marginal_y * seq_along(rep_marginal_y))
  medie_xx <- sum(rep_marginal_x * seq_along(rep_marginal_x)^2)
  medie_yy <- sum(rep_marginal_y * seq_along(rep_marginal_y)^2)
  
  # Calculați varianțele pentru X și Y
  # Var(X) = E[X^2] - E[X]^2
  var_x <- medie_xx - medie_x^2
  # Var(Y) = E[Y^2] - E[Y]^2
  var_y <- medie_yy - medie_y^2
  
  # Calculați E[X*Y]
  medie_xy <- sum(repartitie_comuna * (seq_along(rep_marginal_x) %*% t(seq_along(rep_marginal_y))))
  
  # Calculează covarianța utilizând formula cov(X,Y) = E[X*Y] - E[X]*E[Y]
  cov_xy <- round(medie_xy - medie_x * medie_y,3)
  
  # Covarianța pentru Z și T
  # cov(Z,T) = cov(a*X+b*Y,c*X+d*Y) = a*c*Var(X) + b*c*cov(X,Y) + b*d*Var(Y)
  cov_zt <- round(a * c * var_x + b * c * cov_xy + b * d * var_y,3)
  
  return(cov_zt)
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

print("Repartitie marginala pe x:")
print(rep_marginal_x)

print("Repartitie marginala pe y:")
print(rep_marginal_y)

# Exemplu de utilizare pentru fpropcov
a <- 2
b <- 3
c <- 2
d <- 4
print("Covarianța pentru Z și T:")
print(fpropcov(a, b, c, d, repartitie_comuna, rep_marginal_x, rep_marginal_y))
