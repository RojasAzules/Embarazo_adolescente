library(tidyverse)
library(ggplot2)

eleccion <- read_csv('data/raw/RMEVR/aymu1970-on.csv')
problems()

#####

# Agregamos variables para proporción de votos obtenidos
eleccion %>%
  mutate(
    p01 = v01 / tot,
    p02 = v02 / tot,
    p03 = v03 / tot,
    p04 = v04 / tot,
    p05 = v05 / tot,
    p06 = v06 / tot,
    p07 = v07 / tot,
    p08 = v08 / tot,
    p09 = v09 / tot,
    p10 = v10 / tot,
    p11 = v11 / tot,
    p12 = v12 / tot,
    p13 = v13 / tot,
    p14 = v14 / tot,
    p15 = v15 / tot,
    p16 = v16 / tot,
    p17 = v17 / tot,
    p18 = v18 / tot,
    p19 = v19 / tot,
    p20 = v20 / tot,
    p21 = v21 / tot,
    p22 = v22 / tot,
    p23 = v23 / tot,
    p24 = v24 / tot,
    p25 = v25 / tot,
  ) -> eleccion

# Convertimos columnas en renglones para los partidos y 
# las proporciones de votos obtenidos
eleccion <- inner_join(
  eleccion %>%
    filter(status == 'ok') %>%
    select(emm, yr, edon, inegi, mun, date, tot,
           starts_with('l'), -lisnom) %>%
    pivot_longer(-c('emm', 'yr', 'edon', 'inegi', 'mun', 'date', 'tot'), 
                 names_to = "opcion", 
                 values_to = "partidos") %>%
    mutate(opcion = str_sub(opcion, 2)),
  eleccion %>%
    filter(status == 'ok') %>%
    select(emm, yr, edon, inegi, mun, date, tot,
           starts_with('p'), -lisnom) %>%
    pivot_longer(-c('emm', 'yr', 'edon', 'inegi', 'mun', 'date', 'tot'), 
                 names_to = "opcion", 
                 values_to = "proporcion") %>%
    mutate(opcion = str_sub(opcion, 2)),
  by = c('emm', 'yr', 'edon', 'inegi', 'mun', 'date', 'tot', 'opcion')
) %>%
  filter(!is.na(partidos)) %>%
  mutate(
    votos = tot * proporcion
  )

#####

calcular_margen <- function(x){
  # Calcular margen de victoria/derrota
  emm_ = x[1] # ID eleccion
  opcion_ = x[8] # ID opción
  # Registros de la elección relacionada
  ejercicio <- eleccion %>% filter(emm == emm_)
  # Ganador del ejercicio
  ganador <- ejercicio %>% top_n(1, proporcion)
  # Cálculo del margen de victoria/derrota
  margen <- NA # Inicializamos
  if (ejercicio %>% nrow() > 1) { # Si hubo más de un contendiente
    if (opcion_ == ganador$opcion){ # Si fue el ganador
      # Margen es la diferencia vs el 2do lugar
      margen <- ganador$proporcion - ejercicio %>%
        arrange(desc(proporcion)) %>%
        slice(2) %>% 
        pull(proporcion)
    } else { # Si no fue el ganador
      # Margen es la diferencia vs el ganador
      margen <- ejercicio %>% 
        filter(opcion == opcion_) %>%
        pull(proporcion) - ganador$proporcion
    }
  } else { # Si sólo hubo un contendiente
    # Margen es la proporción de votos obtenidos
    margen <- ganador$proporcion
  }
  return(margen)
}

margen <- apply(eleccion, 1, calcular_margen)
ruta <- './data/interim/margen/'
ruta <- str_c(ruta, 'margen.rds')
saveRDS(margen, ruta)

margen[lengths(margen) > 1] <- NA
ruta <- './data/interim/margen/'
ruta <- str_c(ruta, 'margen_na.rds')
saveRDS(margen, ruta)

margen <- unlist(margen)
eleccion$margen <- margen
ruta <- './data/interim/margen/'
ruta <- str_c(ruta, 'eleccionConMargen.csv')
write_csv(eleccion, ruta)



# margen[revisar]
# calcular_margen(eleccion[revisar[1],])
# Se observa que salieron algunos registros con doble número, se revisan
# revisar <- which(lengths(margen) > 1)

# eleccion %>%
#   filter(
#     yr %in% eleccion %>% slice(revisar) %>% unique(yr),
#     edon %in% eleccion %>% slice(revisar) %>% unique(edon),
#   )

# eleccion %>% filter(yr == 1990, edon == 5, inegi == 5038)

# eleccion %>% colnames()

# > nElementos <- lengths(margen)
# > which(nElementos>1)
# [1]   3644   3645   3646  60050  60051  60052  60053  60054  60055  60056  60057
# [12]  60058  87528  87529  89669  89670  92723  92724  95870  95871  95872  95873
# [23]  95874  95875  95876  95877  95878 107474 107475 107476 107477 107478 110364
# [34] 110365 110366 110367 110368 110369 110370 110371 110372 110373 110713 110714
# [45] 110715 110716 110717 110718 110719 110720 110721 110722 110723 110724 110725
# [56] 136933 136934 167019 167020 167021 167022 167023 167024 167025 167026 167027
# [67] 167028 167029 167030

