
combo_c_y_p <- function(variable, etiqueta, titulo, bandera_obstretica){
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
             covs = eleccion$tefa_m1,
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
                   covs = eleccion$tefa_m1,
                   weights = eleccion$log_pop)
  summary(bw)
  
  # 3. Estimación de la regresión discontinua
  out <- rdrobust(pull(eleccion[variable]), eleccion$margen,
                  kernel = "uniform", p = 1, bwselect = "mserd", all = TRUE, 
                  covs = eleccion$tefa_m1,
                  weights = eleccion$log_pop)
  summary(out)
  
  # 4. Exportar tabla de la regresión a formato latex
  # out %>% rdr_export() %>%
  #   kable(., format = "latex", booktabs = T) %>%
  #   collapse_rows(columns = 1, latex_hline = "major", valign = "middle") %>%
  #   cat(., file = paste("./data/processed/tex/detalle/tefa", etiqueta, ".tex", 
  #                       sep = ''))
  
  salida <- modelo_reg()
  salida[1, ] <- list('Sí', 'Sí',
                      variable, etiqueta, titulo,
                      out$coef[1], out$se[1], out$z[1], out$pv[1],
                      out$coef[3], out$se[3], out$z[3], out$pv[3],
                      out$bws[1,1])
}


salida[31, ] = combo_c_y_p('tefa_00', '_00_c_y_p', 'Tasa el año de la elección',0)
salida[32, ] = combo_c_y_p('tefa_01', '_01_c_y_p', 'Tasa 1 año tras la elección',0)
salida[33, ] = combo_c_y_p('tefa_02', '_02_c_y_p', 'Tasa 2 años tras la elección',0)
salida[34, ] = combo_c_y_p('tefa_03', '_03_c_y_p', 'Tasa 3 años tras la elección',0)
salida[35, ] = combo_c_y_p('tefa_04', '_04_c_y_p', 'Tasa 4 años tras la elección',0)
salida[36, ] = combo_c_y_p('tefa_05', '_05_c_y_p', 'Tasa 5 años tras la elección',0)
salida[37, ] = combo_c_y_p('tefa_06', '_06_c_y_p', 'Tasa 6 años tras la elección',0)
salida[38, ] = combo_c_y_p('tefa_07', '_07_c_y_p', 'Tasa 7 años tras la elección',0)
salida[39, ] = combo_c_y_p('tefa_08', '_08_c_y_p', 'Tasa 8 años tras la elección',0)
salida[40, ] = combo_c_y_p('tefa_09', '_09_c_y_p', 'Tasa 9 años tras la elección',0)


salida_obs[31, ] = combo_c_y_p('tobstetrica_00', 'obs_00_c_y_p', 'Tasa el año de la elección',1)
salida_obs[32, ] = combo_c_y_p('tobstetrica_01', 'obs_01_c_y_p', 'Tasa 1 año tras la elección',1)
salida_obs[33, ] = combo_c_y_p('tobstetrica_02', 'obs_02_c_y_p', 'Tasa 2 años tras la elección',1)
salida_obs[34, ] = combo_c_y_p('tobstetrica_03', 'obs_03_c_y_p', 'Tasa 3 años tras la elección',1)
salida_obs[35, ] = combo_c_y_p('tobstetrica_04', 'obs_04_c_y_p', 'Tasa 4 años tras la elección',1)
salida_obs[36, ] = combo_c_y_p('tobstetrica_05', 'obs_05_c_y_p', 'Tasa 5 años tras la elección',1)
salida_obs[37, ] = combo_c_y_p('tobstetrica_06', 'obs_06_c_y_p', 'Tasa 6 años tras la elección',1)
salida_obs[38, ] = combo_c_y_p('tobstetrica_07', 'obs_07_c_y_p', 'Tasa 7 años tras la elección',1)
salida_obs[39, ] = combo_c_y_p('tobstetrica_08', 'obs_08_c_y_p', 'Tasa 8 años tras la elección',1)
salida_obs[40, ] = combo_c_y_p('tobstetrica_09', 'obs_09_c_y_p', 'Tasa 9 años tras la elección',1)


