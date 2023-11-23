
combo <- function(variable, etiqueta, titulo, bandera_obstretica){
# El combo incluye:
  print(paste('----------', etiqueta, '----------'))
  # 1. Diagrama de regresión discontinua
  tryCatch(
    #try to do this
    {
      if (bandera_obstretica == 1) {
        ylab <- 'Tasa de atención obstétrica adolescente'
      } else {
        ylab <- 'Tasa de fecundidad adolescente'
      }
      rdplot(eleccion %>% pull(variable), 
             eleccion %>% pull('margen'), 
             binselect = "qsmv",
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
                   kernel = "uniform", p = 1, bwselect = "mserd")
  summary(bw)
  
  # 3. Estimación de la regresión discontinua
  out <- rdrobust(pull(eleccion[variable]), eleccion$margen,
                  kernel = "uniform", p = 1, bwselect = "mserd", all = TRUE)
  summary(out)
  
  # 4. Exportar tabla de la regresión a formato latex
  # out %>% rdr_export() %>%
  #   kable(., format = "latex", booktabs = T) %>%
  #   collapse_rows(columns = 1, latex_hline = "major", valign = "middle") %>%
  #   cat(., file = paste("./data/processed/tex/detalle/tefa", etiqueta, ".tex", 
  #                       sep = ''))
  
  salida <- modelo_reg()
  salida[1, ] <- list('No', 'No',
                      variable, etiqueta, titulo,
                      out$coef[1], out$se[1], out$z[1], out$pv[1],
                      out$coef[3], out$se[3], out$z[3], out$pv[3],
                      out$bws[1,1])
}


salida[ 1, ] = combo('tefa_00', '_00', 'Tasa el año de la elección',0)
salida[ 2, ] = combo('tefa_01', '_01', 'Tasa 1 año tras la elección',0)
salida[ 3, ] = combo('tefa_02', '_02', 'Tasa 2 años tras la elección',0)
salida[ 4, ] = combo('tefa_03', '_03', 'Tasa 3 años tras la elección',0)
salida[ 5, ] = combo('tefa_04', '_04', 'Tasa 4 años tras la elección',0)
salida[ 6, ] = combo('tefa_05', '_05', 'Tasa 5 años tras la elección',0)
salida[ 7, ] = combo('tefa_06', '_06', 'Tasa 6 años tras la elección',0)
salida[ 8, ] = combo('tefa_07', '_07', 'Tasa 7 años tras la elección',0)
salida[ 9, ] = combo('tefa_08', '_08', 'Tasa 8 años tras la elección',0)
salida[10, ] = combo('tefa_09', '_09', 'Tasa 9 años tras la elección',0)


salida_obs[ 1, ] = combo('tobstetrica_00', 'obs_00', 'Tasa el año de la elección',1)
salida_obs[ 2, ] = combo('tobstetrica_01', 'obs_01', 'Tasa 1 año tras la elección',1)
salida_obs[ 3, ] = combo('tobstetrica_02', 'obs_02', 'Tasa 2 años tras la elección',1)
salida_obs[ 4, ] = combo('tobstetrica_03', 'obs_03', 'Tasa 3 años tras la elección',1)
salida_obs[ 5, ] = combo('tobstetrica_04', 'obs_04', 'Tasa 4 años tras la elección',1)
salida_obs[ 6, ] = combo('tobstetrica_05', 'obs_05', 'Tasa 5 años tras la elección',1)
salida_obs[ 7, ] = combo('tobstetrica_06', 'obs_06', 'Tasa 6 años tras la elección',1)
salida_obs[ 8, ] = combo('tobstetrica_07', 'obs_07', 'Tasa 7 años tras la elección',1)
salida_obs[ 9, ] = combo('tobstetrica_08', 'obs_08', 'Tasa 8 años tras la elección',1)
salida_obs[10, ] = combo('tobstetrica_09', 'obs_09', 'Tasa 9 años tras la elección',1)


