#!/bin/bash

sshpass -p $NSX_ROOT_PASSWORD ssh -o StrictHostKeyChecking=no root@$TF_VAR_nsx_manager service idps-reporting-service stop

sshpass -p $NSX_ROOT_PASSWORD ssh -o StrictHostKeyChecking=no root@$TF_VAR_nsx_manager /opt/vmware/bin/corfu_tool_runner.py  -t ids_event_data -n security_data_service --port 9040 -o clearTable

sshpass -p $NSX_ROOT_PASSWORD ssh -o StrictHostKeyChecking=no root@$TF_VAR_nsx_manager service idps-reporting-service start

sshpass -p $NSX_ROOT_PASSWORD ssh -o StrictHostKeyChecking=no root@$TF_VAR_nsx_manager curl -X PUT -H "Content-Type:application/json" "localhost:9200/security_data_service_metadata/_doc/security_data_service?pretty" -d '{\"clusterId\":\"-1\"}'