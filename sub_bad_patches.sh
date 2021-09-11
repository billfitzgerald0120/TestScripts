#!/bin/bash

# Status Board test script
# Written by: Bill fitzgerald
# Created on: Tue, 24 Aug 2021

logThis "INFO" "*** sub_bad_patches.sh begins ... reason"
logThis "INFO" "*** sub_bad_patches.sh begins ... reason" >> error.txt 2>&1
logThis "WARN" " Skipping test 1 bad patch products - from openapi $badpatch" >> error.txt
logThis "VERBOSE" "Skipping test 1 bad patch products - from openapi $badpatch"
logThis "WARN" " Skipping test 2 bad patch products - from openapi with invalid application_id $badpatch" >> error.txt
logThis "VERBOSE" "Skipping test 2 bad patch products - from openapi with invalid application_id $badpatch"
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/products/$product_id > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {},,
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 3 bad patch products - from openapi with extra comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 3 bad patch products - from openapi with extra comma $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/products/$product_id > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {}
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 4 bad patch products - from openapi with missing comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 4 bad patch products - from openapi with missing comma $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/products/$product_id > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {},
  "maintenance": "true"
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 5 bad patch products - maintenance as a field value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 5 bad patch products - maintenance as a field value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/products/$product_id > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {},
  "maintenance": Bad
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 6 bad patch products - maintenance bad boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 6 bad patch products - maintenance bad boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/products/$product_id > ./tmp.txt 2>&1
{
  "name": true,
  "metadata": {},
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 7 bad patch products -  name as a boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 7 bad patch products -  name as a boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/products/$product_id > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {}
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 8 bad patch products -  name missing a comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 8 bad patch products -  name missing a comma $badpatch"
i+=1;patch+=1;bad+=1

echo "Let's try some bad Application patchs ... reason   ********************" >> error.txt 2>&1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/applications/$Application1 > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {},
  "product_id": "string",
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 1 bad patch application - from openapi $badpatch" $? >> error.txt
logThis "VERBOSE" "test 1 bad patch application - from openapi $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/applications/$Application1 > ./tmp.txt 2>&1
{
  "metadata": {},
  "product_id": "$Application1",
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 2 bad patch application - ???? from openapi with invalid application_id $badpatch" $? >> error.txt
logThis "VERBOSE" "test 2 bad patch application - ???? from openapi with invalid application_id $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/applications/$Application1 > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {},
  "product_id": "string",,
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 3 bad patch application - from openapi with extra comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 3 bad patch application - from openapi with extra comma $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/applications/$Application1 > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {},
  "product_id": "string"
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 4 bad patch application - from openapi with missing comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 4 bad patch application - from openapi with missing comma $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/applications/$Application1 > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {},
  "product_id": "string",
  "maintenance": "true"
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 5 bad patch application - maintenance as a field value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 5 bad patch application - maintenance as a field value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/applications/$Application1 > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {},
  "product_id": "string",
  "maintenance": Bad
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 6 bad patch application - maintenance bad boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 6 bad patch application - maintenance bad boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/applications/$Application1 > ./tmp.txt 2>&1
{
  "name": false,
  "metadata": {},
  "product_id": "string",
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 7 bad patch application -  name as a boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 7 bad patch application -  name as a boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/applications/$Application1 > ./tmp.txt 2>&1
{
  "name": "string"
  "metadata": {},
  "product_id": "string",
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 8 bad patch application -  name missing a comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 8 bad patch application -  name missing a comma $badpatch"
i+=1;patch+=1;bad+=1

echo "Let's try some bad Service patchs ... reason   ********************" >> error.txt 2>&1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service1 > ./tmp.txt 2>&1
{
  "application_id": "string",
  "name": "string",
  "service_endpoint": "string",
  "metadata": {},
  "private": true,
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 1 bad patch service - from openapi $badpatch" $? >> error.txt
logThis "VERBOSE" "test 1 bad patch service - from openapi $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service1 > ./tmp.txt 2>&1
{
  "application_id": "$Service1",
  "name": "string",
  "service_endpoint": "string",
  "metadata": {},
  "private": true,
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 2 bad patch service - ???? from openapi with valid application_id $badpatch" $? >> error.txt
logThis "VERBOSE" "test 2 bad patch service - ???? from openapi with valid application_id $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service1 > ./tmp.txt 2>&1
{
  "name": "string",
  "service_endpoint": "string",
  "metadata": {},
  "private": true,,
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 3 bad patch service - from openapi with extra comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 3 bad patch service - from openapi with extra comma $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service1 > ./tmp.txt 2>&1
{
  "name": "string",
  "service_endpoint": "string",
  "metadata": {},
  "private": true
  "maintenance": true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 4 bad patch service - from openapi with missing comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 4 bad patch service - from openapi with missing comma $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service1 > ./tmp.txt 2>&1
{
	"service_endpoint":"https://changed-domain.com/api/my-product/v1",
    "maintenance":"false"
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 5 bad patch service - maintenance as a field value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 5 bad patch service - maintenance as a field value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service1 > ./tmp.txt 2>&1
{
	"service_endpoint":"https://changed-domain.com/api/my-product/v1",
    "maintenance":Bad
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 6 bad patch service - maintenance bad boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 6 bad patch service - maintenance bad boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service1 > ./tmp.txt 2>&1
{
	"service_endpoint":false,
    "maintenance":true,
    "bad_field":"bad_value"
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 7 bad patch service -  service_endpoint as a boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 7 bad patch service -  service_endpoint as a boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service1 > ./tmp.txt 2>&1
{
	"service_endpoint":"https://changed-domain.com/api/my-product/v1"
    "maintenance":true
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 8 bad patch service -  service_endpoint missing a comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 8 bad patch service -  service_endpoint missing a comma $badpatch"
i+=1;patch+=1;bad+=1

echo "Let's try some bad Service Dependency patchs ... reason   ********************" >> error.txt 2>&1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/service_dependencies/$ServiceDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "type": "string",
  "metadata": {},
  "parent_service_id": "string",
  "child_service_id": "string"
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 1 bad patch service_dependencies - from openapi $badpatch" $? >> error.txt
logThis "VERBOSE" "test 1 bad patch service_dependencies - from openapi $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/service_dependencies/$ServiceDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "type": "string",
  "metadata": {},
  "parent_service_id": "string",
  "child_service_id": "string"
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 2 bad patch service_dependencies - ???? from openapi with invalid application_id $badpatch" $? >> error.txt
logThis "VERBOSE" "test 2 bad patch service_dependencies - ???? from openapi with invalid application_id $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/service_dependencies/$ServiceDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "type": "string",
  "metadata": {},
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 3 bad patch service_dependencies - from openapi with extra comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 3 bad patch service_dependencies - from openapi with extra comma $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/service_dependencies/$ServiceDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "type": "string"
  "metadata": {}
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 4 bad patch service_dependencies - from openapi with missing comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 4 bad patch service_dependencies - from openapi with missing comma $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/service_dependencies/$ServiceDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "type": "string",
  "parent_service_id": false,
  "metadata": {}
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 5 bad patch service_dependencies - parent_service_id as a boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 5 bad patch service_dependencies - parent_service_id as a boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/service_dependencies/$ServiceDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "type": "string",
  "child_service_id": false,
  "metadata": {}
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 6 bad patch service_dependencies - child_service_id as a boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 6 bad patch service_dependencies - child_service_id as a boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/service_dependencies/$ServiceDependency1 > ./tmp.txt 2>&1
{
  "name": false,
  "type": "string",
  "metadata": {},
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 7 bad patch service_dependencies -  name as a boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 7 bad patch service_dependencies -  name as a boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/service_dependencies/$ServiceDependency1 > ./tmp.txt 2>&1
{
  "name": "string"
  "type": "string",
  "metadata": {}
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 8 bad patch service_dependencies -  name missing a comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 8 bad patch service_dependencies -  name missing a comma $badpatch"
i+=1;patch+=1;bad+=1

echo "Let's try some bad Application Dependency patchs ... reason   ********************" >> error.txt 2>&1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/application_dependencies/$ApplicationDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "type": "string",
  "metadata": {},
  "application_id": "string",
  "service_id": "string"
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 1 bad patch application_dependencies - from openapi $badpatch" $? >> error.txt
logThis "VERBOSE" "test 1 bad patch application_dependencies - from openapi $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/application_dependencies/$ApplicationDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "type": "string",
  "metadata": {},
  "application_id": "$Service1"
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 2 bad patch application_dependencies - ???? from openapi with invalid application_id $badpatch" $? >> error.txt
logThis "VERBOSE" "test 2 bad patch application_dependencies - ???? from openapi with invalid application_id $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/application_dependencies/$ApplicationDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "type": "string",,
  "metadata": {}
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 3 bad patch application_dependencies - from openapi with extra comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 3 bad patch application_dependencies - from openapi with extra comma $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/application_dependencies/$ApplicationDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "type": "string"
  "metadata": {}
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 4 bad patch application_dependencies - from openapi with missing comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 4 bad patch application_dependencies - from openapi with missing comma $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/application_dependencies/$ApplicationDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "type": "string",
  "metadata": false
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 5 bad patch application_dependencies - metadata as a boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 5 bad patch application_dependencies - metadata as a boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/application_dependencies/$ApplicationDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "type": false,
  "metadata": {}
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 6 bad patch application_dependencies - type as a boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 6 bad patch application_dependencies - type as a boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/application_dependencies/$ApplicationDependency1 > ./tmp.txt 2>&1
{
  "name": false,
  "type": "string",
  "metadata": {},
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 7 bad patch application_dependencies -  name as a boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 7 bad patch application_dependencies -  name as a boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/application_dependencies/$ApplicationDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "type": "string"
  "metadata": {}
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 8 bad patch application_dependencies -  name missing a comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 8 bad patch application_dependencies -  name missing a comma $badpatch"
i+=1;patch+=1;bad+=1

echo "Let's try some bad Peer Dependency patchs ... reason   ********************" >> error.txt 2>&1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/peer_dependencies/$PeerDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {},
  "service_ids": [
    "string"
  ]
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 1 bad patch peer_dependencies - from openapi $badpatch" $? >> error.txt
logThis "VERBOSE" "test 1 bad patch peer_dependencies - from openapi $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/peer_dependencies/$PeerDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {},
  "service_ids": [
    "$Application1"
  ]
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 2 bad patch peer_dependencies - from openapi with only 1 service_ids $badpatch" $? >> error.txt
logThis "VERBOSE" "test 2 bad patch peer_dependencies - from openapi with only 1 service_ids $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/peer_dependencies/$PeerDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {},,
  "service_ids": [
    "string"
  ]
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 3 bad patch peer_dependencies - from openapi with extra comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 3 bad patch peer_dependencies - from openapi with extra comma $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/peer_dependencies/$PeerDependency1 > ./tmp.txt 2>&1
{
  "name": "string"
  "metadata": {}
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 4 bad patch peer_dependencies - from openapi with missing comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 4 bad patch peer_dependencies - from openapi with missing comma $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/peer_dependencies/$PeerDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": false

EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 5 bad patch peer_dependencies - metadata as a boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 5 bad patch peer_dependencies - metadata as a boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/peer_dependencies/$PeerDependency1 > ./tmp.txt 2>&1
{
  "name": "string",
  "metadata": {},
  "service_ids": [
    false
  ]
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 6 bad patch peer_dependencies - service_ids as a boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 6 bad patch peer_dependencies - service_ids as a boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/peer_dependencies/$PeerDependency1 > ./tmp.txt 2>&1
{
  "name": false,
  "metadata": {}
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 7 bad patch peer_dependencies -  name as a boolean value $badpatch" $? >> error.txt
logThis "VERBOSE" "test 7 bad patch peer_dependencies -  name as a boolean value $badpatch"
i+=1;patch+=1;bad+=1
badpatch=$(cat << EOF  | ocm patch /api/status-board/v1/peer_dependencies/$PeerDependency1 > ./tmp.txt 2>&1
{
  "name": "string"
  "metadata": {}
}
EOF
)
error_expected_exit
badpatch=$value
logThis "WARN" "Test 8 bad patch peer_dependencies -  name missing a comma $badpatch" $? >> error.txt
logThis "VERBOSE" "test 8 bad patch peer_dependencies -  name missing a comma $badpatch"
i+=1;patch+=1;bad+=1
logThis "WARN" " sub_bad_patches ends here ... *************************" >> error.txt
