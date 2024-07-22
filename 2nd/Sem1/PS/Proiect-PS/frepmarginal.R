
frepmarginal <- function(repartitie_comuna, rep_marginal_x, rep_marginal_y) {
  # Reconstruiți repartitia marginala pe x
  rep_marginal_x_completat <- rep_marginal_x
  valorile_lipsa_x <- is.na(rep_marginal_x)
  rep_marginal_x_completat[valorile_lipsa_x] <- 1 - sum(rep_marginal_x_completat[!valorile_lipsa_x])
  
  # Reconstruiți repartitia marginala pe y
  rep_marginal_y_completat <- rep_marginal_y
  valorile_lipsa_y <- is.na(rep_marginal_y)
  rep_marginal_y_completat[valorile_lipsa_y] <- 1 - sum(rep_marginal_y_completat[!valorile_lipsa_y])
  
  # Reconstruiți repartitia comuna utilizând repartitiile marginale
  repartitie_comuna_completata <- repartitie_comuna
  repartitie_comuna_completata[valorile_lipsa_x, ] <- rep_marginal_x_completat
  repartitie_comuna_completata[, valorile_lipsa_y] <- rep_marginal_y_completat
  
  return(list(repartitie_comuna = repartitie_comuna_completata, rep_marginal_x = rep_marginal_x_completat, rep_marginal_y = rep_marginal_y_completat))
}

reconstruire_repartitie <- function(rezultat) {
  # Extrageți componentele din rezultat
  repartitie_comuna <- rezultat$repartitie_comuna
  rep_marginal_x <- rezultat$rep_marginal_x
  rep_marginal_y <- rezultat$rep_marginal_y
  
  # Apelați frepmarginal pentru a reconstrui valorile lipsă
  rezultat_reconstruit <- frepmarginal(repartitie_comuna, rep_marginal_x, rep_marginal_y)
  
  return(rezultat_reconstruit)
}

# Utilizați funcția reconstrui_repartitie pentru a obține o reconstrucție a rezultatelor
rezultat_reconstruit <- reconstrui_repartitie(rezultat)

# Afișați rezultatele reconstruite rotunjite la 3 zecimale
print("Repartitie comuna reconstruita (matrice):")
print(rezultat_reconstruit$repartitie_comuna)

print("Repartitie marginala pe x reconstruita :")
print(rezultat_reconstruit$rep_marginal_x)

print("Repartitie marginala pe y reconstruita :")
print(rezultat_reconstruit$rep_marginal_y)

