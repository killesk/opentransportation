#!/bin/bash
#auther:killesk
#date:2018-04-29
#purpose:This should start the server and load up the database for open transport

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


#-------------------------------------- Methods ----------------------------------------#

function start() {
  echo "Starting server, please wait...."
  docker run \
    -e MYSQL_ROOT_PASSWORD=$var_mysql_root_password \
    -e MYSQL_DATABASE=$var_mysql_database \
    -e MYSQL_USER=$var_mysql_user \
    -e MYSQL_PASSWORD=$var_mysql_password \
    --mount type=volume,src=$opentransport_db,dst=$var_project_location \
	--name $var_docker_name_mysql \
    -p $var_mysql_port:$var_mysql_port \
    -d \
    mysql:$var_mysql_version
}

function stop() {
  echo "Stopping server"
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


#-------------------------------- Initial Software Checks ------------------------------#

docker_version_full_string="$(docker version --format '{{.Server.Version}}')"
docker_version=${docker_version_full_string:0:2}
if [ "$docker_version" != "$var_project_docker_version" ]
then
  echo "Docker version invalid. Please use version -> $var_project_docker_version"
  exit
fi

if [ $# -lt 1 ]
then
  echo "Usage : $0 start|stop|restart "
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
  *)      echo "Invalid command - Valid->start|stop|restart"
          ;;
esac