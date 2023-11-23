# library(tidyverse)

# Cargar información del censo con número de mujeres por año por municipio por edad
poblacion <- read_csv('./data/interim/poblacion/Poblacion_con_tefa.csv')
  
leer <- function(anho) {
  ruta <- './data/interim/egresos/conteo'
  ruta <- str_c(ruta, as.character(anho), '.csv')
  read_csv(ruta)
}

egresos <- bind_rows(lapply(2008:2021, leer)) %>%
  rename(Muni = municipio, Estado = entidad, Anho = anho)

# Juntamos ambas tablas
poblacion <- poblacion %>%
  left_join(egresos,
            by = c('Anho', 'Estado', 'Muni')) %>%
  mutate(t_obstetrica = nEgresos / nMujeres)

# Exportar tasas de fecundidad adolescente de 1986 a 2020 por municipio
ruta <- './data/interim/poblacion/'
ruta <- str_c(ruta, 'Poblacion_con_tefa_y_obstetrica.csv')
write_csv(poblacion, ruta)

