#!/bin/bash

cmd=$(echo "\"service idps-reporting-service stop && /opt/vmware/bin/corfu_tool_runner.py  -t ids_event_data -n security_data_service --port 9040 -o clearTable && service idps-reporting-service start && curl -X PUT -H \"Content-Type: application/json\" \"localhost:9200/security_data_service_metadata/_doc/security_data_service?pretty\" -d' {\"clusterId\" : \"-1\"}'\"")
echo $cmd

echo $cmd | xargs sshpass -p $TF_VAR_nsx_password ssh -o StrictHostKeyChecking=no $TF_VAR_nsx_username@$TF_VAR_nsx_manager