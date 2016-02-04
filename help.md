Hacer fork a este repositorio https://github.com/son0p/apariciones_proyectos_musicales

Abrir la página http://geojson.io/ y logearte con tu cuenta de github

Una vez logueado apreta en ```File``` / ```GitHub``` y abre el grupo al que le quiere agregar apariciones


Para direcciones desconociddas mapas de google y apretas en What is here? copias las coordenadas  y toca invertirlas en el JSON

Si el artista ya tienen ingresos pueddes ingresar los datos a travez de la tabla, si no los tiene o estan incompletos puedes copiar lo que hay dentro de Properties{ } de una entrada reciente como fonseca

Cuando ya existe el artista haces simplemente ```save```  (no haces ```save```[GitHub])

Si sale error vas a JSON y haces Ctrl-A para seleccionar todo Ctrl-C para copiarlo luego haces [Refresh] y haces Ctrol-A para seleccionar todo y Ctrol-V para reemplazar los valores por lo que hay en el portapapeles.

Si el artista no esta con algún ingreso haces [new]  metes el globito, le pones las propiedades y OJO al salvar por primera ves 
haces ```Save```[GitHub] y abres tu lista y abajo apretas en ```+New File```  OJO la extensión debe ser ```.geojson```  ejemplo: ```pedrito_perez.geojson```

## Datos 
en el campo Propierties del JSON van los siguientes campos

```json
"properties":
{
  "venue": "Parque Simon Bolivar",
   "event": "Rock al Parque 1997",
   "date": "1997-05-30",
   "capacity": 30000,
   "occupation": 100,
   "lineup":"grupos que participaron separados por coma",
    "added_by": "son0p",
   "founder": "Opcional: Quien puso el dinero",
   "headliner": "Fonseca",
    "city": "Managua"
  } 
  
  ```
  Los campos obligados son: **venue**, **date**, **capacity**, **city**.
  
  El campo _occupation_ se pone en porcentaje, ej: 100 lleno, 90 casi lleno, 50 a la mitad, 10 muy poca gente para el sitio.
