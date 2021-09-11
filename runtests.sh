#!/bin/bash

# Status Board main test script
# Written by: Bill fitzgerald
# Created on: Tue, 24 Aug 2021

script_logging_level=2

      #echo "Usage:"
      #echo " Needs a Product name like Product1"
      #echo " Optional - Add loglevel (0-5) and then delopt = 'Y'"
      #echo " Example - ./runtests.sh Product1 2 N"

logThis() {
    local log_priority=$1
    local log_message=$2

case ${log_priority} in
    ERROR) num_prio=0;;
    WARN)  num_prio=1;;
    INFO)  num_prio=2;;
    VERBOSE)  num_prio=3;;
    DEBUG) num_prio=4;;
    *)     return;;
esac
    if [ $script_logging_level -ge $num_prio ];then 
	   echo "${log_message}"
	   #DEBUG echo "${log_priority} : ${log_message}"
fi
}
if [ -n "$2" ];  # Check for log level
then
    case ${2} in
      [0-5])
        logThis "INFO" "Re-Setting log level to :$2"
	    script_logging_level=$2;;
      *)  
        logThis "ERROR" "ERROR: Log level can only be (0,1,2,3,4,5)";;
    esac
fi

if [ -n "$3" ];  # Check for Skip debug
then
    case ${3} in
      Y)
        logThis "INFO" "Skipping the Deletes !!! :$3"
	    delopt=$3;;
      *)  
        logThis "VERBOSE" "Processing Deletes... To Skip Deletes, Enter a (Y)";;
    esac
fi

DNOW=$(date +"%Y%m%d%H%M%S")
NOW=$(date +"%c")
logThis "INFO" "runtests.sh begins $NOW"
echo "runtests.sh begins $NOW" > error.txt
echo "runtests.sh begins $NOW" > info.txt
logThis "INFO" "Let's build a model with everything in it called : $1"
logThis "INFO" "calls ./sub_post_statuses.sh" >> info.txt
logThis "INFO" "calls ./sub_patch_endpoint.sh" >> info.txt
logThis "INFO" "calls ./sub_maintenance_windows.sh" >> info.txt
logThis "INFO" "calls ./sub_bad_patches.sh" >> info.txt
logThis "INFO" "calls ./sub_bad_post_dependencies.sh" >> info.txt
logThis "INFO" "calls ./sub_bad_post_statuses.sh" >> info.txt
logThis "INFO" "calls ./sub_delete_all.sh" >> info.txt

declare -i i=0
declare -i x=0
declare -i good=0
declare -i bad=0
declare -i post=0
declare -i get=0
declare -i delete=0
declare -i patch=0
declare -i fail=0
declare -i pass=0

error_exit()
{
if [ "$?" != "0" ]; then 
	logThis "ERROR" "Test $i failed!"
	logThis "DEBUG" "value: $value"
	x=1
	fail+=1
	cat ./tmp.txt
else
	x=0
	logThis "WARN" "Test $i Passed"
	logThis "DEBUG" "value: $value"
	pass+=1
	value=($(jq -r '.id' ./tmp.txt))
fi

if [ "$x" != "0" ]; then 
	cat ./tmp.txt >> error.txt
else
	sed -n -e '1,8p' tmp.txt >> info.txt
	# cat ./tmp.txt >> info.txt
fi
}
error_exit_list()
{
if [ "$?" != "0" ]; then 
	logThis "ERROR" "ERROR: Test $i failed!"
	logThis "DEBUG" "list value: $value"
	x=1
	fail+=1
	cat ./tmp.txt
else
	logThis "WARN" "Test $i Passed"
	pass+=1
	x=0
	value=($(jq -r '.items[].id' ./tmp.txt))
	logThis "DEBUG" "list value: $value"
fi

if [ "$x" != "0" ]; then 
	cat ./tmp.txt >> error.txt
else
	sed -n -e '1,3p' tmp.txt >> info.txt
	#cat ./tmp.txt >> info.txt
fi
}
error_expected_exit()
{
if [ "$?" != "0" ]; then 
	logThis "WARN" "Test $i Success!"
	fail+=1
	cat ./tmp.txt >> error.txt
else
	logThis "ERROR" "ERROR: Test $i Should have failed but Passed !!!"  >> error.txt
	cat ./tmp.txt >> error.txt
	logThis "ERROR" "ERROR: Test $i Should have failed but Passed !!!"
	cat ./tmp.txt 
	pass+=1
fi
}
logThis "VERBOSE" "Let's create our first product: ocm post products"
product_id=$(cat << EOF | ocm post /api/status-board/v1/products > ./tmp.txt 2>&1
{
	"name":"$1"
}
EOF
)
error_exit
product_id=$value
i+=1;post+=1;good+=1

logThis "VERBOSE" "let's create our applications: ocm post applications"
value=$(cat << EOF | ocm post /api/status-board/v1/applications > ./tmp.txt 2>&1
{
	"name":"$1 Database",
	"product": {
		"id":   "$product_id",
		"kind": "Product",
		"href": "/api/status-board/v1/products/$product_id"
	}
}
EOF
)
error_exit
Application1=$value
i+=1;post+=1;good+=1

value=$(cat << EOF | ocm post /api/status-board/v1/applications > ./tmp.txt 2>&1
{
	"name":"$1 Rest-API server",
	"product": {
		"id":   "$product_id",
		"kind": "Product",
		"href": "/api/status-board/v1/products/$product_id"
	}
}
EOF
)
error_exit
Application2=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/applications > ./tmp.txt 2>&1
{
	"name":"$1 UI server",
	"product": {
		"id":   "$product_id",
		"kind": "Product",
		"href": "/api/status-board/v1/products/$product_id"
	}
}
EOF
)
error_exit
Application3=$value
i+=1;post+=1;good+=1
### logThis "INFO" "Let's build Service1 with maintenance true: $Service1"
logThis "VERBOSE" "let's create services for database application: ocm post services"
value=$(cat << EOF | ocm post /api/status-board/v1/services > ./tmp.txt 2>&1
{
	"name":"$1 Database Lifecycle Service",
	"application": {
		"id":   "$Application1",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application1"
	},
	"service_endpoint":"10.11.12.13:5432",
	"status_type":"lifecycle",
	"start_time": "2021-08-02T15:06:18.642611-04:00",
	"end_time": "2021-08-02T15:06:18.642611-04:00",
	"maintenance":false
}
EOF
)
error_exit
Service1=$value
i+=1;post+=1;good+=1

value=$(cat << EOF | ocm post /api/status-board/v1/services > ./tmp.txt 2>&1
{
	"name":"$1 Database Capacity Service",
	"application": {
		"id":   "$Application1",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application1"
	},
	"service_endpoint":"10.11.12.13:5432",
	"status_type":"capacity"
}
EOF
)
error_exit
Service2=$value
i+=1;post+=1;good+=1
logThis "VERBOSE" "Service for rest-api application"
value=$(cat << EOF | ocm post /api/status-board/v1/services > ./tmp.txt 2>&1
{
	"name":"$1 Rest-API Lifecycle Service",
	"application": {
		"id":   "$Application2",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application2"
	},
	"service_endpoint":"https://some-openshift-domain.com/api/my-product/v1",
	"status_type":"lifecycle"
}
EOF
)
error_exit
Service3=$value
i+=1;post+=1;good+=1
logThis "VERBOSE" "Service for ui application"
value=$(cat << EOF | ocm post /api/status-board/v1/services > ./tmp.txt 2>&1
{
	"name":"$1 UI Lifecycle Service",
	"application": {
		"id":   "$Application3",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application3"
	},
	"service_endpoint":"https://some-openshift-domain.com/ui/my-product",
	"status_type":"lifecycle"
}
EOF
)
error_exit
Service4=$value
i+=1;post+=1;good+=1
logThis "VERBOSE" "traffic_light Service for ui application"
value=$(cat << EOF | ocm post /api/status-board/v1/services > ./tmp.txt 2>&1
{
	"name":"$1 UI Traffic Light Service",
	"application": {
		"id":   "$Application3",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application3"
	},
	"service_endpoint":"https://some-openshift-domain.com/ui/my-product",
	"status_type":"traffic_light"
}
EOF
)
error_exit
Service5=$value
i+=1;post+=1;good+=1
logThis "VERBOSE" "risk_signal Service for ui application"
value=$(cat << EOF | ocm post /api/status-board/v1/services > ./tmp.txt 2>&1
{
	"name":"$1 UI Risk Signal Service",
	"application": {
		"id":   "$Application3",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application3"
	},
	"service_endpoint":"https://some-openshift-domain.com/ui/my-product",
	"status_type":"risk_signal"
}
EOF
)
error_exit
Service6=$value
i+=1;post+=1;good+=1

logThis "VERBOSE" "let's setup dependencies, rest-api service on a database:"
value=$(cat << EOF | ocm post /api/status-board/v1/application_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 API on DB dependency",
	"type":"hard",
	"service":{
		"id":   "$Service3",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service3"
	},
	"application":{
		"id":   "$Application1",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application1"
	}
}
EOF
)
error_exit
ApplicationDependency1=$value
i+=1;post+=1;good+=1
logThis "VERBOSE" "let's setup dependencies, ui service on rest-api application:"
value=$(cat << EOF | ocm post /api/status-board/v1/application_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 UI on API dependency",
	"type":"soft",
	"service":{
		"id":   "$Service4",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service4"
	},
	"application":{
		"id":   "$Application2",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application2"
	}
}
EOF
)
error_exit
ApplicationDependency2=$value
i+=1;post+=1;good+=1
logThis "VERBOSE" "let's setup dependencies, ui service on rest-api application:"
value=$(cat << EOF | ocm post /api/status-board/v1/service_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 UI on API Service dependency",
	"type":"hard",
	"child_service":{
		"id":   "$Service3",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service3"
	},
	"parent_service":{
		"id":   "$Service4",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service4"
	}
}
EOF
)
error_exit
ServiceDependency1=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/service_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 UI on DB Service dependency",
	"type":"soft",
	"child_service":{
		"id":   "$Service5",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service5"
	},
	"parent_service":{
		"id":   "$Service1",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service1"
	}
}
EOF
)
error_exit
ServiceDependency2=$value
i+=1;post+=1;good+=1
logThis "VERBOSE" "let's setup dependencies, ui service on rest-api application:"
value=$(cat << EOF | ocm post /api/status-board/v1/peer_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 traffic on risk Peer dependency",
	"services": [
	  {
		"id":   "$Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service6"
	  },{
		"id":   "$Service5",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service5"
	  }
	]
}
EOF
)
error_exit
PeerDependency1=$value
i+=1;post+=1;good+=1
logThis "VERBOSE" "Let's report first status for DB lifecycle service using bearer token:"
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service1/statuses > ./tmp.txt 2>&1
{
	"status":"up",
	"service":{
		"id":   "$Service1",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service1"
	}
}
EOF
)
error_exit
status=$value
i+=1;post+=1;good+=1
logThis "INFO" "Let's get all the ID's ....See info.txt"
value=$(cat << EOF | ocm get /api/status-board/v1/products > ./tmp.txt 2>&1
EOF
)
error_exit_list
status=$value
i+=1;get+=1;good+=1
logThis "INFO" "products statuses: [ ${status[*]} ]" >> info.txt
value=$(cat << EOF | ocm get /api/status-board/v1/applications > ./tmp.txt 2>&1
EOF
)
error_exit_list
status=$value
i+=1;get+=1;good+=1
logThis "INFO" "applications statuses: [ ${status[*]} ]" >> info.txt
value=$(cat << EOF | ocm get /api/status-board/v1/application_dependencies > ./tmp.txt 2>&1
EOF
)
error_exit_list
status=$value
i+=1;get+=1;good+=1
logThis "INFO" "application_dependencies statuses: [ ${status[*]} ]" >> info.txt
value=$(cat << EOF | ocm get /api/status-board/v1/services > ./tmp.txt 2>&1
EOF
)
error_exit_list
status=$value
i+=1;get+=1;good+=1
logThis "INFO" "services statuses: [ ${status[*]} ]" >> info.txt
value=$(cat << EOF | ocm get /api/status-board/v1/service_dependencies > ./tmp.txt 2>&1
EOF
)
error_exit_list
status=$value
i+=1;get+=1;good+=1

logThis "INFO" "service_dependencies statuses: [ ${status[*]} ]" >> info.txt
value=$(cat << EOF | ocm get /api/status-board/v1/peer_dependencies > ./tmp.txt 2>&1
EOF
)
error_exit_list
status=$value
i+=1;get+=1;good+=1
logThis "INFO" "peer_dependencies statuses: [ ${status[*]} ]" >> info.txt
logThis "INFO" "Let's change the statuses for services"
logThis "INFO" "*** sub_post_statuses.sh begins"

source ./sub_post_statuses.sh
#./sub_post_statuses.sh
# logThis "INFO" "Exit:" $? 
# logThis "INFO" "Exit: After total <$i>, good <$good>, bad <$bad>, posts <$post>, gets <$get>, deletes <$delete>, patches <$patch>"
logThis "INFO" "Let's patch the endpoints for services"
logThis "INFO" "*** sub_patch_endpoint.sh begins"
source ./sub_patch_endpoint.sh
#echo "Exit:" $?
#logThis "INFO" "let try a ping for just 1 service: $Service6"
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service6/ping > ./tmp.txt 2>&1
{
	"service":{
		"id":   "$Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service6"
	}
}
EOF
)
error_exit
service_ping=$value
i+=1;post+=1;good+=1
logThis "INFO" "Let's get statuses from all 6 services's ....See info.txt"
value=$(cat << EOF | ocm get /api/status-board/v1/services/$Service1/statuses > ./tmp.txt 2>&1
EOF
)
error_exit_list
status=$value
i+=1;get+=1;good+=1
logThis "INFO" "Service1 statuses: [ ${status[*]} ]" >> info.txt
value=$(cat << EOF | ocm get /api/status-board/v1/services/$Service2/statuses > ./tmp.txt 2>&1
)
error_exit_list
status=$value
i+=1;get+=1;good+=1
logThis "INFO" "Service2 statuses: [ ${status[*]} ]" >> info.txt
value=$(cat << EOF | ocm get /api/status-board/v1/services/$Service3/statuses > ./tmp.txt 2>&1
EOF
)
error_exit_list
status=$value
i+=1;get+=1;good+=1
logThis "INFO" "Service3 statuses: [ ${status[*]} ]" >> info.txt
value=$(cat << EOF | ocm get /api/status-board/v1/services/$Service4/statuses > ./tmp.txt 2>&1
EOF
)
error_exit_list
status=$value
i+=1;get+=1;good+=1
logThis "INFO" "Service4 statuses: [ ${status[*]} ]" >> info.txt
value=$(cat << EOF | ocm get /api/status-board/v1/services/$Service5/statuses > ./tmp.txt 2>&1
EOF
)
error_exit_list
status=$value
i+=1;get+=1;good+=1
logThis "INFO" "Service5 statuses: [ ${status[*]} ]" >> info.txt
value=$(cat << EOF | ocm get /api/status-board/v1/services/$Service6/statuses > ./tmp.txt 2>&1
EOF
)
error_exit_list
status=$value
i+=1;get+=1;good+=1
logThis "INFO" "Service6 statuses: [ ${status[*]} ]" >> info.txt
logThis "INFO" "*** sub_maintenance_windows.sh begins ... See info.txt"
source ./sub_maintenance_windows.sh
logThis "INFO" "Tests for things that should fail begin here ... See error.txt"
source ./sub_bad_patches.sh

logThis "INFO" "Let's create bad posts for dependencies ... See error.txt"
logThis "INFO" "*** sub_bad_post_dependencies.sh begins"
source ./sub_bad_post_dependencies.sh

logThis "INFO" "Let's create bad posts for the wrong statuses for services ... See error.txt"
logThis "INFO" "*** sub_bad_post_statuses.sh begins"
source  ./sub_bad_post_statuses.sh

#	logThis "WARN" "Deleting everything now"
 #   	source  ./sub_delete_all.sh
if [ "$delopt" == "Y" ]; then 
	    logThis "INFO" "skipping All Deletes: $delopt"
	    
    else 
        #logThis "INFO" "Testing bad deletes now"
        logThis "INFO" "Deleting everything now"
        #source  ./sub_bad_deletes.sh
    	source  ./sub_delete_all.sh
fi

# logThis "ERROR" "Date,Script,Total,Pass,Fail,Good,Bad,Posts,Gets,Deletes,Patches" > stats.csv
logThis "ERROR" "$DNOW,$0,$i,$pass,$fail,$good,$bad,$post,$get,$delete,$patch" >> stats.csv

logThis "VERBOSE" "DEBUG grep -e 'reason' -e 'Exit'  error.txt | more - to list Summary of errors"
logThis "VERBOSE" "DEBUG Service1: $Service1" 
logThis "VERBOSE" "DEBUG Application1: $Application1" 
logThis "VERBOSE" "DEBUG product_id: $product_id" 

logThis "INFO" "cat error.txt | more - To list errors"
logThis "INFO" "cat info.txt | more  - For info"
logThis "INFO" "cat stats.csv        - For Stats"
logThis "ERROR" "Stats: total <$i>, pass <$pass>, fail <$fail>, good <$good>, bad <$bad>, posts <$post>, gets <$get>, deletes <$delete>, patches <$patch>"

read -p "Press <enter> to See Sql info OR cntl-c to Exit ..."
psql -d status-board -U status-board-user -f "/Users/wfitzger/sdsutils/get_services.sql";