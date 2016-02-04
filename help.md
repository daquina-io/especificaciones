Instrucciones para contribuir con el ingreso de datos de apariciones de grupos:

* Cree una cuenta en https://github.com/

* Haga fork a este repositorio https://github.com/daquina-io/apariciones_proyectos_musicales

* Cada que vaya a empezar a hacer ingresos haga ```pull request``` , si no hay nada que comparar cambie la base de comparación aprentando el link del texto ``` Try switching the base for your comparison.```

* Abra la página http://geojson.io/ y haga login con su cuenta usuario y clave de GitHub

* Una vez logueado apreta en ```File``` / ```GitHub``` y abre el grupo al que le quiere agregar apariciones


* Para direcciones desconociddas puede abrir el mapa de google y hace click  derecho en el punto seleccionado, luego apreta en ```What is here?``` copia las coordenadas, es necesario invertirlas al pegarlas en el mapa de geoJson.

* Si el artista ya tienen ingresos puede agregar los datos a travez de la tabla, si no los tiene o estan incompletos puede copiar lo que hay dentro de Properties{ } en este ejemplo : https://github.com/daquina-io/apariciones_abiertas/blob/master/especificaciones.md#ejemplo

* Cuando ya existe el artista hace simplemente ```save```  (no hace ```save```[GitHub])

* Si sale error va al panel de JSON y hace Ctrl-A para seleccionar todo Ctrl-C para copiarlo luego hace [Refresh], luego hace Ctrol-A para seleccionar todo y Ctrol-V para reemplazar los valores por lo que hay en el portapapeles.

* Si el artista no esta con algún ingreso hace [new]  mete el globito, le pone las propiedades y OJO al salvar por primera ves
hace ```Save```[GitHub] y abre su lista y abajo apreta en ```+New File```  OJO la extensión debe ser ```.geojson```  ejemplo: ```pedrito_perez.geojson```



*  Los campos obligados son: **venue**, **date**, **capacity**, **city**.

 * El campo _occupation_ se pone en porcentaje, ej: 100 lleno, 90 casi lleno, 50 a la mitad, 10 muy poca gente para el sitio.
