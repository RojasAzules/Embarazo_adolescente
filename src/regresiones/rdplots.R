library("rdrobust")

eleccion <- read_csv('data/interim/margen/eleccionMargenTasa.csv') %>%
  filter(Anho > 2003,
         abs(margen) < 0.5)

rdplot(eleccion$tefa, eleccion$margen, binselect = "qsmv",
       title = 'Tasa del año de la elección',
       x.label = 'Margen de victoria',
       y.label = 'TFA (por cada 1000)')
ggsave("data/processed/img/tasa_0.png")

rdplot(eleccion$tefa_1, eleccion$margen, binselect = "qsmv",
       title = 'Tasa 1 año tras la elección',
       x.label = 'Margen de victoria',
       y.label = 'TFA (por cada 1000)')
ggsave("data/processed/img/tasa_1.png")

rdplot(eleccion$tefa_2, eleccion$margen, binselect = "qsmv",
       title = 'Tasa 2 años tras la elección',
       x.label = 'Margen de victoria',
       y.label = 'TFA (por cada 1000)')
ggsave("data/processed/img/tasa_2.png")

rdplot(eleccion$tefa_3, eleccion$margen, binselect = "qsmv",
       title = 'Tasa 3 años tras la elección',
       x.label = 'Margen de victoria',
       y.label = 'TFA (por cada 1000)')
ggsave("data/processed/img/tasa_3.png")

rdplot(eleccion$tefa_4, eleccion$margen, binselect = "qsmv",
       title = 'Tasa 4 años tras la elección',
       x.label = 'Margen de victoria',
       y.label = 'TFA (por cada 1000)')
ggsave("data/processed/img/tasa_4.png")

rdplot(eleccion$tefa_5, eleccion$margen, binselect = "qsmv",
       title = 'Tasa 5 años tras la elección',
       x.label = 'Margen de victoria',
       y.label = 'TFA (por cada 1000)')
ggsave("data/processed/img/tasa_5.png")

rdplot(eleccion$tefa_6, eleccion$margen, binselect = "qsmv",
       title = 'Tasa 6 años tras la elección',
       x.label = 'Margen de victoria',
       y.label = 'TFA (por cada 1000)')
ggsave("data/processed/img/tasa_6.png")

rdplot(eleccion$tefa_7, eleccion$margen, binselect = "qsmv",
       title = 'Tasa 7 años tras la elección',
       x.label = 'Margen de victoria',
       y.label = 'TFA (por cada 1000)')
ggsave("data/processed/img/tasa_7.png")

rdplot(eleccion$tefa_8, eleccion$margen, binselect = "qsmv",
       title = 'Tasa 8 años tras la elección',
       x.label = 'Margen de victoria',
       y.label = 'TFA (por cada 1000)')
ggsave("data/processed/img/tasa_8.png")

rdplot(eleccion$tefa_9, eleccion$margen, binselect = "qsmv",
       title = 'Tasa 9 años tras la elección',
       x.label = 'Margen de victoria',
       y.label = 'TFA (por cada 1000)')
ggsave("data/processed/img/tasa_9.png")

out <- rdrobust(eleccion$tefa, eleccion$margen, kernel = "uniform", p = 1, h = 0.1)
summary(out)

out <- rdrobust(eleccion$tefa_3, eleccion$margen, kernel = "uniform", p = 1, h = 0.1)
summary(out)

out <- rdrobust(eleccion$tefa_4, eleccion$margen, kernel = "uniform", p = 1, h = 0.1)
summary(out)

out <- rdrobust(eleccion$tefa_5, eleccion$margen, kernel = "uniform", p = 1, h = 0.1)
summary(out)

out <- rdrobust(eleccion$tefa_6, eleccion$margen, kernel = "uniform", p = 1, h = 0.1)
summary(out)

