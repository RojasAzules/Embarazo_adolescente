
load('data/interim/regresiones/resumen_regresiones.Rda')

tabla %>% 
  select(-`Z-score`) %>%
  mutate(across(4:7, round, 4)) %>%
  filter(Controles == 'No', Pesos == 'No') %>%
  kable(., format = "latex", booktabs = T) %>%
  cat(., file = "./data/processed/tex/resumen_1.tex")

tabla %>% 
  select(-`Z-score`) %>%
  mutate(across(4:7, round, 4)) %>%
  filter(Controles == 'No', Pesos == 'Sí') %>%
  kable(., format = "latex", booktabs = T) %>%
  cat(., file = "./data/processed/tex/resumen_2.tex")

tabla %>% 
  select(-`Z-score`) %>%
  mutate(across(4:7, round, 4)) %>%
  filter(Controles == 'Sí', Pesos == 'No') %>%
  kable(., format = "latex", booktabs = T) %>%
  cat(., file = "./data/processed/tex/resumen_3.tex")

tabla %>% 
  select(-`Z-score`) %>%
  mutate(across(4:7, round, 4)) %>%
  filter(Controles == 'Sí', Pesos == 'Sí') %>%
  kable(., format = "latex", booktabs = T) %>%
  cat(., file = "./data/processed/tex/resumen_4.tex")

tabla_obs %>% 
  select(-`Z-score`) %>%
  mutate(across(4:7, round, 4)) %>%
  filter(Controles == 'No', Pesos == 'No') %>%
  kable(., format = "latex", booktabs = T) %>%
  cat(., file = "./data/processed/tex/resumen_5.tex")

tabla_obs %>% 
  select(-`Z-score`) %>%
  mutate(across(4:7, round, 4)) %>%
  filter(Controles == 'No', Pesos == 'Sí') %>%
  kable(., format = "latex", booktabs = T) %>%
  cat(., file = "./data/processed/tex/resumen_6.tex")

tabla_obs %>% 
  select(-`Z-score`) %>%
  mutate(across(4:7, round, 4)) %>%
  filter(Controles == 'Sí', Pesos == 'No') %>%
  kable(., format = "latex", booktabs = T) %>%
  cat(., file = "./data/processed/tex/resumen_7.tex")

tabla_obs %>% 
  select(-`Z-score`) %>%
  mutate(across(4:7, round, 4)) %>%
  filter(Controles == 'Sí', Pesos == 'Sí') %>%
  kable(., format = "latex", booktabs = T) %>%
  cat(., file = "./data/processed/tex/resumen_8.tex")




 # %>%
 #  kable_styling(latex_options = "striped")