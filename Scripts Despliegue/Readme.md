This files refer to script for launching and stopping kafka basic services during all the test developed during the project.

Kafka Basic
  run-basic.sh
    Inicialmente el script de ejecución será en local por lo que usaremos Gnome-terminal para abrir en un terminal distinto cada uno de los sistemas, inicialmente configuraremos el directorio de forma estática apuntando a la instalación donde hayamos descargado Confluent.
    CONFLUENT_DIRECTORY='/TFM/confluent-3.2.0' #Cambiar 
    cd $CONFLUENT_DIRECTORY;pwd

    gnome-terminal --title="Zookeeper" -e "sudo $CONFLUENT_DIRECTORY/bin/zookeeper-server-start $CONFLUENT_DIRECTORY/etc/kafka/zookeeper.properties"
    #./bin/zookeeper-server-start ./etc/kafka/zookeeper.properties
    sleep 30s
    gnome-terminal --title="kafka" -e "sudo $CONFLUENT_DIRECTORY/bin/kafka-server-start $CONFLUENT_DIRECTORY/etc/kafka/server.properties"
    #./bin/kafka-server-start ./etc/kafka/server.properties
    sleep 30s
    gnome-terminal --title="schema Registry" -e "sudo $CONFLUENT_DIRECTORY/bin/schema-registry-start $CONFLUENT_DIRECTORY/etc/schema-registry/schema-registry.properties"
    #./bin/schema-registry-start ./etc/schema-registry/schema-registry.properties

    Este script arranca con lapsos de 30 segundos los servicios de Zookeeper, Kafka y el Schema Registry, además del uso del Gnome-Terminal para poder ejecutar en múltiples terminales, el otro punto más crítico de este script es que es imprescindible arrancar los servicios en el orden indicado, ya que Kafka necesita notificar a Zookeeper que se ha levantado el servicio y el Schema Registry necesita notificar a Kafka para que sepa el puerto y la IP de dicho servicio.

Kafka Streams
  test_kafka_streams.sh
      Script para lanzar la prueba básica de kafka streams con el contador de palabras e imprimir el resultado de manera automática.
Control center
  totail.sh
    Script básico para crear lineas de datos en un fichero de texto.

Docker:
  This scripts helps to launch the basic system with docker. If its the first time you should also download docker images through docker-install.sh.
    bash docker-install.sh zookeeper/Kafka/schema-registry
    bash docker-launch.sh zookeeper/Kafka/schema-registry
    bash docker-stop.sh
