#library(tidyverse)

conteo_muyeres <- function(anho){
  # Leemos las primeras líneas del archivo para construir un título para las 
  # variables de una tabla
  ruta <- './data/interim/poblacion/'
  archivo_censo <- str_c(ruta, 'Poblacion', as.character(anho), '.csv')
  poblacion <- read_csv(archivo_censo, skip = 8, n_max = 5) %>% drop_na('...3')
  titulo    <- paste(poblacion[1,], poblacion[2,])
  titulo[1] <- 'Codigo'
  titulo[2] <- 'Territorio'
  # Construimos la tabla con número de personas por municipio
  poblacion <- read_csv('data/interim/poblacion/Poblacion2000.csv',
                        skip = 8) %>% 
               drop_na('...2') # filtramos renglones sin datos
  colnames(poblacion) <- titulo # y nombramos las variables
  # Identificador para el total de la República Mexicana
  poblacion$Codigo[poblacion$`Territorio` == 'Total'] <- 0
  # Convertimos la tabla a formato largo, creamos variables para el 
  # género, la edad, el anho, id estado, id municipio,
  # filtramos datos de mujeres entre 10 y 24 años
  poblacion <- poblacion %>%
    pivot_longer(
      -c('Codigo', 'Territorio'),
      names_to  = "Genero-Edad", 
      values_to = "nPersonas"
    ) %>%
    mutate (
      Anho   = anho,
      Genero = str_extract(`Genero-Edad`, '[a-zA-Z]+'),
      Estado = as.integer(str_trim(str_extract(Codigo, '^[0-9]+'))),
      Muni   = as.integer(str_trim(str_extract(Codigo, ' (.*)'))),
      Edad   = str_trim(str_extract(`Genero-Edad`, ' (.*)'))
    ) %>%
    select(-'Genero-Edad', -'Codigo') %>%
    filter(
      str_starts(Genero, 'Mujer'),
      str_detect(Edad, '^[0-9]{2} [a,A]ños$')
    ) %>%
    replace_na(list(Muni = 0)) %>%
    relocate(-Territorio, -Edad) %>%
    relocate(-nPersonas) %>%
    mutate(
      nPersonas = as.integer(str_remove_all(nPersonas, ',')),
      Edad = as.integer(str_extract(Edad, '^[0-9]+'))
    )
}

poblacion <- rbind(
  conteo_muyeres(1990), 
  conteo_muyeres(1995),
  conteo_muyeres(2000), 
  conteo_muyeres(2005),
  conteo_muyeres(2010), 
  conteo_muyeres(2020)
)

poblacion %>% glimpse()

# Para los años inter-censos recorremos los años y las edades, por ejemplo,
# si en 1990 había x mujeres de 15 años, suponemos que en 1991 había x mujeres
# de 16 años y en 1992 x mujeres de 17 años. Primero hacemos una función que
# recorre los montos.
recorrer_edad_a_partir_de <- function(a, delta){
  poblacion %>%
    filter(Anho == a) %>%
    mutate(Edad = Edad + delta,
           Anho = Anho + delta) %>%
    filter(Edad %in% 14:20)
  # NOTA: Esta función se podría sofisticar al considerar una interpolación
  # lineal entre los datos de edades e y e+5 (suponiendo censo cada 5 años)
  # entre personas con edad x y personas con edad x+5 tras cinco años para 
  # considerar efectos de migración/decrementos de la población
}

# Agregamos registros de 1986 a 2019
poblacion <- rbind(
  poblacion,
  recorrer_edad_a_partir_de(1990,-4), # 1986
  recorrer_edad_a_partir_de(1990,-3), # 1987
  recorrer_edad_a_partir_de(1990,-2), # 1988
  recorrer_edad_a_partir_de(1990,-1), # 1989
  recorrer_edad_a_partir_de(1990, 1), # 1991
  recorrer_edad_a_partir_de(1990, 2), # 1992
  recorrer_edad_a_partir_de(1995,-2), # 1993
  recorrer_edad_a_partir_de(1995,-1), # 1994
  recorrer_edad_a_partir_de(1995, 1), # 1996
  recorrer_edad_a_partir_de(1995, 2), # 1997
  recorrer_edad_a_partir_de(2000,-2), # 1998
  recorrer_edad_a_partir_de(2000,-1), # 1999
  recorrer_edad_a_partir_de(2000, 1), # 2001
  recorrer_edad_a_partir_de(2000, 2), # 2002
  recorrer_edad_a_partir_de(2005,-2), # 2003
  recorrer_edad_a_partir_de(2005,-1), # 2004
  recorrer_edad_a_partir_de(2005, 1), # 2006
  recorrer_edad_a_partir_de(2005, 2), # 2007
  recorrer_edad_a_partir_de(2010,-2), # 2008
  recorrer_edad_a_partir_de(2010,-1), # 2009
  recorrer_edad_a_partir_de(2010, 1), # 2011
  recorrer_edad_a_partir_de(2010, 2), # 2012
  recorrer_edad_a_partir_de(2010, 3), # 2013
  recorrer_edad_a_partir_de(2010, 4), # 2014
  recorrer_edad_a_partir_de(2020,-5), # 2015
  recorrer_edad_a_partir_de(2020,-4), # 2016
  recorrer_edad_a_partir_de(2020,-3), # 2017
  recorrer_edad_a_partir_de(2020,-2), # 2018
  recorrer_edad_a_partir_de(2020,-1)  # 2019
)

# Se filtra población (adolescente) de 14 a 20 años
poblacion <- poblacion %>%
  filter(Edad %in% 14:20)

# Exportar población femenina de 14 a 20 años de 1986 a 2020 por municipio
ruta <- './data/interim/poblacion/'
ruta <- str_c(ruta, 'Poblacion.csv')
write_csv(poblacion, ruta)



