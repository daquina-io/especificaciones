// Definido de acuerdo a esta información http://stackoverflow.com/questions/17931874/setting-required-on-a-json-schema-array
module.exports =  {
  type : "object",
  properties : {
    "type" : {
      type : "string",
      required : true,
      "enum":["FeatureCollection"]
    },
    "features" : {
      type : "object",
      required : true,
      items : { type : "array", required : true, properties : {
        "type" : { type : "string", required : true, "enum":["Feature"]},
        "properties" : {
          type : "object", properties : {
            "venue" : { type : "string", required : true },
            "event": { type : "string", required : true },
            "date": { type : "Date", required : true},
            "capacity": { type : "number", required : true},
            "occupation": {type : "number", required : true},
            "lineup": {type : "string", required : true},
            "event_genres": {type : "string", required : true},
            "city": {type : "string", required : true},
            "headliner": {type : "string", required : true}
          }
        },
        "geometry" : { type : "object" , properties : {
          "type" : { type : "string", required : true, "enum" : ["Point"]},
          "coordinates" : { type : "array",
                            items : [{type : "number"}, {type : "number"}]}
        }}}}
     }
  }
}
