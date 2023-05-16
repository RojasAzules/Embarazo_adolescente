# library(tidyverse)
library(ggplot2)

# Datos de tefa
ruta  <- './data/interim/poblacion/'
ruta  <- str_c(ruta, 'Poblacion_con_tefa.csv')
tasas <- read_csv(ruta)

tasas <- tasas %>%
  filter(Estado == 13)

tasas %>%
  ggplot(aes(x = Anho, y = tefa, color = Territorio)) +
  geom_line(show.legend = FALSE) +
  labs(title = 'Tasa de fecundidad, Hidalgo')
