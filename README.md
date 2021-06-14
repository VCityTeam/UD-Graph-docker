# UD-Graph-docker
Docker context for UD-Graph functionalities 

## To build image
```
git clone git://github.com/VCityTeam/UD-Graph-docker/
docker build -t liris:ud-graph ./UD-Graph-docker/
```

## To execute a transformation
For usage information: 
```
docker run --rm liris:ud-graph [-h|--help]
```
You can also view information on a specific functions
```
docker run --rm liris:ud-graph [shapechange|xsd2owl|xml2rdf] [-h|--help]
```

General usage:
```
docker run -v [path to a local folder]:[path to mount folder in container] liris:ud-graph [entrypoint_arguments**]
```

For example to launch a shapechange transformation with a configuration file:
```
docker run -v $(pwd)/data:/data liris:ud-graph shapechange --config /data/shapechange_config.xml
```

## Tips!
* Many UD-Graph calculations are run once and do not need to be re-run. Remember to use the `--rm` flag to automatically remove the container after use and avoid polluting your Docker environment.
* UD-Graph transformations often require mounting a volume for file input and output as shown in the example above.
* When using a custom shapechange configuration file, be sure to specify the output directory as the mounted drive, for example:
```
<targetParameter name="outputDirectory" value="/data-io/output/"/>
```
or you can use variables _"$input$"_ and _"$output$"_ which will be replaced by the endpoint script
```
<targetParameter name="outputDirectory" value="$input$"/>
```
