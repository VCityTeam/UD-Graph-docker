FROM python:3.8-buster

ARG branch=tags/v1.1.0-alpha
ARG mount=/inout

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
RUN git clone --branch ${branch} https://github.com/VCityTeam/UD-Graph.git
RUN rm -rf /UD-Graph/Transformations/test-data \
	/UD-Graph/Datasets \
	/UD-Graph/Ontologies
## Setup Saxon
WORKDIR /UD-Graph/Transformations/lib
RUN wget https://sourceforge.net/projects/saxon/files/Saxon-HE/9.9/SaxonHE9-9-1-8J.zip/download
RUN unzip download \
 && rm -rf download

# Setup Entrypoint and user permissions
RUN mkdir ${mount} \
 && chown -R user:user ${mount} \
 && chown -R user:user /UD-Graph
USER user
COPY entrypoint.py /UD-Graph/Transformations/entrypoint.py
WORKDIR /UD-Graph/Transformations/
ENTRYPOINT ["python", "entrypoint.py"]
