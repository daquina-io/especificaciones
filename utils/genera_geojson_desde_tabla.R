rm(list=ls())

## require(devtools)
## Paquete dpmr data package manager para R no funciona
## install_github("christophergandrud/dpmr")
## require(dpmr) ## https://github.com/christophergandrud/dpmr/
## URL <- "https://github.com/son0p/dataSet_grupos_casa_teatro/archive/master.zip"
## gdp_data <- datapackage_install(path = URL)
## str(gdp_data)
###  No funciona tan bien el paquete de R ###

require(RCurl) ## paquete interfaz para curl
require(stringr) ## paquete para manipulación de strings
require(stringi) ## paquete para manipulación de strings
require(dplyr)
require(googlesheets)

direccion <- "https://raw.githubusercontent.com/son0p/dataSet_grupos_casa_teatro/master/data/Artistas_casa_teatro_filtrado.csv"
url_direccion<- getURL(direccion) ## Se trae la página inidcada en direccion en el formato csv
data <- read.csv(text = url_direccion) ## Se lee el csv obtenido de internet y se convierte en tabla para guardarlo en data


data <- grupos
## El dato de la coordenada viene en el campo geometry pero viene en formato xml dentro de Point > coordinates, se usa el siguiente patrón de expresión regular para quitar lo que sobra y dejar solo latitud y longitud al extraérselo como texto
pattern <- "-.[0-9].[0-9]+,[0-9].[0-9]+"
data$geometry <- str_extract(data$geometry, pattern)
data

## Creo una plantilla de un punto en geojson, dejan los valores nombre y coordenada para reemplazar desde la tabla
plantilla <-  '{
  "type": "Feature",
  "properties":
  {
    "venue": _venue,
    "event": _event,
    "date": _date,
    "capacity": _capacity,
    "occupation": _occupation,
    "event_genres": _event_genres,
    "lineup": _lineup,
    "headliner": _headliner,
    "city": _city
  },
  "geometry": {
    "type": "Point",
    "coordinates": [_coordinates]
  }
}'


plantilla <- str_replace(plantilla,"nombre",data$name) # Se reemplaza el nombre en la plantilla
plantilla <- str_replace(plantilla,"coordenada",data$geometry) # Se reemplaza la coordenada en la plantilla


## Función para normalizar los nombres de las agrupaciones de modo que no tengan caracteres raros y los espacios sean reemplazados por guión bajo
normalizarNombre <- function(nombre) {
    nombre <- str_replace_all(nombre,"X","")
    nombre <- str_replace_all(nombre,"[[:punct:]]"," ")
    nombre <- stri_trans_general(nombre, "Any-Lower")
    nombre <- str_replace_all(nombre,"\\s","_")
    nombre <- stri_trans_general(nombre, "latin-ascii")
    nombre
}

## se ajusta el working directory para que se generen los datos en el lugar adecuado
setwd("../../apariciones_proyectos_musicales")

## Se recorren todas las plantillas, se normaliza el nombre y se guardan en el sistema con el nombre de la agrupación más la extensión .geojson
for(i in 1:length(plantilla)) {
    nombre <- normalizarNombre(grupos$headliner[i])
    cat(plantilla[i], file = paste0(nombre,".geojson"))
}

## Para poder editar con geojson.io mirar con detenimiento https://github.com/JasonSanford/gitspatial para hacer consultas sobre esos datos

#############
gs_auth()
gs_ls("Programacion Casateatro El Poblado")
hoja_grupos <- gs_title("Programacion Casateatro El Poblado")
grupos <- hoja_grupos %>% gs_read(ws = "integrados_solo_grupos_musicales")

columnas_plantilla <- c("venue","event","date","capacity","occupation","event_genres","lineup","headliner","city","coordinates")

colnames(grupos)

## El error viene de los NA que se generan al cargar campos vacíos. Principalmente en la columna event_genres
## Se reemplazan los NAs 
grupos$event_genres[which(is.na(grupos$event_genres))] <- ""
grupos$occupation[which(is.na(grupos$occupation))] <- ""

for (i in columnas_plantilla) {
  print(i)
  ifelse(i == "coordinates",  plantilla <- str_replace(plantilla,paste0("_",i),eval(parse(text = paste0("grupos$",i)))),   plantilla <- str_replace(plantilla,paste0("_",i),paste0("\"",eval(parse(text = paste0("grupos$",i))),"\"")))
}

is.na(grupos[,columnas_plantilla]) ## Buscar el documento de tantas realidades ¿cómo pasar de índices en una dimensión a filas y columnas?

## Luego se corre el for de la línea 66 para crear los archivos
