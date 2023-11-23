# library(tidyverse)
# library(rdrobust)
# library(kableExtra)
# library(LalRUtils)

eleccion <- read_csv('data/interim/margen/eleccionMargenTasa.csv') %>%
  mutate(log_pop = log(nMujeres))

source('src/regresiones/plantillas.R')
salida <- modelo_reg() # Resultados para tasa de fecundidad adolescente
salida_obs <- modelo_reg() # Resultados para tasa de atención obstétrica
source('src/regresiones/rdplots.R')
source('src/regresiones/rdplots_con_pesos.R')
source('src/regresiones/rdplots_con_ctrl.R')
source('src/regresiones/rdplots_c_y_p.R')
salida <- salida %>%
  mutate('Años tras la elección' = as.numeric(str_sub(Y, -2, -1))) %>% 
  relocate('Años tras la elección') %>%
  relocate(any_of(c('Y', 'Etiqueta', 'Título')), .after = last_col()) %>%
  relocate('Bandwidth', .after = 'Pesos')
salida_obs <- salida_obs %>%
  mutate('Años tras la elección' = as.numeric(str_sub(Y, -2, -1))) %>% 
  relocate('Años tras la elección') %>%
  relocate(any_of(c('Y', 'Etiqueta', 'Título')), .after = last_col()) %>%
  relocate('Bandwidth', .after = 'Pesos')

tabla <- salida %>% select(1:8)
tabla_obs <- salida_obs %>% select(1:8)

save(salida, salida_obs, file = 'data/interim/regresiones/resultados_regresiones.Rda')
save(tabla, tabla_obs, file = 'data/interim/regresiones/resumen_regresiones.Rda')
