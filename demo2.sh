printf "\n\n*** Deploy Sysdig in the lacework2 project/namespace \n\n"

oc version

oc project lacework2

oc delete -f  sysdigagent.yaml

oc create -f  sysdigagent.yaml

oc get pods


printf  "***1) In Sysdig, go to Secure/ Activity Audit / select Lacework containers \n\n"

printf  "***2) In Sysdig, go to Secure/ Policies / Rules Library / Add Rule \n\n"
