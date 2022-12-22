# UD-Graph-docker
Docker context for UD-Graph functionalities 

## To build image
```
git clone https://github.com/VCityTeam/UD-Graph-docker.git
docker build -t liris/ud-graph ./UD-Graph-docker/
```

## How to run UD-Graph-docker
To use UD-Graph-docker run the container using the following docker run command pattern. Note that a local folder should be mounted to `/inout` to send/receive files to/from the container:
```
docker run --rm -v [path to a local folder]:/inout liris/ud-graph [shapechange|xml2rdf|xsd2owl] [command args**]
```
**Tip:** use `$(pwd)` to select the current working directory when mounting a volume. See [docker documentation](https://docs.docker.com/engine/reference/commandline/run/#mount-volume--v---read-only) for more information
**Tip:** use the `--rm` flag to remove the container after use. Most UD-Graph-docker transformations only need to be used once. This will avoid cluttering your docker environment.

To display general usage information: 
```
docker run --rm liris/ud-graph [-h|--help]
```
You can also view more detailed information on a specific function
```
docker run --rm liris/ud-graph [shapechange|xml2rdf|xsd2owl] [-h|--help]
```

### How to use the ShapeChange function
This function uses [ShapeChange](https://shapechange.net/) to transform a UML model into an OWL ontology according to a configuration file 

For general usage:
```
docker run --rm -v $(pwd):/inout liris/ud-graph shapechange [input configuration file]
```

Two example ShapeChange configuration files for transforming the CityGML 2.0 and 3.0 models as XMI files are available within the container and can be accessed with the following commands:
```
docker run --rm -v $(pwd):/inout liris/ud-graph shapechange ../CityGML2.0_config.xml --input [input UML model as XMI]
```
```
docker run --rm -v $(pwd):/inout liris/ud-graph shapechange ../CityGML3.0_config.xml --input [input UML model as XMI]
```

When constructing ShapeChange configuration files for use within UD-Graph-docker, the `/inout` folder must be specifed when declaring input and output directories, for example:
```xml
<input>
   <parameter name="inputFile" value="/inout/[input UML file]"/>
   ...
</input>
...
<targets>
  <target>
    <targetParameter name="outputDirectory" value="/inout/"/>
    ...
  </target>
</targets>
```
Optionally, the variables `$input$` and `$output$` can be used to specify the input UML model filename and output directory, for example:
```xml
<input>
  <parameter name="inputFile" value="$input$"/>
   ...
</input>
...
<targets>
  <target>
    <targetParameter name="outputDirectory" value="$output$"/>
    ...
  </target>
</targets>
```
This will enable the `--input` parameter to be used within UD-Graph-docker as shown above.

See the [documentation from UD-Graph](https://github.com/VCityTeam/UD-Graph/tree/master/Transformations/ShapeChange) for more information

### How to use the XML-to-RDF function
This function transforms CityGML XML files into RDF triples. It takes in 3 arguments, an input CityGML file to transform, an OWL ontology(ies) that model the XML data as RDF, and a namespace mapping file which links the XML namespaces to the ontology namespaces.

For general usage:
```
docker run --rm -v $(pwd):/inout liris/ud-graph xml2rdf [CityGML file] [ontology|directory containing ontologies] [namespace mapping file]
```
UD-Graph-docker provides two namespace mapping files for use with the CityGML Ontologies created by ShapeChange and the XSD-to-OWL transformation. These namespace files can be used with the following commands: 
```
docker run --rm -v $(pwd):/inout liris/ud-graph xml2rdf [CityGML file] [ontology|directory containing ontologies] ../citygml_2_namespace_mappings.json
```
```
docker run --rm -v $(pwd):/inout liris/ud-graph xml2rdf [CityGML file] [ontology|directory containing ontologies] ../citygml_3_namespace_mappings.json
```

See the [documentation from UD-Graph](https://github.com/VCityTeam/UD-Graph/tree/master/Transformations/XML-to-RDF) for more information

### How to use the XSD-to-OWL function
This function transforms a CityGML XML Schema file into an OWL ontology. It takes an input XSD file.

For general usage:
```
docker run --rm -v $(pwd):/inout liris/ud-graph xsd2owl [XSD file]
```

See the [documentation from UD-Graph](https://github.com/VCityTeam/UD-Graph/tree/master/Transformations/XSD-to-OWL) for more information
