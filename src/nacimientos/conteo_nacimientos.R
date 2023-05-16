# Script para convertir las bases con el detalle de nacimientos por año de INEGI,
# lee la información de los archivos \data\raw\nacimientos\<Anho>\nacim.dbf,
# hace un conteo de nacimientos por municipio y edad de la madre y lo guarda en
# \data\interim\nacimientos\conteo<Anho>.csv
# Genera un archivo por año con el conteo de 1985 a 2021

library(tidyverse)
library(foreign)

# Función para calcular conteo de nacimientos por municipio por edad de la madre
# al momento del nacimiento, recibe anho como cadena e.g. conteo_m_e(2020)
conteo_m_e <- function(anho){
  # anho <- 2020
  anho <- as.character(anho)
  ruta <- './data/raw/nacimientos/'
  nacim <- str_c(ruta, 'natalidad_base_datos_', anho, '_dbf/nacim', str_sub(anho, 3, 4), '.dbf')
  nacim <- read.dbf(nacim)
  
  nacim %>% 
    group_by(ANO_NAC,
             ENT_RESID,
             MUN_RESID,
             EDAD_MADN) %>%
    summarise(nNacimientos = n()) -> conteo_mun_edad

  ruta_conteo <- './data/interim/nacimientos/'
  ruta_conteo <- str_c(ruta_conteo, 'conteo', anho, '.csv')
  write_csv(conteo_mun_edad, ruta_conteo)
}

lapply(1985:2021, conteo_m_e)
