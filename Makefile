IMAGE=sillycat/public
TAG=raspberrypi-openresty
NAME=raspberrypi-openresty

app-build:
	rm -fr install
	mkdir install
	wget https://openresty.org/download/openresty-1.11.2.3.tar.gz -P install/
	wget http://luarocks.github.io/luarocks/releases/luarocks-2.4.2.tar.gz -P install/
	./package.sh
	tar -cvzf ./dist/$(NAME)-1.0.tgz ./dist/luaweb

docker-context:

build: docker-context
	docker build -t $(IMAGE):$(TAG) .

run:
	docker run -d -p 80:80 --name $(NAME) $(IMAGE):$(TAG)

debug:
	docker run -ti -p 80:80 --name $(NAME) $(IMAGE):$(TAG) /bin/bash

clean:
	docker stop ${NAME}
	docker rm ${NAME}

logs:
	docker logs ${NAME}

publish:
	docker push ${IMAGE}:${TAG}

fetch:
	docker pull ${IMAGE}:${TAG}
