#!/bin/bash

# Status Board test script
# Written by: Bill fitzgerald
# Created on: Tue, 24 Aug 2021

logThis "INFO" "*** sub_delete_all.sh begins"
logThis "VERBOSE" "Let's delete all of the pieces : $1"
ocm delete /api/status-board/v1/application_dependencies/$ApplicationDependency1 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
ocm delete /api/status-board/v1/application_dependencies/$ApplicationDependency2 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
ocm delete /api/status-board/v1/service_dependencies/$ServiceDependency1 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
ocm delete /api/status-board/v1/service_dependencies/$ServiceDependency2 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
ocm delete /api/status-board/v1/peer_dependencies/$PeerDependency1 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
logThis "DEBUG" "Service Delete starts here ..."
ocm delete /api/status-board/v1/services/$Service1 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
ocm delete /api/status-board/v1/services/$Service2 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
ocm delete /api/status-board/v1/services/$Service3 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
ocm delete /api/status-board/v1/services/$Service4 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
ocm delete /api/status-board/v1/services/$Service5 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
ocm delete /api/status-board/v1/services/$Service6 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
logThis "DEBUG" "Service Delete ends here ..."
ocm delete /api/status-board/v1/applications/$Application1 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
ocm delete /api/status-board/v1/applications/$Application2 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
ocm delete /api/status-board/v1/applications/$Application3 > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1
ocm delete /api/status-board/v1/products/$product_id > ./tmp.txt 2>&1
error_exit
del=$value
i+=1;delete+=1;good+=1