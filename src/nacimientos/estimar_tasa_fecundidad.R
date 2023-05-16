# library(tidyverse)

# Cargar información del censo con número de mujeres por año por municipio por edad
poblacion <- read_csv('./data/interim/poblacion/Poblacion.csv') %>%
  rename(nMujeres = nPersonas) %>%
  select(-Genero)

# Cargar número de nacimientos por año por municipio por edad de la madre
nacimientos <- read_csv(('./data/interim/nacimientos/Nacimientos.csv'))

# Juntamos ambas tablas
tasas <- poblacion %>%
  filter(Muni > 0) %>%
  left_join(nacimientos,
            by = c('Anho', 'Estado', 'Muni', 'Edad')) %>%
  replace_na(list(nNacimientos = 0)) %>%
  group_by(Anho, Estado, Muni) %>%
  summarise(nMujeres = sum(nMujeres), 
            nNacimientos = sum(nNacimientos),
            nObservaciones = n()) %>%
  mutate(tefa = nNacimientos / nMujeres) %>%
  left_join(poblacion %>%
              select(Estado, Muni, Territorio) %>%
              distinct(),
            by = c('Estado', 'Muni')) %>%
  left_join(nacimientos %>% 
              select(Estado, Muni) %>%
              distinct(),
            by = c('Estado', 'Muni'))

# Exportar tasas de fecundidad adolescente de 1986 a 2020 por municipio
ruta <- './data/interim/poblacion/'
ruta <- str_c(ruta, 'Poblacion_con_tefa.csv')
write_csv(tasas, ruta)

