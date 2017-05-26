IMAGE=sillycat/public
TAG=raspberrypi-django
NAME=raspberrypi-django

app-build:
	rm -fr install/*	
	wget --no-check-certificate https://github.com/luohuazju/myconsole/archive/master.tar.gz -P install/

docker-context:

build: docker-context
	docker build -t $(IMAGE):$(TAG) .

run:
	docker run -d -p 8000:8000 --name $(NAME) $(IMAGE):$(TAG)

debug:
	docker run -ti -p 8000:8000 --name $(NAME) $(IMAGE):$(TAG) /bin/bash

clean:
	docker stop ${NAME}
	docker rm ${NAME}

logs:
	docker logs ${NAME}

publish:
	docker push ${IMAGE}:${TAG}

fetch:
	docker pull ${IMAGE}:${TAG}
