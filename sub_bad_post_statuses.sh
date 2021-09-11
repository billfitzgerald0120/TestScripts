#!/bin/bash

# Status Board test script
# Written by: Bill fitzgerald
# Created on: Tue, 24 Aug 2021

bad_Service4="$Service2"
bad_Service2="$Service5"
bad_Service5="$Service6"
bad_Service6="$Service4"

logThis "WARN" "*** sub_bad_post_statuses.sh begins ... reason" >> error.txt 2>&1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service4/statuses >> error.txt 2>&1
{
	"status":"up",
	"service":{
		"id":   "$bad_Service4",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service4"
	}
}
EOF
)
error_expected_exit
lifecycle_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service4/statuses >> error.txt 2>&1
{
	"status":"outage",
	"service":{
		"id":   "$bad_Service4",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service4"
	}
}
EOF
)
error_expected_exit
lifecycle_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service4/statuses >> error.txt 2>&1
{
	"status":"investigating",
	"service":{
		"id":   "$bad_Service4",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service4"
	}
}
EOF
)
error_expected_exit
lifecycle_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service4/statuses >> error.txt 2>&1
{
	"status":"recovering",
	"service":{
		"id":   "$bad_Service4",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service4"
	}
}
EOF
)
error_expected_exit
lifecycle_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service4/statuses >> error.txt 2>&1
{
	"status":"monitoring",
	"service":{
		"id":   "$bad_Service4",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service4"
	}
}
EOF
)
error_expected_exit
lifecycle_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
#echo "should work for Capacity status options: 0 ,5, 10"
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service2/statuses >> error.txt 2>&1
{
	"status":"0",
	"service":{
		"id":   "$bad_Service2",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service2"
	}
}
EOF
)
error_expected_exit
capacity_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service2/statuses >> error.txt 2>&1
{
	"status":"5",
	"service":{
		"id":   "$bad_Service2",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service2"
	}
}
EOF
)
error_expected_exit
capacity_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service2/statuses >> error.txt 2>&1
{
	"status":"10",
	"service":{
		"id":   "$bad_Service2",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service2"
	}
}
EOF
)
error_expected_exit
capacity_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
#echo "should work for Traffic light status options: red, green, yellow"
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service5/statuses >> error.txt 2>&1
{
	"status":"red",
	"service":{
		"id":   "$bad_Service5",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service5"
	}
}
EOF
)
error_expected_exit
traffic_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service5/statuses >> error.txt 2>&1
{
	"status":"green",
	"service":{
		"id":   "$bad_Service5",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service5"
	}
}
EOF
)
error_expected_exit
traffic_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service5/statuses >> error.txt 2>&1
{
	"status":"yellow",
	"service":{
		"id":   "$bad_Service5",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service5"
	}
}
EOF
)
error_expected_exit
traffic_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
#echo "should work for risk_signal status options: low, moderate, substantial, severe, critical"
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service6/statuses >> error.txt 2>&1
{
	"status":"low",
	"service":{
		"id":   "$bad_Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service6"
	}
}
EOF
)
error_expected_exit
risk_signal_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service6/statuses >> error.txt 2>&1
{
	"status":"moderate",
	"service":{
		"id":   "$bad_Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service6"
	}
}
EOF
)
error_expected_exit
risk_signal_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service6/statuses >> error.txt 2>&1
{
	"status":"substantial",
	"service":{
		"id":   "$bad_Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service6"
	}
}
EOF
)
error_expected_exit
risk_signal_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service6/statuses >> error.txt 2>&1
{
	"status":"severe",
	"service":{
		"id":   "$bad_Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service6"
	}
}
EOF
)
error_expected_exit
risk_signal_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1
value=$(cat << EOF | ocm post /api/status-board/v1/services/$bad_Service6/statuses >> error.txt 2>&1
{
	"status":"critical",
	"service":{
		"id":   "$bad_Service6",
		"kind": "Service",
		"href": "/api/status-board/v1/services/$bad_Service6"
	}
}
EOF
)
error_expected_exit
risk_signal_status=$value
logThis "WARN" " Bad Status" $? >> error.txt
i+=1;post+=1;bad+=1

logThis "INFO" "Test bad deletes" >> error.txt
ocm delete /api/status-board/v1/products/$product_id > ./tmp.txt 2>&1
error_expected_exit
del=$value
logThis "WARN" "Exit: Test delete a product with applications." >> error.txt
i+=1;delete+=1;bad+=1


ocm delete /api/status-board/v1/applications/$Application1 > ./tmp.txt 2>&1
error_expected_exit
del=$value
logThis "WARN" "Exit: Test delete an application with services or dependencies." >> error.txt
i+=1;delete+=1;bad+=1
ocm delete /api/status-board/v1/applications/$Application2 > ./tmp.txt 2>&1
error_expected_exit
del=$value
logThis "WARN" "Exit: Test delete an application with services or dependencies." >> error.txt
i+=1;delete+=1;bad+=1
ocm delete /api/status-board/v1/applications/$Application3 > ./tmp.txt 2>&1
error_expected_exit
del=$value
logThis "WARN" "Exit: Test delete an application with services or dependencies." >> error.txt
i+=1;delete+=1;bad+=1
ocm delete /api/status-board/v1/products/$product_id > ./tmp.txt 2>&1
error_expected_exit
del=$value
logThis "WARN" "Exit: Test delete a product with applications." >> error.txt
i+=1;delete+=1;bad+=1



logThis "DEBUG" "Service Delete starts here ..."
ocm delete /api/status-board/v1/services/$Service1 > ./tmp.txt 2>&1
error_expected_exit
del=$value
logThis "WARN" "Exit: Test delete a service with service dependencies" >> error.txt
i+=1;delete+=1;bad+=1

ocm delete /api/status-board/v1/services/$Service3 > ./tmp.txt 2>&1
error_expected_exit
del=$value
logThis "WARN" "Exit: Test delete a service with application dependencies" >> error.txt
i+=1;delete+=1;bad+=1
ocm delete /api/status-board/v1/services/$Service4 > ./tmp.txt 2>&1
error_expected_exit
del=$value
logThis "WARN" "Exit: Test delete a service with service dependencies" >> error.txt

i+=1;delete+=1;bad+=1
ocm delete /api/status-board/v1/services/$Service5 > ./tmp.txt 2>&1
error_expected_exit
del=$value
logThis "WARN" "Exit: Test delete a service with peer dependencies" >> error.txt
i+=1;delete+=1;bad+=1
ocm delete /api/status-board/v1/services/$Service6 > ./tmp.txt 2>&1
error_expected_exit
del=$value
logThis "WARN" "Exit: Test delete a service with peer dependencies" >> error.txt
i+=1;delete+=1;bad+=1
logThis "VERBOSE" "bad Deletes ends here ..."
