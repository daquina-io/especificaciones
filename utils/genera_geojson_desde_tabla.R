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
    "coordinates": _coordinates
  }
}'

columnas_plantilla <- c("venue","event","date","capacity","occupation","event_genres","lineup","headliner","city","coordinates")

plantilla <- str_replace(plantilla,"nombre",data$name) # Se reemplaza el nombre en la plantilla
plantilla <- str_replace(plantilla,"coordenada",data$geometry) # Se reemplaza la coordenada en la plantilla


plantilla <- str_replace(plantilla,"coordenada",grupos$venue) # Se reemplaza la coordenada en la plantilla
i <- "venue"

colnames(grupos)

for (i in columnas_plantilla) {
  print(i)
  plantilla <- str_replace(plantilla,i,eval(parse(text = paste0("grupos$",i))))
}

## Función para normalizar los nombres de las agrupaciones de modo que no tengan caracteres raros y los espacios sean reemplazados por guión bajo
normalizarNombre <- function(nombre) {
    nombre <- str_replace_all(nombre,"X","")
    nombre <- str_replace_all(nombre,"[[:punct:]]"," ")
    nombre <- stri_trans_general(nombre, "Any-Lower")
    nombre <- str_replace_all(nombre,"\\s","_")
    nombre <- stri_trans_general(nombre, "latin-ascii")
    nombre
}

## Se recorren todas las plantillas, se normaliza el nombre y se guardan en el sistema con el nombre de la agrupación más la extensión .geojson
for(i in 1:length(plantilla)) {
    nombre <- normalizarNombre(data$name[i])
    cat(plantilla[i], file = paste0("mapasGrupos/",nombre,".geojson"))
}

## Para poder editar con geojson.io mirar con detenimiento https://github.com/JasonSanford/gitspatial para hacer consultas sobre esos datos
