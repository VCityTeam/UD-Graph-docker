# UD-Graph-docker
Docker context for UD-Graph functionalities 

## To build image
```
git clone git://github.com/VCityTeam/UD-Graph-docker/
docker build -t liris:ud-graph ./UD-Graph-docker/
```

## How to run UD-Graph-docker
To use UD-Graph-docker run the container using the following docker run command pattern. Note that a local folder should be mounted to `/inout` to send/receive files to/from the container:
```
docker run --name [container name] -v [path to a local folder]:/inout liris:ud-graph [shapechange|xml2rdf|xsd2owl] [command args**]
```
**Tip:** use `$(pwd)` to select the current working directory when mounting a volume.

To display general usage information: 
```
docker run --rm liris:ud-graph [-h|--help]
```
You can also view more detailed information on a specific function
```
docker run --rm liris:ud-graph [shapechange|xml2rdf|xsd2owl] [-h|--help]
```

### How to use the ShapeChange function
This function uses [ShapeChange](https://shapechange.net/) to transform a UML model into an OWL ontology.

Two example ShapeChange configuration files for transforming the CityGML 2.0 and 3.0 models as XMI files are available within the container and can be accessed with the following commands:
```
docker run --name ud-graph1 -v $(pwd)/:/inout liris:ud-graph shapechange --config CityGML2.0_config.xml --input /inout/[input UML model as XMI]
```
```
docker run --name ud-graph1 -v $(pwd)/:/inout liris:ud-graph shapechange --config CityGML3.0_config.xml --input /inout/[input UML model as XMI]
```

When constructing ShapeChange configuration files for UD-Graph-docker, the `/inout` folder must be specifed when declaring input and output directories, for example:
```
<parameter name="inputFile" value="/inout/[input UML file]"/>
...
<targetParameter name="outputDirectory" value="/inout/"/>
```
Optionally, the variable `$input$` can be used to specify the input UML model filename, for example:
```
<parameter name="inputFile" value="$input$"/>
```
This will enable the `--input` parameter to be used within UD-Graph-docker as shown above.

