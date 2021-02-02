FROM python:3.8-buster

# Install dependencies
RUN apt-get update && apt-get install -q -y \
	openjdk-11-jdk \
	git \
	&& pip install rdflib \
	&& pip install lxml

# Clone UD-Graph
RUN git clone https://github.com/VCityTeam/UD-Graph.git \
	&& cd UD-Graph \
	&& git checkout tags/v1.0


# Setup entrypoint
COPY entrypoint.py /UD-Graph/Transformations/entrypoint.py
RUN chmod u+x /UD-Graph/Transformations/entrypoint.py

WORKDIR /UD-Graph/Transformations/
ENTRYPOINT ["python", "entrypoint.py"]
