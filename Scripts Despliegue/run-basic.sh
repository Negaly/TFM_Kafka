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

