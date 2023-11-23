# library(tidyverse)

eleccion <- read_csv('data/interim/margen/eleccionConMargen.csv') %>%
  filter(yr > 1985,
         yr < 2021,
         str_detect(partidos, 'pan')) %>%
  mutate(Muni    = as.numeric(inegi) - edon*1000) %>%
  rename(Anho = yr,
         Estado  = edon) %>%
  mutate(Anho_01  = Anho + 1,
         Anho_02  = Anho + 2,
         Anho_03  = Anho + 3,
         Anho_04  = Anho + 4,
         Anho_05  = Anho + 5,
         Anho_06  = Anho + 6,
         Anho_07  = Anho + 7,
         Anho_08  = Anho + 8,
         Anho_09  = Anho + 9,
         Anho_10  = Anho + 10,
         Anho_m1  = Anho - 1)

tasas <- read_csv('data/interim/poblacion/Poblacion_con_tefa_y_obstetrica.csv') %>%
  select(Anho, Estado, Muni, Territorio, tefa, nMujeres, t_obstetrica, nEgresos) %>%
  rename(tobstetrica = t_obstetrica)

eleccion <- eleccion %>%
  left_join(tasas, by = c("Anho" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni"))

eleccion <- eleccion %>%
  left_join(tasas, by = c("Anho_01" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_01")) %>%
  left_join(tasas, by = c("Anho_02" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_02")) %>%
  left_join(tasas, by = c("Anho_03" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_03")) %>%
  left_join(tasas, by = c("Anho_04" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_04")) %>%
  left_join(tasas, by = c("Anho_05" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_05")) %>%
  left_join(tasas, by = c("Anho_06" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_06")) %>%
  left_join(tasas, by = c("Anho_07" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_07")) %>%
  left_join(tasas, by = c("Anho_08" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_08")) %>%
  left_join(tasas, by = c("Anho_09" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_09")) %>%
  left_join(tasas, by = c("Anho_10" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_10")) %>%
  left_join(tasas, by = c("Anho_m1" = "Anho",
                          "Estado" = "Estado",
                          "Muni" = "Muni",
                          "Territorio" = "Territorio"), suffix = c("", "_m1")) %>%
  select(-Anho_01, -Anho_02, -Anho_03, -Anho_04, -Anho_05,
         -Anho_06, -Anho_07, -Anho_08, -Anho_09, -Anho_10, -Anho_m1) %>%
  relocate(emm, Anho, Estado, Muni, inegi, Territorio, mun) %>%
  rename(tefa_00 = tefa,
         tobstetrica_00 = tobstetrica)


ruta <- './data/interim/margen/'
ruta <- str_c(ruta, 'eleccionMargenTasa.csv')
write_csv(eleccion, ruta)


