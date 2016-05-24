install.packages("googlesheets")

require(dplyr)
require(googlesheets)

# Give googlesheets permission to access your spreadsheets and google drive
gs_auth()

## Buscar sheet
gs_ls("Programación Casateatro El Poblado")

# Carga la hoja de cálculo flujo de usuarios
reporte_actividades <- gs_title("Programación Casateatro El Poblado")

## Carga de la hoja de cáculo la pestaña Reporte diario de datos
grupos <- reporte_actividades %>% gs_read(ws = "integrados_solo_grupos_musicales")

## para ver la estructura de la variable
str(grupos)

## acceder por $
grupos$lineup

grupos[1,1]

grupos[1,]

grupos[,1]

grupos[,1:3]

## Acceder por el nombre de las variables

grupos[,"venue"]

grupos[,c("venue","lineup")]

grupos[c(2:5,50:60),c(1,3,5,8)]

## ¿Cóo se llaman las columnas?
n_cols <- colnames(grupos)

grupos[,n_cols[c(1,3,7,9,11)]]

data.frame(grupos[,n_cols[c(1,3,7,9,11)]])

grupos[,n_cols[c(1,3,7,9,11)]]

grupos[,c("venue","date", "lineup", "city", "coordinates")]

## Separar por comas para buscar funcionalidades/funciones http://www.rdocumentation.org/
require(stringr)

partidos <- str_split(grupos$lineup,",")

str(partidos)

## asociadas a las list hay unas operaciones que le permiten iterar sobre las listas
## funciones del tipo apply

?lapply

## http://christophergandrud.github.io/DataCombine/
