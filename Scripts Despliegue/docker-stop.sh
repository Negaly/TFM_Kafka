#bash script

if [ "x$(which docker)" == "x" ]; then
  echo "UNKNOWN - Missing docker binary"
  exit 3
fi

docker info > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "UNKNOWN - Unable to talk to the docker daemon"
  exit 3
fi

RUNNING=$(docker inspect --format="{{.State.Running}}" zookeeper 2> /dev/null)

if [ "$RUNNING" == "true" ]; then
	docker stop zookeeper
	echo "Zookeeper stoped"
fi

RUNNING=$(docker inspect --format="{{.State.Running}}" kafka 2> /dev/null)

if [ "$RUNNING" == "true" ]; then
	docker stop kafka
	echo "Kafka stoped"
fi

RUNNING=$(docker inspect --format="{{.State.Running}}" schema-registry 2> /dev/null)

if [ "$RUNNING" == "true" ]; then
	docker stop schema-registry
	echo "Schema-registry stoped"
fi


