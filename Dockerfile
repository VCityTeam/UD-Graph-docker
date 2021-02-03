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
USER user

# Setup UD-Graph
RUN git clone https://github.com/VCityTeam/UD-Graph.git /home/user/UD-Graph \
	&& cd /home/user/UD-Graph \
	&& git checkout tags/v1.0.0-alpha

# Setup entrypoint
COPY entrypoint.py /entrypoint.py
RUN cp /entrypoint.py /home/user/UD-Graph/Transformations/entrypoint.py

WORKDIR /home/user/UD-Graph/Transformations/
ENTRYPOINT ["python", "entrypoint.py"]
