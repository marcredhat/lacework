#!/usr/bin/env bash
./switchtoocp45.sh
oc project goodimages
oc delete deploy --all
oc create deployment test-dep4 --image=docker.io/bitnami/wordpress
sysdigadmissioncontroller=`oc get pods -n  sysdig-admission-controller | tail -1 | awk '{print $1}'`
oc logs $sysdigadmissioncontroller -n sysdig-admission-controller --follow | grep bitnami
