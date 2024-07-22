# Utilizați rezultatele de la punctul b) : rezultat_completat$repartitie_comuna, rezultat_completat$rep_marginal_x, rezultat_completat$rep_marginal_y

fverind <- function(repartitie_comuna, rep_marginal_x, rep_marginal_y){
  # X și Y sunt independente dacă și numai dacă xi * yj = rij
  sunt_independente <- 1
  for (i in 1:nrow(repartitie_comuna)) {
    for (j in 1:ncol(repartitie_comuna)) {
      # Verifică condițiile
      if (repartitie_comuna[i][j] != rep_marginal_x[i] * rep_marginal_y[j]){
        sunt_independente <- 0
        break
      }
    }
  }
  if( sunt_independente > 0){
    print("Variabilele sunt independente")
  }
  else {
    print("Variabilele nu sunt independente")
  }
}

fverind(rezultat_completat$repartitie_comuna, rezultat_completat$rep_marginal_x, rezultat_completat$rep_marginal_y)
