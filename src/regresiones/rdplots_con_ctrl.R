
combo_controles <- function(variable, etiqueta, titulo, bandera_obstretica){
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
             # title = titulo,
             title = '',
             x.label = 'Margen de victoria',
             y.label = ylab)
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
                   covs = eleccion$tefa_m1)
  summary(bw)
  
  # 3. Estimación de la regresión discontinua
  out <- rdrobust(pull(eleccion[variable]), eleccion$margen,
                  kernel = "uniform", p = 1, bwselect = "mserd", all = TRUE, 
                  covs = eleccion$tefa_m1)
  summary(out)
  
  # 4. Exportar tabla de la regresión a formato latex
  # out %>% rdr_export() %>%
  #   kable(., format = "latex", booktabs = T) %>%
  #   collapse_rows(columns = 1, latex_hline = "major", valign = "middle") %>%
  #   cat(., file = paste("./data/processed/tex/detalle/tefa", etiqueta, ".tex", 
  #                       sep = ''))
  
  salida <- modelo_reg()
  salida[1, ] <- list('Sí', 'No',
                      variable, etiqueta, titulo,
                      out$coef[1], out$se[1], out$z[1], out$pv[1],
                      out$coef[3], out$se[3], out$z[3], out$pv[3],
                      out$bws[1,1])
}


salida[21, ] = combo_controles('tefa_00', '_00_c', 'Tasa el año de la elección',0)
salida[22, ] = combo_controles('tefa_01', '_01_c', 'Tasa 1 año tras la elección',0)
salida[23, ] = combo_controles('tefa_02', '_02_c', 'Tasa 2 años tras la elección',0)
salida[24, ] = combo_controles('tefa_03', '_03_c', 'Tasa 3 años tras la elección',0)
salida[25, ] = combo_controles('tefa_04', '_04_c', 'Tasa 4 años tras la elección',0)
salida[26, ] = combo_controles('tefa_05', '_05_c', 'Tasa 5 años tras la elección',0)
salida[27, ] = combo_controles('tefa_06', '_06_c', 'Tasa 6 años tras la elección',0)
salida[28, ] = combo_controles('tefa_07', '_07_c', 'Tasa 7 años tras la elección',0)
salida[29, ] = combo_controles('tefa_08', '_08_c', 'Tasa 8 años tras la elección',0)
salida[30, ] = combo_controles('tefa_09', '_09_c', 'Tasa 9 años tras la elección',0)


salida_obs[21, ] = combo_controles('tobstetrica_00', 'obs_00_c', 'Tasa el año de la elección',1)
salida_obs[22, ] = combo_controles('tobstetrica_01', 'obs_01_c', 'Tasa 1 año tras la elección',1)
salida_obs[23, ] = combo_controles('tobstetrica_02', 'obs_02_c', 'Tasa 2 años tras la elección',1)
salida_obs[24, ] = combo_controles('tobstetrica_03', 'obs_03_c', 'Tasa 3 años tras la elección',1)
salida_obs[25, ] = combo_controles('tobstetrica_04', 'obs_04_c', 'Tasa 4 años tras la elección',1)
salida_obs[26, ] = combo_controles('tobstetrica_05', 'obs_05_c', 'Tasa 5 años tras la elección',1)
salida_obs[27, ] = combo_controles('tobstetrica_06', 'obs_06_c', 'Tasa 6 años tras la elección',1)
salida_obs[28, ] = combo_controles('tobstetrica_07', 'obs_07_c', 'Tasa 7 años tras la elección',1)
salida_obs[29, ] = combo_controles('tobstetrica_08', 'obs_08_c', 'Tasa 8 años tras la elección',1)
salida_obs[30, ] = combo_controles('tobstetrica_09', 'obs_09_c', 'Tasa 9 años tras la elección',1)


