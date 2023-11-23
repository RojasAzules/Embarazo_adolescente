

# 
# rdplot(eleccion$tefa_1, eleccion$margen, binselect = "qsmv",
#        title = 'Tasa 1 año tras la elección',
#        x.label = 'Margen de victoria',
#        y.label = 'TFA (por cada 1000)')
# ggsave("data/processed/img/tasa_1.png")
# 
# bw <- rdbwselect(eleccion$tefa_1, eleccion$margen, kernel = "triangular", p = 1, bwselect = "mserd")
# summary(bw)
# 
# out <- rdrobust(eleccion$tefa_1, eleccion$margen, kernel = "uniform", p = 1, h = bw$bws[1])
# summary(out)
# 
# out %>% rdr_export() %>%
#   kable(., format = "latex", booktabs = T) %>%
#   collapse_rows(columns = 1, latex_hline = "major", valign = "middle") %>%
#   cat(., file = "./data/processed/tex/tefa_01.tex")
# 
# 
# 
# 
# rdplot(eleccion$tefa_2, eleccion$margen, binselect = "qsmv",
#        title = 'Tasa 2 años tras la elección',
#        x.label = 'Margen de victoria',
#        y.label = 'TFA (por cada 1000)')
# ggsave("data/processed/img/tasa_2.png")
# 
# bw <- rdbwselect(eleccion$tefa_2, eleccion$margen, kernel = "triangular", p = 1, bwselect = "mserd")
# summary(bw)
# 
# out <- rdrobust(eleccion$tefa_2, eleccion$margen, kernel = "uniform", p = 1, h = bw$bws[1])
# summary(out)
# 
# out %>% rdr_export() %>%
#   kable(., format = "latex", booktabs = T) %>%
#   collapse_rows(columns = 1, latex_hline = "major", valign = "middle") %>%
#   cat(., file = "./data/processed/tex/tefa_02.tex")
# 
# 
# 
# rdplot(eleccion$tefa_3, eleccion$margen, binselect = "qsmv",
#        title = 'Tasa 3 años tras la elección',
#        x.label = 'Margen de victoria',
#        y.label = 'TFA (por cada 1000)')
# ggsave("data/processed/img/tasa_3.png")
# 
# bw <- rdbwselect(eleccion$tefa_3, eleccion$margen, kernel = "triangular", p = 1, bwselect = "mserd")
# summary(bw)
# 
# out <- rdrobust(eleccion$tefa_3, eleccion$margen, kernel = "uniform", p = 1, h = bw$bws[1])
# summary(out)
# 
# out %>% rdr_export() %>%
#   kable(., format = "latex", booktabs = T) %>%
#   collapse_rows(columns = 1, latex_hline = "major", valign = "middle") %>%
#   cat(., file = "./data/processed/tex/tefa_03.tex")
# 
# 
# 
# rdplot(eleccion$tefa_4, eleccion$margen, binselect = "qsmv",
#        title = 'Tasa 4 años tras la elección',
#        x.label = 'Margen de victoria',
#        y.label = 'TFA (por cada 1000)')
# ggsave("data/processed/img/tasa_4.png")
# 
# bw <- rdbwselect(eleccion$tefa_4, eleccion$margen, kernel = "triangular", p = 1, bwselect = "mserd")
# summary(bw)
# 
# out <- rdrobust(eleccion$tefa_4, eleccion$margen, kernel = "uniform", p = 1, h = bw$bws[1])
# summary(out)
# 
# out %>% rdr_export() %>%
#   kable(., format = "latex", booktabs = T) %>%
#   collapse_rows(columns = 1, latex_hline = "major", valign = "middle") %>%
#   cat(., file = "./data/processed/tex/tefa_04.tex")
# 
# 
# 
# rdplot(eleccion$tefa_5, eleccion$margen, binselect = "qsmv",
#        title = 'Tasa 5 años tras la elección',
#        x.label = 'Margen de victoria',
#        y.label = 'TFA (por cada 1000)')
# ggsave("data/processed/img/tasa_5.png")
# 
# bw <- rdbwselect(eleccion$tefa_5, eleccion$margen, kernel = "triangular", p = 1, bwselect = "mserd")
# summary(bw)
# 
# out <- rdrobust(eleccion$tefa_5, eleccion$margen, kernel = "uniform", p = 1, h = bw$bws[1])
# summary(out)
# 
# out %>% rdr_export() %>%
#   kable(., format = "latex", booktabs = T) %>%
#   collapse_rows(columns = 1, latex_hline = "major", valign = "middle") %>%
#   cat(., file = "./data/processed/tex/tefa_05.tex")
# 
# 
# 
# rdplot(eleccion$tefa_6, eleccion$margen, binselect = "qsmv",
#        title = 'Tasa 6 años tras la elección',
#        x.label = 'Margen de victoria',
#        y.label = 'TFA (por cada 1000)')
# ggsave("data/processed/img/tasa_6.png")
# 
# bw <- rdbwselect(eleccion$tefa_6, eleccion$margen, kernel = "triangular", p = 1, bwselect = "mserd")
# summary(bw)
# 
# out <- rdrobust(eleccion$tefa_6, eleccion$margen, kernel = "uniform", p = 1, h = bw$bws[1])
# summary(out)
# 
# out %>% rdr_export() %>%
#   kable(., format = "latex", booktabs = T) %>%
#   collapse_rows(columns = 1, latex_hline = "major", valign = "middle") %>%
#   cat(., file = "./data/processed/tex/tefa_06.tex")
# 
# 
# 
# rdplot(eleccion$tefa_7, eleccion$margen, binselect = "qsmv",
#        title = 'Tasa 7 años tras la elección',
#        x.label = 'Margen de victoria',
#        y.label = 'TFA (por cada 1000)')
# ggsave("data/processed/img/tasa_7.png")
# 
# bw <- rdbwselect(eleccion$tefa_7, eleccion$margen, kernel = "triangular", p = 1, bwselect = "mserd")
# summary(bw)
# 
# out <- rdrobust(eleccion$tefa_7, eleccion$margen, kernel = "uniform", p = 1, h = bw$bws[1])
# summary(out)
# 
# out %>% rdr_export() %>%
#   kable(., format = "latex", booktabs = T) %>%
#   collapse_rows(columns = 1, latex_hline = "major", valign = "middle") %>%
#   cat(., file = "./data/processed/tex/tefa_07.tex")
# 
# 
# 
# rdplot(eleccion$tefa_8, eleccion$margen, binselect = "qsmv",
#        title = 'Tasa 8 años tras la elección',
#        x.label = 'Margen de victoria',
#        y.label = 'TFA (por cada 1000)')
# ggsave("data/processed/img/tasa_8.png")
# 
# bw <- rdbwselect(eleccion$tefa_8, eleccion$margen, kernel = "triangular", p = 1, bwselect = "mserd")
# summary(bw)
# 
# out <- rdrobust(eleccion$tefa_8, eleccion$margen, kernel = "uniform", p = 1, h = bw$bws[1])
# summary(out)
# 
# out %>% rdr_export() %>%
#   kable(., format = "latex", booktabs = T) %>%
#   collapse_rows(columns = 1, latex_hline = "major", valign = "middle") %>%
#   cat(., file = "./data/processed/tex/tefa_08.tex")
# 
# 
# 
# rdplot(eleccion$tefa_9, eleccion$margen, binselect = "qsmv",
#        title = 'Tasa 9 años tras la elección',
#        x.label = 'Margen de victoria',
#        y.label = 'TFA (por cada 1000)')
# ggsave("data/processed/img/tasa_9.png")
# 
# bw <- rdbwselect(eleccion$tefa_9, eleccion$margen, kernel = "triangular", p = 1, bwselect = "mserd")
# summary(bw)
# 
# out <- rdrobust(eleccion$tefa_9, eleccion$margen, kernel = "uniform", p = 1, h = bw$bws[1])
# summary(out)
# 
# out %>% rdr_export() %>%
#   kable(., format = "latex", booktabs = T) %>%
#   collapse_rows(columns = 1, latex_hline = "major", valign = "middle") %>%
#   cat(., file = "./data/processed/tex/tefa_09.tex")
# 
# 
