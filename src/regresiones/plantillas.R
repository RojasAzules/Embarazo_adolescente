modelo_reg <- function(){
  # Crear data frame vacío
  salida <- data.frame(controles = character(),
                       pesos = character(),
                       Y = character(),    
                       etiqueta = character(),
                       titulo = character(),
                       coef = numeric(),
                       se = numeric(),
                       z = numeric(),
                       p_value = numeric(),
                       coef_r = numeric(),
                       se_r = numeric(),
                       z_r = numeric(),
                       p_value_r = numeric(),
                       bw = numeric(),
                       stringsAsFactors = FALSE)  
  
  colnames(salida) <- c('Controles', 'Pesos', 'Y', 'Etiqueta', 'Título', 
                        'Coeficiente', 'Desviación Estándar', 'Z-score', 'p-value',
                        'Coeficiente R', 'Desviación Estándar R', 'Z-score R', 'p-value R',
                        'Bandwidth')
  return(salida)
}

