# Utilizați rezultatele de la punctul b) : rezultat_completat$repartitie_comuna, rezultat_completat$rep_marginal_x, rezultat_completat$rep_marginal_y

# Cov(5X+9,-3Y-2)
# Folosiți funcția fpropcov
print(paste("Cov(5X+9,-3Y-2) = ", fpropcov(5, 9, -3, -2, rezultat_completat$repartitie_comuna, rezultat_completat$rep_marginal_x, rezultat_completat$rep_marginal_y)))

# P(0<X<0.8|Y>0.3) 
p1<-0;

for (i in 1:nrow(rezultat_completat$repartitie_comuna)) {
  for (j in 1:ncol(rezultat_completat$repartitie_comuna)) {
    # Verifică condițiile
    if (i>0 && i< 0.8 && j > 0.3) {
      # Calculează probabilitatea condiționată și o adaugă la probabilitatea totală
      p2<- p2 + rezultat_completat$repartitie_comuna[i, j]
    }
  }
}
print(paste("P(0<X<0.8|Y>0.3)= ", round(p1, 3)))

# P(X>0.2,Y<1.7) 
p2 <- 0

for (i in 1:nrow(rezultat_completat$repartitie_comuna)) {
  for (j in 1:ncol(rezultat_completat$repartitie_comuna)) {
    # Verificați condiția
    if (i > 0.2 & 1.7 < j) {
      # Adăugați la suma
      p2 <- p2 + rezultat_completat$repartitie_comuna[i, j]
    }
  }
}
print(paste("P(X > 0.2, Y < 1.7) =", round(p2, 3)))
