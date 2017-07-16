#bash script

#CONTAINER=zookeeper

CONTAINER=$1

echo $CONTAINER
if [ "x${CONTAINER}" == "x" ]; then
  echo "UNKNOWN - Container ID or Friendly Name Required"
  exit 3
fi

if [ "x$(which docker)" == "x" ]; then
  echo "UNKNOWN - Missing docker binary"
  exit 3
fi

docker info > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "UNKNOWN - Unable to talk to the docker daemon"
  exit 3
fi

RUNNING=$(docker inspect --format="{{.State.Running}}" $CONTAINER 2> /dev/null)

#if [ $? -eq 1 ]; then
#  echo "UNKNOWN - $CONTAINER does not exist."
#  exit 3
#fi

if [ "$RUNNING" != "true" ]; then
	echo "Running container: $CONTAINER"
	if [ "$CONTAINER" == "zookeeper" ]; then
		docker run -d --net=host --name=zookeeper -e ZOOKEEPER_CLIENT_PORT=32181 confluentinc/cp-zookeeper:3.2.1
		sleep 30s
		docker logs zookeeper
	fi
	if [ "$CONTAINER" == "kafka" ]; then
		docker run -d --net=host --name=kafka -e KAFKA_ZOOKEEPER_CONNECT=localhost:32181 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:29092 confluentinc/cp-kafka:3.2.1
		sleep 30s
		docker logs kafka
	fi
	if [ "$CONTAINER" == "schema-registry" ]; then
		docker run -d --net=host --name=schema-registry -e SCHEMA_REGISTRY_KAFKASTORE_CONNECTION_URL=localhost:32181 -e SCHEMA_REGISTRY_HOST_NAME=localhost -e SCHEMA_REGISTRY_LISTENERS=http://localhost:8081 confluentinc/cp-schema-registry:3.2.1
		sleep 30s
		docker logs schema-registry
	fi
	echo "$CONTAINER is running"
	exit 0
fi

RESTARTING=$(docker inspect --format="{{.State.Restarting}}" $CONTAINER)

if [ "$RESTARTING" == "true" ]; then
  echo "WARNING - $CONTAINER state is restarting."
  exit 1
fi

STARTED=$(docker inspect --format="{{.State.StartedAt}}" $CONTAINER)
NETWORK=$(docker inspect --format="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $CONTAINER)

echo "OK - $CONTAINER is running. IP: $NETWORK, StartedAt: $STARTED"
