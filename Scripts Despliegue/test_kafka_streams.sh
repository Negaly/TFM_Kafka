# Create the input topic
./bin/kafka-topics --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic streams-file-input

# Create the output topic
./bin/kafka-topics --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic streams-wordcount-output

echo -e "Prueba Kafka Streams\nVa a contar las letras\nAsi que vamos a escribir mas." > /tmp/file-input.txt

cat /tmp/file-input.txt | ./bin/kafka-console-producer --broker-list localhost:9092 --topic streams-file-input

./bin/kafka-run-class org.apache.kafka.streams.examples.wordcount.WordCountDemo

./bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic streams-wordcount-output --from-beginning --formatter kafka.tools.DefaultMessageFormatter --property print.key=true --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer --property value.deserializer=org.apache.kafka.common.serialization.LongDeserializer
