library(tidyverse)

nacim86  <- read_csv('./data/raw/nacimientos/csv/nacim86.csv')

catcie10 <- read_csv('./data/raw/egresos/Catalogos 2004 - 2014/CATCIE10.csv')

#####
causas <- catcie10 %>%
  # filter(str_detect(Nombre, 'parto')) %>%
  # filter(str_detect(Nombre, 'nacimiento')) %>%
   filter(str_detect(Nombre, 'embarazo|Embarazo')) %>%
  # filter(str_detect(Nombre, 'Producto|Gemelos')) %>%
  select(CAUSA, Nombre)
causas


library(foreign)

ruta <- './data/raw/nacimientos/'
anho <- '2021'

exportar_cat_a_dbf <- function(ruta, anho){
  # Catálogos
  if (as.numeric(anho) < 2013){
    nombre <- 'ENTMUN'
  }
  else if (as.numeric(anho) == 2014) 
    nombre <- str_c('CATEMLN', str_sub(anho, 3, 4)) 
  else{
    nombre <- str_c('CATEMLNA', str_sub(anho, 3, 4)) 
  }
  catalogo <- str_c(ruta, 'natalidad_base_datos_', anho, '_dbf/', nombre, '.dbf')
  cat <- read.dbf(catalogo)
  cat_csv <- str_c(ruta, 'csv/CAT', anho, '.csv')
  write_csv(cat, cat_csv)
  print(cat_csv)
}

anhos <- list('1985', 
              '1986', '1987', '1988', '1989', '1990', 
              '1991', '1992', '1993', '1994', '1995', 
              '1996', '1997', '1998', '1999', '2000', 
              '2001', '2002', '2003', '2004', '2005', 
              '2006', '2007', '2008', '2009', '2010', 
              '2011', '2012', '2013', '2014', '2015', 
              '2016', '2017', '2018', '2019', '2020', 
              '2021')

lapply(anhos, exportar_cat_a_dbf, ruta = './data/raw/nacimientos/')


census2000 <- read.dta('/Users/david/Downloads/horacio/incumbency/Censo 2000/census2000.dta')

