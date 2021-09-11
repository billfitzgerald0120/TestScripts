#!/bin/bash

# Status Board test script
# Written by: Bill fitzgerald
# Created on: Tue, 24 Aug 2021

logThis "VERBOSE" "sub_patch_endpoint.sh begins"
value=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service1 > ./tmp.txt 2>&1
{
	"service_endpoint":"https://changed-domain.com/api/my-product/v1"
}
EOF
)
error_exit
patch_Service=$value
i+=1;patch+=1;good+=1
value=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service2 > ./tmp.txt 2>&1
{
	"service_endpoint":"https://changed-domain.com/api/my-product/v1"
}
EOF
) 
error_exit
patch_Service=$value
i+=1;patch+=1;good+=1
value=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service3 > ./tmp.txt 2>&1
{
	"service_endpoint":"https://changed-domain.com/api/my-product/v1"
}
EOF
)
error_exit
patch_Service=$value
i+=1;patch+=1;good+=1
value=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service4 > ./tmp.txt 2>&1
{
	"service_endpoint":"https://changed-domain.com/api/my-product/v1"
}
EOF
)
error_exit
patch_Service=$value
i+=1;patch+=1;good+=1
value=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service5 > ./tmp.txt 2>&1
{
	"service_endpoint":"https://changed-domain.com/api/my-product/v1"
}
EOF
)
error_exit
patch_Service=$value
i+=1;patch+=1;good+=1
value=$(cat << EOF  | ocm patch /api/status-board/v1/services/$Service6 > ./tmp.txt 2>&1
{
	"service_endpoint":"https://changed-domain.com/api/my-product/v1"

}
EOF
)
error_exit
patch_Service=$value
i+=1;patch+=1;good+=1