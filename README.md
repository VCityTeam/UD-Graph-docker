# UD-Graph-docker
Docker context for UD-Graph functionalities 

## To build image
```
docker build -t liris/ud-graph . 
```

## To execute a transformation
For detailed usage information: 
```
docker run liris/ud-graph -rm [-h|--help]
```

General usage:
```
docker run -v [path to external mounted volume]:[path to internal mounted volume] liris/ud-graph [entrypoint_args**]
```

For example to launch a shapechange transformation with a configuration file:
```
docker run -v $(pwd)/data:/data liris/ud-graph uml2owl --config /data/shapechange_config.xml --input /data/uml_model.xml --output /data
```

## Tips!
* Many UD-Graph calculations are run once and do not need to be re-run. Remember to use the `--rm` flag to automatically remove the container after use and avoid polluting your Docker environment.
* UD-Graph transformations often require mounting a volume for file input and output as shown in the example above.
* When using a custom shapechange configuration file, be sure to specify the output directory as the mounted drive, for example:
```
<targetParameter name="outputDirectory" value="/data-io/output/"/>
