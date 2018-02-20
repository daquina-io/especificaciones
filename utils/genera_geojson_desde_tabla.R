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
crearPlantilla <- function(){
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
},'
}


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

## Se recorren todas las plantillas, se normaliza el nombre y se guardan en el sistema con el nombre de la agrupación más la extensión .geojson ## se agrega el numero de iteración al nombre, para prevenir que se sobreescriba un grupo que tiene dos o mas apariciones ## TODO: encontrar una mejor manera de integrar múltiples apariciones de el mismo grupo
## brolin? puedo volver esto una función?
  for(i in 1:length(plantilla)) {
    nombre <- normalizarNombre(grupos$headliner[i])
    cat(plantilla[i], file = paste0(nombre,".geojson"))
  }


## Para poder editar con geojson.io mirar con detenimiento https://github.com/JasonSanford/gitspatial para hacer consultas sobre esos datos

########################################################################################################
########################################################################################################
############# Crear geoJson a partir de hoja de google sheets
require(RCurl) ## paquete interfaz para curl
require(stringr) ## paquete para manipulación de strings
require(stringi) ## paquete para manipulación de strings
require(dplyr)
require(googlesheets)

gs_auth()
gs_ls("apariciones")
hoja_grupos <- gs_title("apariciones")
grupos <- hoja_grupos %>% gs_read(ws = "krakenvivi")

columnas_plantilla <- colnames(grupos)

## El error viene de los NA que se generan al cargar campos vacíos. Principalmente en la columna event_genres
## Se reemplazan los NAs 
grupos$event_genres[which(is.na(grupos$event_genres))] <- ""
grupos$occupation[which(is.na(grupos$occupation))] <- ""

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

for (i in columnas_plantilla) {
  print(i)
  ifelse(i == "coordinates",  plantilla <- str_replace(plantilla,paste0("_",i),eval(parse(text = paste0("grupos$",i)))),   plantilla <- str_replace(plantilla,paste0("_",i),paste0("\"",eval(parse(text = paste0("grupos$",i))),"\"")))
  
}

plantilla <- data.frame(plantilla, grupos$headliner)
colnames(plantilla) <- c("plantilla","nombre")

grupos_unicos <- unique(plantilla$nombre)

plantilla_list <- lapply(grupos_unicos, function(aparicion) { 
  plantilla %>% filter(nombre == aparicion) 
})

## Se recorren todas las plantillas, se normaliza el nombre y se guardan en el sistema con el nombre de la agrupación más la extensión .geojson ## se agrega el numero de iteración al nombre, para prevenir que se sobreescriba un grupo que tiene dos o mas apariciones ## TODO: encontrar una mejor manera de integrar múltiples apariciones de el mismo grupo
## brolin? puedo volver esto una función?
header <- '{
  "type": "FeatureCollection",
  "features": ['

footer <- ']
}'

lapply(plantilla_list, function(grupo) {
  nombre <- unique(grupo[[2]])
  mapa <- paste0(grupo[[1]][1:length(grupo[[1]])], collapse = ",")
  cat(paste0(header,mapa,footer), file = paste0(nombre,".geojson"))
})

getwd()

names(plantilla)



## funciones
crearPlantilla
normalizarNombre
crearArchivos



## brolin?
is.na(grupos[,columnas_plantilla]) ## Buscar el documento de tantas realidades ¿cómo pasar de índices en una dimensión a filas y columnas?


######################
################### intento extraer los grupos del campo lineup
row <- c(grupos)
lineups <- grupos$lineup 
## 
s <-  c(lineups[69])
split1 <- c(strsplit(lineups,","))
ed <- c(split)


## aquí vamos 
lapply(seq_along(split1), function(x){rbind(split1[[x]])})

## un lapply recorre todo split, otro anidado recorre cada split
row1 <- lapply(split1, function(x){
  paste0(x, " foo")
})

 lapply(row1, function(x){paste0(row1[[1]], toupper(x))})

## pueden ser dos lapply separados 

paste0(split, "xx")
## intento split 
dan <- split(grupos, grupos$lineup)

## test
corpus <- list("a","b","c",list("foo","bar","pande", "hum"))

lapply(corpus, function(x){
  
})

