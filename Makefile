create-network:
	@docker network create docker || true > /dev/null

build:
	docker run -v ~/.m2:/root/.m2 -v ${PWD}:/usr/src  -w /usr/src  maven:3-jdk-8 mvn clean package -DskipTests
	docker build -t mymvn .
	docker build -t db -f Dockerfile.mysql .

run:
	docker rm -f db || true
	docker run -it --rm -d --name db --net docker db
	docker rm -f mymvn || true
	docker run -it --rm -p 8080:8080 --name mymvn -d --net docker mymvn

run-external:
	docker rm -f db || true
	docker rm -f db || true
	docker run -it --rm -d --name db --net docker db
	docker rm -f mymvn || true
	docker run -it -d --rm -p 8080:8080 --name docker -e SPRING_CONFIG_LOCATION=/etc/app/config/ -v ${PWD}/config:/etc/app/config/ --net docker mymvn

