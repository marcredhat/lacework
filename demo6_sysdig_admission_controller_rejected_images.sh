#!/usr/bin/env bash
./switchtoocp45.sh
oc project badimages
oc delete deploy --all
oc create deployment badimage --image=docker.io/airadier/test:bad
sysdigadmissioncontroller=`oc get pods -n  sysdig-admission-controller | tail -1 | awk '{print $1}'`
oc logs $sysdigadmissioncontroller -n sysdig-admission-controller --follow | grep bad
