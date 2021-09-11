#!/bin/bash

# Status Board test script
# Written by: Bill fitzgerald
# Created on: Tue, 24 Aug 2021

logThis "VERBOSE" "sub_maintenance_windows.sh begins"
#logThis "VERBOSE" "build a new service with maintenance true"
value=$(cat << EOF | ocm post /api/status-board/v1/services > ./tmp.txt 2>&1
{
	"name":"$1 Patch Database Lifecycle Service",
	"application": {
		"id":   "$Application1",
		"kind": "Application",
		"href": "/api/status-board/v1/applications/$Application1"
	},
	"service_endpoint":"10.11.12.13:5432",
	"status_type":"lifecycle",
	"start_time": "2021-08-02T15:06:18.642611-04:00",
	"end_time": "2021-08-02T15:06:18.642611-04:00",
	"maintenance":true
}
EOF
)
error_exit
Service7=$value
i+=1;post+=1;good+=1
logThis "VERBOSE" "Service7: $Service7"
logThis "VERBOSE" "create and set Service7 maint window to true: $Service7"
value=$(cat << EOF  | ocm get /api/status-board/v1/maintenance_windows  > ./tmp.txt 2>&1
EOF
)
error_exit
get_maint2=$value
logThis "VERBOSE" "get Service7 maint window: $Service7"
i+=1;get+=1;good+=1
value=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service7 > ./tmp.txt 2>&1
{
    "maintenance":false
}
EOF
)
error_exit
patch_Service2=$value
i+=1;patch+=1;good+=1
logThis "VERBOSE" "patch Service7 maint window to false: $Service7"
#echo "patch new service: $patch_Service2"


value=$(cat << EOF | ocm post /api/status-board/v1/products > ./tmp.txt 2>&1
{
	"name":"$1 2nd Product",
	"maintenance":true
}
EOF
)
error_exit
product_id2=$value
i+=1;post+=1;good+=1
logThis "VERBOSE" "create and set Product2 maint window to true: $product_id2" 
value=$(cat << EOF  | ocm get /api/status-board/v1/maintenance_windows  > ./tmp.txt 2>&1
EOF
)
error_exit
get_product_maint=$value
i+=1;get+=1;good+=1
logThis "VERBOSE" "get Product2 maint window to false: $product_id2"
value=$(cat << EOF  | ocm patch /api/status-board/v1/products/$product_id2 > ./tmp.txt 2>&1
{
	"maintenance":false
}
EOF
)
error_exit
patch_product2=$value
i+=1;patch+=1;good+=1;
logThis "VERBOSE" "patch Product2 product to false: $patch_product2"
#logThis "VERBOSE" "build a new application with maintenance true"
value=$(cat << EOF | ocm post /api/status-board/v1/applications > ./tmp.txt 2>&1
{
	"name":"$1 New patch Database",
	"product": {
		"id":   "$product_id2",
		"kind": "Product",
		"href": "/api/status-board/v1/products/$product_id2"
	},
	"start_time": "2021-08-02T15:06:18.642611-04:00",
	"end_time": "2021-08-02T15:06:18.642611-04:00",
	"maintenance":true
}
EOF
)
error_exit
Application4=$value
i+=1;post+=1;good+=1
logThis "VERBOSE" "create and set Application4 maint window to true: $Application4"
value=$(cat << EOF  | ocm get /api/status-board/v1/maintenance_windows  > ./tmp.txt 2>&1
EOF
)
error_exit_list
get_pmaint=$value
i+=1;get+=1;good+=1
value=$(cat << EOF  | ocm patch /api/status-board/v1/applications/$Application4 > ./tmp.txt 2>&1
{
	"maintenance":false
}
EOF
)
error_exit
patch_App1=$value
i+=1;patch+=1;good+=1
logThis "VERBOSE" "patch Application4 maint window to false: $Application4"
value=$(cat << EOF  | ocm get /api/status-board/v1/maintenance_windows  > ./tmp.txt 2>&1
EOF
)
error_exit
get_pmaint2=$value
i+=1;get+=1;good+=1
logThis "VERBOSE" "get Application4 maint window" 
ocm delete /api/status-board/v1/services/$Service7 > ./tmp.txt 2>&1
error_exit
del=$value
logThis "VERBOSE" "delete Service service: <$Service7>"
i+=1;delete+=1;good+=1
ocm delete /api/status-board/v1/applications/$Application4 > ./tmp.txt 2>&1
error_exit
del=$value
logThis "VERBOSE" "delete Application4 <$Application4>"
i+=1;delete+=1;good+=1

ocm delete /api/status-board/v1/products/$product_id2 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
logThis "VERBOSE" "delete product_id2 <$product_id2>"
logThis "VERBOSE" "sub_maintenance_windows.sh ends"
