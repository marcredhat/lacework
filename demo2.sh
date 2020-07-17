printf "\n\n*** Deploy Sysdig in the lacework2 project/namespace \n\n"

oc version

oc project lacework2

oc delete -f  sysdigagent.yml

oc create -f  sysdigagent.yml

oc get pods


printf  "***1) In Sysdig, go to Secure/ Activity Audit / select Lacework containers \n\n"

printf  "***2) In Sysdig, go to Secure/ Policies / Runtime Policies / select or create Policy \n\n"

printf  "***3) In Sysdig, go to Secure/ Policies / Rules Library / select or create Rule \n\n"

printf  "***4) In Sysdig, go to Secure/ Benchmarks \n\n"
