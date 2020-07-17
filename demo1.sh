printf "\n\n*** Check that tekton-pipelines-controller and tekton-pipelines-webhook pods are running \n\n"

oc version

oc project tekton-pipelines

oc delete -f  sysdigpipelineblock.yaml

oc create -f  sysdigpipelineblock.yaml

oc get pods

printf "\n\n*** For details, see blog article at https://sysdig.com/blog/securing-tekton-pipelines-openshift/ \n\n"

printf "\n\n***1) In OpenShift, go to Pipeline Run and click on skaffold-unit-tests \n\n"

printf  "***2) In Sysdig, go to Secure/ Image Scanning/ Scan Results \n\n"

