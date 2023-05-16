library(tidyverse)
library(ggplot2)

eleccion <- read_csv('data/raw/RMEVR/aymu1970-on.csv')
problems()

#####

eleccion %>% colnames()

eleccion %>%
  pull(tot) %>% class()

# Elecciones con pocos votantes casi todas son atípicas
eleccion %>%
  filter(tot < 10) %>%
  group_by(status) %>%
  summarise(n = n())

# La mayoría de los registros están en ok
eleccion %>%
  group_by(status) %>%
  summarise(n = n())

# Histograma de log número de votantes
eleccion %>%
  filter(status == 'ok') %>%
  mutate(log_tot = log(tot)) %>%
  ggplot(aes(x = log_tot)) +
  geom_histogram()

eleccion %>%
  filter(status == 'ok', tot < 10) %>% pull(tot)

