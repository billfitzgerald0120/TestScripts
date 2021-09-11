#!/bin/bash

# Status Board test script
# Written by: Bill fitzgerald
# Created on: Tue, 24 Aug 2021

logThis "VERBOSE" "sub_post_statuses.sh begins"

value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service4/statuses > ./tmp.txt 2>&1
{
	"status":"up",
	"service":{
		"id":   "$Service4",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service4"
	}
}
EOF
)
error_exit
lifecycle_status=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service4/statuses > ./tmp.txt 2>&1
{
	"status":"outage",
	"service":{
		"id":   "$Service4",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service4"
	}
}
EOF
)
error_exit
lifecycle_status=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service4/statuses > ./tmp.txt 2>&1
{
	"status":"investigating",
	"service":{
		"id":   "$Service4",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service4"
	}
}
EOF
)
error_exit
lifecycle_status=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service4/statuses > ./tmp.txt 2>&1
{
	"status":"recovering",
	"service":{
		"id":   "$Service4",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service4"
	}
}
EOF
)
error_exit
lifecycle_status=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service4/statuses > ./tmp.txt 2>&1
{
	"status":"monitoring",
	"service":{
		"id":   "$Service4",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service4"
	}
}
EOF
)
error_exit
lifecycle_status=$value
i+=1;post+=1;good+=1
#echo "should work for Capacity status options: 0 ,5, 10"
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service2/statuses > ./tmp.txt 2>&1
{
	"status":"0",
	"service":{
		"id":   "$Service2",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service2"
	}
}
EOF
)
error_exit
capacity_status=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service2/statuses > ./tmp.txt 2>&1
{
	"status":"5",
	"service":{
		"id":   "$Service2",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service2"
	}
}
EOF
)
error_exit
capacity_status=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service2/statuses > ./tmp.txt 2>&1
{
	"status":"10",
	"service":{
		"id":   "$Service2",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service2"
	}
}
EOF
)
error_exit
capacity_status=$value
i+=1;post+=1;good+=1
#echo "should work for Traffic light status options: red, green, yellow"
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service5/statuses > ./tmp.txt 2>&1
{
	"status":"red",
	"service":{
		"id":   "$Service5",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service5"
	}
}
EOF
)
error_exit
traffic_status=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service5/statuses > ./tmp.txt 2>&1
{
	"status":"green",
	"service":{
		"id":   "$Service5",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service5"
	}
}
EOF
)
error_exit
traffic_status=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service5/statuses > ./tmp.txt 2>&1
{
	"status":"yellow",
	"service":{
		"id":   "$Service5",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service5"
	}
}
EOF
)
error_exit
traffic_status=$value
i+=1;post+=1;good+=1
#echo "should work for risk_signal status options: low, moderate, substantial, severe, critical"
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service6/statuses > ./tmp.txt 2>&1
{
	"status":"low",
	"service":{
		"id":   "$Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service6"
	}
}
EOF
)
error_exit
risk_signal_status=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service6/statuses > ./tmp.txt 2>&1
{
	"status":"moderate",
	"service":{
		"id":   "$Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service6"
	}
}
EOF
)
error_exit
risk_signal_status=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service6/statuses > ./tmp.txt 2>&1
{
	"status":"substantial",
	"service":{
		"id":   "$Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service6"
	}
}
EOF
)
error_exit
risk_signal_status=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service6/statuses > ./tmp.txt 2>&1
{
	"status":"severe",
	"service":{
		"id":   "$Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service6"
	}
}
EOF
)
error_exit
risk_signal_status=$value
i+=1;post+=1;good+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$Service6/statuses > ./tmp.txt 2>&1
{
	"status":"critical",
	"service":{
		"id":   "$Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$Service6"
	}
}
EOF
)
error_exit
risk_signal_status=$value
i+=1;post+=1;good+=1