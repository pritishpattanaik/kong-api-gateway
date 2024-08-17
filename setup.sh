#!/bin/bash 

# this setup program is written to simply the kong oss gateway installation for kong platform
# this is a hacky way to install the kong oss gateway using docker

# make sure you have docker installed 


# Define color codes
GREEN="\033[1;32m"
RESET="\033[0m"
BOLD="\033[1m"

usage() {
	echo "usage: ./setup.sh --mode <dbless or db or hybrid>>"
}


if [ "$#" -lt 1 ]; then
    usage
    exit 1
fi

check_docker() {

	if [  "$(docker --version)" ]; then
		echo "docker is installed: $(docker --version)"
	else
		echo "docker is not installed, please install docker and run this script again"
		exit 0
	fi

}

# handle arguments --mode <string>
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    --mode)
    mode="$2"
    shift
    shift
    ;;
    *)
    echo "unknown option: $key"
    usage
    exit 1
    ;;
esac
done

install_db() {
	echo "installing kong with db mode"
	rm -rf db/*
	mkdir -p db
	mkdir -p db/config
        echo "kongkong" > ./db/POSTGRES_PASSWORD
	echo "# a very minimal declarative config file" > ./dbless/config/kong.yaml
	echo '_format_version: "2.1"' >> ./dbless/config/kong.yaml
	echo "_transform: true" >> ./dbless/config/kong.yaml
	KONG_DATABASE=postgres docker compose --profile database up -d


	sleep 20
        docker compose ps
        # if no container running kong
        if [[ $(docker compose ps | grep kong) == "" ]]; then
                echo "kong dbless failed to start... check docker logs"
                docker compose logs
                exit 0
        fi
        

        # Display styled messages
        echo -e "${GREEN}${BOLD}------------- Kong DB-less Installed ---------------------${RESET}"

        # Run the curl command
        curl -I http://localhost:8001/status

        # Display more styled messages
        echo -e "${GREEN}Kong is running with ports 8001(admin-api) and 8000(proxy)${RESET}"

}

install_dbless() {
	echo "installing kong with dbless mode"
	rm -rf dbless/*
	mkdir -p dbless 
	mkdir -p dbless/config

	
	cd dbless
		
	cp ../docker-compose-dbless.yaml docker-compose.yaml
	docker compose up -d
	sleep 20
	docker compose ps
	# if no container running kong
	if [[ $(docker compose ps | grep kong) == "" ]]; then
		echo "kong dbless failed to start... check docker logs"
		docker compose logs
		exit 0
	fi


	# Display styled messages
	echo -e "${GREEN}${BOLD}------------- Kong DB-less Installed ---------------------${RESET}"

	# Run the curl command
	curl -I http://localhost:8001/status

	# Display more styled messages
	echo -e "${GREEN}Kong is running with ports 8001(admin-api) and 8000(proxy)${RESET}"
}


check_docker
echo $mode

if [[ $mode == "dbless" ]]; then
	install_dbless
elif [[ $mode == "db" ]]; then
	echo "install_db"
	install_db
elif [[ $mode == "hybrid" ]]; then
	echo install_hybrid
else
	echo "unknown mode: $mode"
	usage
	exit 1
fi
