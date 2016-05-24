var JSV = require("JSV").JSV;
var json = require("./fonseca_geojson.js");
var schema = require("./apariciones_schema.js")
//{"type" : "object"};
var env = JSV.createEnvironment();
var report = env.validate(json, schema);

if (report.errors.length === 0) {
	//JSON is valid against the schema
  console.log("Efectivamente es un geojson")
} else {
  console.log(report.errors);
}
