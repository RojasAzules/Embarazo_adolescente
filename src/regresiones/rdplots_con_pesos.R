
combo_pesos <- function(variable, etiqueta, titulo, bandera_obstretica){
  # El combo incluye:
  print(paste('----------', etiqueta, '----------'))
  # 1. Diagrama de regresión discontinua
  tryCatch(
    #try to do this
    {
      if (bandera_obstretica == 1) {
        ylab <- 'Tasa de atención obstétrica (por cada 1000)'
      } else {
        ylab <- 'TFA (por cada 1000)'
      }
      rdplot(eleccion %>% pull(variable), 
             eleccion %>% pull('margen'), 
             binselect = "qsmv",
             weights = eleccion$log_pop,
             # title = titulo,
             title = '',
             x.label = 'Margen de victoria',
             y.label = 'TFA (por cada 1000)')
      ggsave(paste("data/processed/img/tasa", etiqueta, ".png", sep = ''))
    },
    #if an error occurs, tell me the error
    error = function(e) {
      message('Ocurrió un error al generar la gráfica')
      print(e)
      return(NA)
    },
    #if a warning occurs, tell me the warning
    warning = function(w) {
      message('Ocurrió un warning al generar la gráfica')
      print(w)
      return(NA)
    }
  )
  
  # 2. Estimación de ancho de banda óptimo de acuerdo a Cattaneo 2014
  bw <- rdbwselect(pull(eleccion[variable]), eleccion$margen,
                   kernel = "uniform", p = 1, bwselect = "mserd", 
                   weights = eleccion$log_pop)
  summary(bw)
  
  # 3. Estimación de la regresión discontinua
  out <- rdrobust(pull(eleccion[variable]), eleccion$margen,
                  kernel = "uniform", p = 1, bwselect = "mserd", all = TRUE,
                  weights = eleccion$log_pop)
  summary(out)
  
  # 4. Exportar tabla de la regresión a formato latex
  # out %>% rdr_export() %>%
  #   kable(., format = "latex", booktabs = T) %>%
  #   collapse_rows(columns = 1, latex_hline = "major", valign = "middle") %>%
  #   cat(., file = paste("./data/processed/tex/detalle/tefa", etiqueta, ".tex", 
  #                       sep = ''))
  
  salida <- modelo_reg()
  salida[1, ] <- list('No', 'Sí',
                      variable, etiqueta, titulo,
                      out$coef[1], out$se[1], out$z[1], out$pv[1],
                      out$coef[3], out$se[3], out$z[3], out$pv[3],
                      out$bws[1,1])
}

salida[11, ] = combo_pesos('tefa_00', '_00_w', 'Tasa el año de la elección',0)
salida[12, ] = combo_pesos('tefa_01', '_01_w', 'Tasa 1 año tras la elección',0)
salida[13, ] = combo_pesos('tefa_02', '_02_w', 'Tasa 2 años tras la elección',0)
salida[14, ] = combo_pesos('tefa_03', '_03_w', 'Tasa 3 años tras la elección',0)
salida[15, ] = combo_pesos('tefa_04', '_04_w', 'Tasa 4 años tras la elección',0)
salida[16, ] = combo_pesos('tefa_05', '_05_w', 'Tasa 5 años tras la elección',0)
salida[17, ] = combo_pesos('tefa_06', '_06_w', 'Tasa 6 años tras la elección',0)
salida[18, ] = combo_pesos('tefa_07', '_07_w', 'Tasa 7 años tras la elección',0)
salida[19, ] = combo_pesos('tefa_08', '_08_w', 'Tasa 8 años tras la elección',0)
salida[20, ] = combo_pesos('tefa_09', '_09_w', 'Tasa 9 años tras la elección',0)



salida_obs[11, ] = combo_pesos('tobstetrica_00', 'obs_00_w', 'Tasa el año de la elección',1)
salida_obs[12, ] = combo_pesos('tobstetrica_01', 'obs_01_w', 'Tasa 1 año tras la elección',1)
salida_obs[13, ] = combo_pesos('tobstetrica_02', 'obs_02_w', 'Tasa 2 años tras la elección',1)
salida_obs[14, ] = combo_pesos('tobstetrica_03', 'obs_03_w', 'Tasa 3 años tras la elección',1)
salida_obs[15, ] = combo_pesos('tobstetrica_04', 'obs_04_w', 'Tasa 4 años tras la elección',1)
salida_obs[16, ] = combo_pesos('tobstetrica_05', 'obs_05_w', 'Tasa 5 años tras la elección',1)
salida_obs[17, ] = combo_pesos('tobstetrica_06', 'obs_06_w', 'Tasa 6 años tras la elección',1)
salida_obs[18, ] = combo_pesos('tobstetrica_07', 'obs_07_w', 'Tasa 7 años tras la elección',1)
salida_obs[19, ] = combo_pesos('tobstetrica_08', 'obs_08_w', 'Tasa 8 años tras la elección',1)
salida_obs[20, ] = combo_pesos('tobstetrica_09', 'obs_09_w', 'Tasa 9 años tras la elección',1)



