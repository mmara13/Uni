# Utilizați rezultatele de la punctul b) : rezultat_completat$repartitie_comuna, rezultat_completat$rep_marginal_x, rezultat_completat$rep_marginal_y

fvernecor <- function(repartitie_comuna, rep_marginal_x, rep_marginal_y){
  # X și Y sunt necorelate dacă covarianța lor este 0
  # Utilizați fpropcov cu a = 1, b = 0, c = 1, d = 0
  covarianta <- fpropcov(1, 0, 1, 0, repartitie_comuna, rep_marginal_x, rep_marginal_y)
  
  if(covarianta == 0){
    print("Variabilele sunt necorelate")
  }
  else{
    print("Variabilele sunt corelate")
  }
}

fvernecor(rezultat_completat$repartitie_comuna, rezultat_completat$rep_marginal_x, rezultat_completat$rep_marginal_y)
