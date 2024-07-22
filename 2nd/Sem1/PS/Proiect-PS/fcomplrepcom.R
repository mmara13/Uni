
fcomplrepcom <- function(rezultat) {
  # Extrageți componentele din rezultat
  repartitie_comuna <- rezultat$repartitie_comuna
  rep_marginal_x <- rezultat$rep_marginal_x
  rep_marginal_y <- rezultat$rep_marginal_y
  
  # Apelați frepmarginal pentru a reconstrui valorile lipsă
  #rezultat_reconstruit <- frepmarginal(repartitie_comuna, rep_marginal_x, rep_marginal_y)
  
  # Completează valorile lipsă în repartitia comuna
  valorile_lipsa <- is.na(rezultat_reconstruit$repartitie_comuna)
  rezultat_reconstruit$repartitie_comuna[valorile_lipsa] <- 1 - sum(rezultat_reconstruit$repartitie_comuna[!valorile_lipsa])
  
  return(rezultat_reconstruit)
}
# Utilizați funcția fcomplrepcom pentru a completa valorile lipsă
rezultat_completat <- fcomplrepcom(rezultat_reconstruit)

# Afișați rezultatele completate rotunjite la 3 zecimale
print("Repartitie comuna completata (matrice):")
print(rezultat_completat$repartitie_comuna)

print("Repartitie marginala pe x completata :")
print(rezultat_completat$rep_marginal_x)

print("Repartitie marginala pe y completata :")
print(rezultat_completat$rep_marginal_y)
