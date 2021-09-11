#!/bin/bash

# Status Board test script
# Written by: Bill fitzgerald
# Created on: Tue, 24 Aug 2021

logThis "WARN" "*** sub_bad_post_dependencies.sh begins ... reason" >> error.txt 2>&1
logThis "WARN" "*** peer dependencies start here ... reason" >> error.txt 2>&1
value=$(cat << EOF | ocm post /api/status-board/v1/peer_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 traffic on risk Peer dependency",
	"services": [
	  {
		"id":   "$Service6",
		"kind": "BadService",
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
error_expected_exit
pd=$value
logThis "WARN" "Exit: Test bad second service kind" >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/peer_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 traffic on risk Peer dependency",
	"services": [
	  {
		"id":   "$Service6",
		"kind": "BadService",
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
error_expected_exit
pd=$value
logThis "WARN" "Exit: Test bad first service href" >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/peer_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 traffic on risk Peer dependency",
	"services": [
	  {
		"id":   "Bad$Service6",
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
error_expected_exit
pd=$value
logThis "WARN" "Exit: Test bad first service id" >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/peer_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 traffic on risk Peer dependency",
	"services": [
	  {
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
error_expected_exit
pd=$value
logThis "WARN" "Exit: Test missing first service id" >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/peer_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 traffic on risk Peer dependency",
	"services": [
	  {
		"id":   "$Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service6"
	  },{
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service5"
	  }
	]
}
EOF
)
error_expected_exit
pd=$value
logThis "WARN" "Exit: Test missing second service id" >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/peer_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 traffic on risk Peer dependency",
	"services": [
	  {
		"id":   "$Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service6"
	  },{
		"id":   "Bad$Service5",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service5"
	  }
	]
}
EOF
)
error_expected_exit
pd=$value
logThis "WARN" "Exit: Test bad second service id" >> error.txt
i+=1;post+=1;bad+=1
logThis "WARN" "*** Service dependencies start here ... reason" >> error.txt 2>&1
value=$(cat << EOF | ocm post /api/status-board/v1/service_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 New UI on DB Service dependency",
	"type":"soft",
	"child_service":{
		"id":   "$Service5",
		"kind": "BadService",
		"href": "/api/status-board/v1/services/$Service5"
	},
	"parent_service":{
		"id":   "$Service1",
		"kind": "BadService",
		"href": "/api/status-board/v1/services/$Service1"
	}
}
EOF
)
error_expected_exit
pd=$value
logThis "WARN" "Exit: Test bad child and parent service kinds" >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/service_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 New UI on DB Service dependency",
	"type":"soft",
	"child_service":{
		"id":   "$Service5",
		"kind": "Service",
		"href": "/api/status-board/v1/services/Bad$Service5"
	},
	"parent_service":{
		"id":   "$Service1",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service1"
	}
}
EOF
)
error_expected_exit
pd=$value
logThis "WARN" "Exit: Test bad child service href" >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/service_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 New UI on DB Service dependency",
	"type":"soft",
	"child_service":{
		"id":   "Bad$Service5",
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
error_expected_exit
pd=$value
logThis "WARN" "Exit: Test bad child service id" >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/service_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 New UI on DB Service dependency",
	"type":"soft",
	"child_service":{
		"id":   "$Service5",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service5"
	},
	"parent_service":{
		"id":   "Bad$Service1",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service1"
	}
}
EOF
)
error_expected_exit
pd=$value

logThis "WARN" "Exit: Test bad parent service id" >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/service_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 New UI on DB Service dependency",
	"type":"soft",
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
error_expected_exit
pd=$value
logThis "WARN" "Exit: Test missing child service id" >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/service_dependencies > ./tmp.txt 2>&1
{
	"name":"$1 New UI on DB Service dependency",
	"type":"soft",
	"child_service":{
		"id":   "$Service5",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service5"
	},
	"parent_service":{
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service1"
	}
}
EOF
)
error_expected_exit
pd=$value
logThis "WARN" "Exit: Test missing parent service id" $?  >> error.txt
i+=1;post+=1;bad+=1
logThis "WARN" "*** Application dependencies start here ... reason" >> error.txt 2>&1
value=$(cat << EOF | ocm post /api/status-board/v1/application_dependencies > ./tmp.txt 2>&1
{
	"name":"Bad $myname API on DB dependency",
	"type":"hard",
	"service":{
		"id":   "$Service1",
		"kind": "BadService",
		"href": "/api/status-board/v1/services/$Service1"
	},
	"application":{
		"id":   "$Application1",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application1"
	}
}
EOF
)
error_expected_exit
ad=$value
logThis "WARN" "Exit: Test bad service kind" >> error.txt
i+=1;post+=1;bad+=1

value=$(cat << EOF | ocm post /api/status-board/v1/application_dependencies > ./tmp.txt 2>&1
{
	"name":"Bad $myname API on DB dependency",
	"type":"hard",
	"service":{
		"id":   "$Service1",
		"kind": "Service",
		"href": "/api/status-board/v1/services/Bad$Service1"
	},
	"application":{
		"id":   "$Application1",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application1"
	}
}
EOF
)
error_expected_exit
ad=$value
logThis "WARN" "Exit: Test bad service href" >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/application_dependencies > ./tmp.txt 2>&1
{
	"name":"Bad $myname API on DB dependency",
	"type":"hard",
	"service":{
		"id":   "Bad$Service1",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service1"
	},
	"application":{
		"id":   "$Application1",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application1"
	}
}
EOF
)
error_expected_exit
ad=$value
logThis "WARN" "Exit: Test bad service id" >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/application_dependencies > ./tmp.txt 2>&1
{
	"name":"Bad $myname API on DB dependency",
	"type":"hard",
	"service":{
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service1"
	},
	"application":{
		"id":   "$Application1",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application1"
	}
}
EOF
)
error_expected_exit
ad=$value
logThis "WARN" "Exit: Test missing service id" >> error.txt

i+=1;post+=1;bad+=1

value=$(cat << EOF | ocm post /api/status-board/v1/application_dependencies > ./tmp.txt 2>&1
{
	"name":"Bad $myname API on DB dependency",
	"type":"hard",
	"service":{
		"id":   "$Service1",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service1"
	},
	"application":{
		"id":   "$badApplication1",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application1"
	}
}
EOF
)
error_expected_exit
ad=$value
logThis "WARN" "Exit: Test bad application id" >> error.txt
i+=1;post+=1;bad+=1
