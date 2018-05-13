#!/bin/bash
#auther:killesk
#date:2018-04-29
#purpose:This should start the server and load up the database for open transport

#Maven should be installed

#------------------------------ Global Project Variables -------------------------------#

var_project_name=opentransportation_db_data
var_project_location=/home/killesk/workspace/opentransportationserver
var_project_docker_version=18

#--------------------------------- Dovker Variables ------------------------------------#

var_docker_name_mysql=opentransportation_mysql


#---------------------------------- MYSQL Variables ------------------------------------#

var_mysql_version=5.7
var_mysql_root_password=opentransportation_db_root_password
var_mysql_database=opentransportation_db
var_mysql_user=opentransportation_dbuser
var_mysql_password=opentransportation_dbpassword
var_mysql_port=3306
var_mysql_data_dump_file_name=db_dump.sql


#-------------------------------------- Methods ----------------------------------------#

function start() {
  startDatabase
}

function stop() {
  printf "Stopping server\n"
  docker stop $var_docker_name_mysql
  docker rm $var_docker_name_mysql
}

function restart() {
  stop
  start
}

function_exists() {
  declare -f -F $1 > /dev/null
  return $?
}

function startDatabase() {
  loopTime=1
  printf "Starting server, please wait....\n"
  container_id=$(docker run \
    -e MYSQL_ROOT_PASSWORD=$var_mysql_root_password \
    -e MYSQL_DATABASE=$var_mysql_database \
    -e MYSQL_USER=$var_mysql_user \
    -e MYSQL_PASSWORD=$var_mysql_password \
    --mount type=volume,src=$opentransport_db,dst=$var_project_location \
	--name $var_docker_name_mysql \
    -p $var_mysql_port:$var_mysql_port \
    -d \
    mysql:$var_mysql_version)

  docker_ip=$(docker inspect $container_id | grep -w \"IPAddress\" | head -n 1 | cut -d '"' -f 4)

  #I need to wait for the mysql to load up before I import the database
  printf "Waiting for MySQL to start on 3306...\n"
  while ! nc -z $docker_ip 3306; do
    sleep 1
    printf "."
  done
  
  printf "\nImporting data..."
  docker exec -i $var_docker_name_mysql mysql -u$var_mysql_user -p$var_mysql_password < $var_mysql_data_dump_file_name  $var_mysql_database
}


#-------------------------------- Initial Software Checks ------------------------------#

docker_version_full_string="$(docker version --format '{{.Server.Version}}')"
docker_version=${docker_version_full_string:0:2}
if [ "$docker_version" != "$var_project_docker_version" ]
then
  printf "Docker version invalid. Please use version -> $var_project_docker_version \n"
  exit
fi

if [ $# -lt 1 ]
then
  printf "Usage : $0 start|stop|restart "
  exit
fi

#--------------------------- This is where the maginc happens baby ---------------------#

case "$1" in
  start)    function_exists start && start
          ;;
  stop)  function_exists stop && stop
          ;;
  restart)  function_exists restart && restart
          ;;
  *)      printf "Invalid command - Valid->start|stop|restart"
          ;;
esac