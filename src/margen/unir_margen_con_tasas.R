# library(tidyverse)


eleccion <- read_csv('data/interim/margen/eleccionConMargen.csv') %>%
  filter(yr > 1985,
         yr < 2021,
         str_detect(partidos, 'pan')) %>%
  mutate(Muni    = as.numeric(inegi) - edon*1000) %>%
  rename(Anho    = yr,
         Estado  = edon) %>%
  mutate(Anho_1  = Anho + 1,
         Anho_2  = Anho + 2,
         Anho_3  = Anho + 3,
         Anho_4  = Anho + 4,
         Anho_5  = Anho + 5,
         Anho_6  = Anho + 6,
         Anho_7  = Anho + 7,
         Anho_8  = Anho + 8,
         Anho_9  = Anho + 9,
         Anho_10 = Anho + 10)

tasas <- read_csv('data/interim/poblacion/Poblacion_con_tefa.csv') %>%
  select(Anho, Estado, Muni, Territorio, tefa)

eleccion <- eleccion %>%
  left_join(tasas, by = c("Anho" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni"))

eleccion <- eleccion %>%
  left_join(tasas, by = c("Anho_1" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_1")) %>%
  left_join(tasas, by = c("Anho_2" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_2")) %>%
  left_join(tasas, by = c("Anho_3" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_3")) %>%
  left_join(tasas, by = c("Anho_4" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_4")) %>%
  left_join(tasas, by = c("Anho_5" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_5")) %>%
  left_join(tasas, by = c("Anho_6" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_6")) %>%
  left_join(tasas, by = c("Anho_7" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_7")) %>%
  left_join(tasas, by = c("Anho_8" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_8")) %>%
  left_join(tasas, by = c("Anho_9" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_9")) %>%
  left_join(tasas, by = c("Anho_10" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_10")) %>%
  select(-Anho_1, -Anho_2, -Anho_3, -Anho_4, -Anho_5,
         -Anho_6, -Anho_7, -Anho_8, -Anho_9, -Anho_10) %>%
  relocate(emm, Anho, Estado, Muni, inegi, Territorio, mun)


ruta <- './data/interim/margen/'
ruta <- str_c(ruta, 'eleccionMargenTasa.csv')
write_csv(eleccion, ruta)


