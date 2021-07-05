FROM python:3.8-buster

# Install dependencies
RUN apt-get update && apt-get install -q -y \
    openjdk-11-jdk \
	 git \
 && pip install rdflib \
 && pip install lxml \
 && pip install requests

# Setup user
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN addgroup --gid $GROUP_ID user \
	&& adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

# Setup UD-Graph
RUN git clone https://github.com/VCityTeam/UD-Graph.git /UD-Graph \
 && cd /UD-Graph \
 && git checkout tags/v1.1.0-alpha
RUN mkdir /inout \
 && chown -R user:user /inout \
 && chown -R user:user /UD-Graph \
 && cp /UD-Graph/Transformations/ShapeChange/CityGML2.0_config.xml / \
 && cp /UD-Graph/Transformations/ShapeChange/CityGML3.0_config.xml / \
 && cp /UD-Graph/Transformations/XML-to-RDF/citygml_2_namespace_mappings.json / \
 && cp /UD-Graph/Transformations/XML-to-RDF/citygml_3_namespace_mappings.json / \
 && rm -rf /UD-Graph/Transformations/test-data

# Setup Entrypoint
USER user
COPY entrypoint.py /UD-Graph/Transformations/entrypoint.py
WORKDIR /UD-Graph/Transformations/
ENTRYPOINT ["python", "entrypoint.py"]
