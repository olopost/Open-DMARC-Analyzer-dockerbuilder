VERSION=0.7
WEB=dmark.local.meyn.fr
.PHONY: serve


install:
	git clone https://github.com/userjack6880/Open-DMARC-Analyzer.git code
	git clone git@github.com:techsneeze/dmarcts-report-parser.git parser
	echo "Please edit code/config.php.pub to appropriate value"
	echo "Please edit parser/dmarcts-report-parser.conf to appropriate value"
	echo "please put your dmark email in dmark folder"

serve:
	docker run -d \
	--net mynet \
	-l 'traefik.enable=true' \
	-l 'traefik.http.routers.dmark.entrypoints=web,websecure' \
	-l 'traefik.http.routers.dmark.rule=Host("$(WEB)")' \
	-l 'traefik.http.routers.dmark.tls=true' \
	-l 'traefik.http.routers.dmark.tls.certresolver=lets-encrypt' \
	-l 'traefik.port=80' \
	--name dmark dmark:$(VERSION)
	docker exec dmark /opt/parser/dmarcts-report-parser.pl -i

force-update:
	docker exec dmark /opt/parser/dmarcts-report-parser.pl -i

build:
	docker build -t dmark:$(VERSION) .

stop:
	docker stop dmark
	docker rm dmark

db:
	docker run --name mysql --net mynet -h mysql -v db:/etc/mysql/conf.d \
	-e MYSQL_DATABASE=dmarc \
	-e MYSQL_ROOT_PASSWORD=root -d mysql:8.3.0

dbstop:
	docker stop mysql
	docker rm mysql

init:
	docker exec -i mysql sh -c 'exec mysql  -uroot -proot' < code/install.php