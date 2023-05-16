# library(tidyverse)
# library(foreign)
# anho <- 2020

depurar_nacimientos <- function(anho){
  # Rutina para depurar csv intermedio con conteo de nacimientos
  # foo <- depurar_nacimientos(2021)
  
  # Base de nacimientos
  ruta <- './data/interim/nacimientos/conteo'
  nacimientos <- str_c(ruta, as.character(anho), '.csv')
  nacimientos <- read_csv(nacimientos) %>%
    mutate(ENT_RESID = as.numeric(ENT_RESID),
           MUN_RESID = as.numeric(MUN_RESID),
           ANO_NAC   = as.numeric(ANO_NAC))
  
  # Catálogo de municipios
  ruta_cat <- './data/raw/nacimientos/natalidad_base_datos_'
  if (anho < 2013){
    nombre <- 'ENTMUN'
  } else if (anho == 2014) {
    nombre <- str_c('CATEMLN', str_sub(anho, 3, 4))
  } else {
    nombre <- str_c('CATEMLNA', str_sub(anho, 3, 4))
  }
  catalogo <- str_c(ruta_cat, as.character(anho), '_dbf/', nombre, '.dbf')
  catalogo <- read.dbf(catalogo, as.is = TRUE) %>%
    mutate(
      ENT_RESID = as.numeric(CVE_ENT),
      MUN_RESID = as.numeric(CVE_MUN)
    ) %>%
    select(-CVE_ENT, -CVE_MUN) %>%
    filter(MUN_RESID > 0)
  # A partir del 2013 el catálogo cambia para agregar localidad, por lo que es
  # necesario agregar filtros adicionales
  if (anho %in% 2013:2021){
    catalogo <- catalogo %>% 
      rename(NOMBRE = NOM_LOC) %>%
      mutate(CVE_LOC = as.numeric(CVE_LOC)) %>%
      filter(CVE_LOC == 0) %>% # Filtramos cabeceras municipales
      select(-CVE_LOC) %>%
      relocate(-NOMBRE)
  }
  
  # Se unen las tablas de nacimientos con el catálogo (para obtener el nombre
  # del municipio) y se filtra la tabla final para quedarse con nacimientos
  # de madres de entre 14 y 20 años.
  nacimientos <- nacimientos %>%
    left_join(catalogo, by = c('ENT_RESID', 'MUN_RESID')) %>%
    filter(EDAD_MADN %in% 14:20) %>%
    mutate(Anho = anho) %>%
    relocate(Anho, ENT_RESID, MUN_RESID, NOMBRE)

}

n <- bind_rows(lapply(1985:2021, depurar_nacimientos))
iRegistros1900 <- n$ANO_NAC < 100
n$ANO_NAC[iRegistros1900] = n$ANO_NAC[iRegistros1900] + 1900

nacimientos <- n %>%
  group_by(ENT_RESID,
           MUN_RESID,
           NOMBRE, 
           ANO_NAC,
           EDAD_MADN) %>%
  summarise(nNacimientos = sum(nNacimientos)) %>%
  relocate(ANO_NAC) %>%
  rename(Estado = ENT_RESID,
         Muni = MUN_RESID,
         Territorio = NOMBRE,
         Edad = EDAD_MADN,
         Anho = ANO_NAC) %>%
  filter(Anho > 1985)

# Exportar conteo de nacimientos de madres de 14 a 20 años de 1985 a 2021 por municipio
ruta <- './data/interim/nacimientos/'
ruta <- str_c(ruta, 'Nacimientos.csv')
write_csv(nacimientos, ruta)


