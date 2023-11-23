# Script para 

library(tidyverse)
library(readxl)

# Catálogos de unidades de salud
clues <- read_csv('data/raw/egresos/Catalogos/Catalogos 2004 - 2014/CATCLUES.csv') %>%
  select(CLUES, CEDOCVE, CMPOCVE, TipoUnidad) %>%
  rename(entidad = CEDOCVE,
         municipio = CMPOCVE,
         tipo_unidad = TipoUnidad) %>%
  mutate(entidad = as.numeric(entidad), 
         municipio = as.numeric(municipio))
clues_ <- read_xlsx('data/raw/egresos/Catalogos/Catalogos_EH_Sectorial_2015-2016/ESTABLECIMIENTO_SALUD_201908.xlsx') %>%
  select(CLUES, "CLAVE DE LA ENTIDAD", "CLAVE DEL MUNICIPIO", 
         "NOMBRE TIPO ESTABLECIMIENTO") %>%
  rename(entidad = "CLAVE DE LA ENTIDAD",
         municipio = "CLAVE DEL MUNICIPIO",
         tipo_unidad = "NOMBRE TIPO ESTABLECIMIENTO") %>%
  mutate(entidad = as.numeric(entidad), 
         municipio = as.numeric(municipio))

# Catálogo CIE_10 de diagnósticos
cie_10 <- read_csv('data/raw/egresos/Catalogos/Catalogos 2004 - 2014/CATCIE10.csv') %>%
  select(letra, CAUSA, Nombre) %>%
  rename(iCausa = CAUSA, causa = Nombre)
cie_10_ <- read_xlsx('data/raw/egresos/Catalogos/Catalogos_EH_Sectorial_2015-2016/DIAGNOSTICOS_2019.xlsx') %>%
  select(LETRA, CATALOG_KEY, NOMBRE) %>%
  rename(letra = LETRA, iCausa = CATALOG_KEY, causa = NOMBRE)

# Función para calcular conteo de egresos por municipio 
# Recibe como argumento la variable anho (entero), e.g. conteo_egresos(2021)
conteo_egresos <- function(anho){
  # anho <- 2016

  ruta <- './data/raw/egresos/csv/'
  if (anho <   2018) {
  nombre   <- 'SECTOR' } else {
  nombre   <- 'Egresos_Sectorial_' }
  if (anho <   2021) {
  ext      <- '.csv' } else {
  ext      <- '.txt' }
  nombre   <-  str_c(ruta, nombre, as.character(anho), ext)
  
  if (anho <   2017) {
  egresos  <-  read_csv(nombre) } else {
  egresos  <-  read_delim(nombre, delim = '|') } 
    
  if (anho <   2015) {
  egresos  <-  egresos %>%
    select(CLUES, SEXO, EDAD, AFECPRIN4) %>%
    rename(sexo = SEXO, edad = EDAD, afectacion = AFECPRIN4) %>% 
    left_join(clues,  by = join_by(CLUES == CLUES)) %>%
    left_join(cie_10, by = join_by(afectacion == iCausa)) } else {
  egresos  <-  egresos %>%
    select(CLUES, SEXO, EDAD1, AFECPRIN4) %>%
    rename(sexo = SEXO, edad = EDAD1, afectacion = AFECPRIN4) %>% 
    left_join(clues_,  by = join_by(CLUES == CLUES)) %>%
    left_join(cie_10_, by = join_by(afectacion == iCausa)) }    

  # Conteo de egresos obstétricos adolescentes por municipio
  conteo <- egresos %>%
    filter(letra == 'O', sexo == 2, edad %in% 14:20) %>% 
    group_by(entidad, municipio) %>%
    summarise(nEgresos = n()) %>%
    mutate(anho = anho)

  ruta_conteo <- './data/interim/egresos/'
  ruta_conteo <- str_c(ruta_conteo, 'conteo', anho, '.csv')
  write_csv(conteo, ruta_conteo)
}

lapply(2008:2021, conteo_egresos)


