#library(tidyverse)
library("readxl")
library("janitor")

ruta <- './data/raw/nacimientos/tabulados_inegi/'
archivo <- 'Hidalgo.xls'

# Función que lee el Tabulador de nacimientos de INEGI por grupo quinquenal
# de edad de la madre
tabulado <- function(ruta, archivo){
  filename <- paste(ruta, archivo, sep = '')
  datirri  <- read_xlsx(filename, col_names = FALSE) %>% 
    slice_tail(n = -4) %>% 
    slice_head(n = -4)
  datirri[1,1] <- 'Clave'
  datirri[1,2] <- 'Nombre'
  datirri[1,3] <- 'Anho'
  datirri      <- datirri %>% row_to_names(row_number = 1)
}

hgo <- tabulado(ruta, archivo)
glimpse(hgo)
hgo %>% 
  filter(Nombre == "Atitalaquia",
         Anho > 1985) -> foo

nacimientos <- read_csv(('./data/interim/nacimientos/Nacimientos.csv')) %>%
  filter(Territorio == "Atitalaquia")
# filter(Territorio == "Atitalaquia",
  #        Edad %in% 15:19) %>%

# Conteo por grupo quinquenal
conteo_mun_edad <- nacimientos %>%
  mutate(
    grupo_quinq = floor(Edad / 5) + 1
  ) %>%
  filter(Estado == 13,
         Muni == 10) %>%
  group_by(Anho, Estado, Muni, Territorio, grupo_quinq) %>%
  summarise(nNacimientos = sum(nNacimientos))

