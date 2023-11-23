# library(tidyverse)
library(ggplot2)
library("psych")   

# Datos de tefa
poblacion <- read_csv('data/interim/poblacion/Poblacion_con_tefa_y_obstetrica.csv')

poblacion %>%
  filter(Estado == 13) %>%
  ggplot(aes(x = Anho, y = tefa, color = Territorio)) +
  geom_line(show.legend = FALSE) +
  labs(title = 'Tasa de fecundidad, Hidalgo') + 
  xlab('Año') + ylab('Tasa de fecundidad')
ggsave('data/processed/img/evolucion_tefa_hgo.png')

get_reciprocal <- function(x) {
  1 / x
}
harmonic_mean <- function(x) {
  x %>%
    get_reciprocal() %>%
    mean(na.rm = TRUE) %>%
    get_reciprocal()
}

resumen_tefa <- poblacion %>% 
  group_by(Anho) %>%
  filter(tefa > 0) %>%
  summarise(Media = mean(tefa, na.rm = TRUE),
            MediaH = harmonic_mean(tefa),
            Mediana = quantile(tefa, 0.5, na.rm = TRUE),
            Varianza = var(tefa, na.rm = TRUE),
            Minimo = min(tefa, na.rm = TRUE),
            Maximo = max(tefa, na.rm = TRUE),
            Tasa = 'Fecundidad') %>%
  filter(Anho %in% 2012:2021) %>%
  mutate(across(2:7, round, 4)) %>%
  relocate(Tasa)

resumen_tobs  <- poblacion %>% 
  group_by(Anho) %>%
  filter(t_obstetrica > 0) %>%
  summarise(Media = mean(t_obstetrica, na.rm = TRUE),
            MediaH = harmonic_mean(t_obstetrica),
            Mediana = quantile(t_obstetrica, 0.5, na.rm = TRUE),
            Varianza = var(t_obstetrica, na.rm = TRUE),
            Minimo = min(t_obstetrica, na.rm = TRUE),
            Maximo = max(t_obstetrica, na.rm = TRUE),
            Tasa = 'Obstétrica') %>%
  filter(Anho %in% 2012:2021) %>%
  mutate(across(2:7, round, 4)) %>%
  relocate(Tasa)

resumen <- bind_rows(resumen_tefa, resumen_tobs)

resumen %>%
  kable(., format = "latex", booktabs = T) %>%
  cat(., file = "./data/processed/tex/aed_tasas.tex")

