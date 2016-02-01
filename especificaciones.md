This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.


# Especificaciones del Sistema Abierto de Apariciones en el Territorio (Apariciones Abiertas) v.01
copiado y adaptado de https://docs.google.com/document/d/1KF8KAio-SqGHhh9oFY_KjfwIi3PePOHg7KfTSPh27fc/edit

## Introducción
Las especificaciones del Sistema Abierto de Apariciones en el Territorio entrega una manera uniforme de “formato de intercambio” para publicar datos consumibles por máquinas que cubra el alcance, atributos y sea usado por el sector cultural.
Para los propósitos de estas especificaciones, “apariciones” se definen como un acto público verificable donde se exhibe una propuesta cultural.

Todas las entidades que acogen actos culturales, así como entidades que consumen o distribuyen información de actos culturales están invitadas a publicar los aspectos públicos de sus datos en este formato.

El principal caso de uso de Apariciones Abiertas es proveer estadísticas del sector para la construcción de estrategias que permitan la supervivencia de los proyectos culturales.

Agrupaciones, managers, estrategas, funcionarios públicos, investigadores, se enfrentan a la dificultad de obtener y usar los datos de las apariciones en el territorio de proyectos culturales.

Un creciente número de aplicaciones de software, API’s podrían consumir publicados en el formato AparicionesAbiertas, sirviendo tanto a visitantes, como agencias y organizaciones aliadas.

El desarrollo de AparicionesAbiertas hasta el momento ha sido financiado por Dáquina, En Escena con contribuciones de datos de Casa Teatro, Casa de las estrategias, Medellín vive la Música y diversas agrupaciones culturales.

### Sección 1
#### Acerca de AparicionesAbiertas

##### Las metas de AparicionesAbiertas
El desarrollo, promoción y adopción de esta especificación esta orientada a buscar unas metas específicas trazadas por investigadores del sector cultural, entidades gubernamentales, managers, estrategas, y individuos del sector cultural.
* Facilitar el acceso ciudadano a datos del sector cultural.
* Impulsar y apoyar el continuo desarrollo de capacidades técnicas que apunten a construir hábitos de datos abiertos que han traído tantos beneficios a nuestra comunidad.
* Aportar herramientas para facilitar la publicación de investigaciones reproducibles y verificables en el sector cultural.
* Apoyar la mision de http://datosabiertoscolombia.cloudapp.net/
* Habilitar a terceros toda clase de acceso y uso de información precisa para crear aplicaciones que sirvan al interés público, y promuevan
* Proveer una alternativa de análisis a las estadísticas de popularidad en las redes sociales.
* Ayudar a mejorar las decisiones de los agentes culturales.

#### Mirada inical a las especificaciones

Para el propósito de esta especificación "Aparicion" es definida como un acto público de una propuesta cultural, "AparicionesAbiertas" entrega datos relacionados con el territorio, capacidad de asistentes, fecha etc.

* ***date*** _Requerido_ Usamos el formato AAAA-MM-DD HH:MM:SS para contemplar la posibilidad en la que un proyecto cultural se presente mas de una vez en el mismo día.
* ***venue*** _Requerido_ Usamos el nombre del sitio del evento, la combinación de ese nombre con la ciudad nos debe permitir identificar el sitio de la presentación.
* ***capacity*** Se describe como la cantidad de personas que caben en el sitio del evento (venue), se debe esribir como un número entero.
* ***occupation*** _Opcional_ Este valor se pone en la forma de un numero entero que representa un porcentaje, no puede ser mayor a cien, tampoco negativo, 100 quiere decir que el sitio estaba lleno, 90 casi lleno, 50 a la mitad, 10 muy poca gente.
* ***city*** _Requerido_
* ***coordinates*** _Requerido_ Hacen parte de la localización en el territorio que hace geoJson.

Ejemplo:

```json
{
  "type": "Feature",
  "properties":
  {
    "venue": "Parque Simon Bolivar",
    "event": "Rock al Parque 1997",
    "date": "1997-05-30 22:00:00",
    "capacity": 30000,
    "occupation": 100,
    "lineup":"grupos que participaron separados por coma",
    "founder": "Opcional: Quien puso el dinero",
    "headliner": "todos_tus_muertos",
    "city": "bogota"
  },
  "geometry": {
    "type": "Point",
    "coordinates": [
        -74.09070253372192,
      4.660346097326611
    ]
  }
}

  ```
