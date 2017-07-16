# TFM_Kafka
Este proyecto incluye los códigos utilizados para realizar el análisis de Kafka

# Instalación y descarga de la plataforma
http://docs.confluent.io/current/installation.html#installation

# Módulos auxiliares
* JSON DATA GENERATOR

git clone https://github.com/acesinc/json-data-generator

* DOCKER-HIVE

git clone https://github.com/big-data-europe/docker-hive; cd docker-hive;

docker-compose build

docker-compose up -d namenode hive-metastore-postgresql

docker-compose up -d datanode hive-metastore

docker-compose up -d hive-server


* DOCKER-HADOOP

    sudo apt install docker.io
    sudo docker pull sequenceiq/hadoop-docker:2.4.1
