# Flask Sample Application on OpenShift 3

This repository provides a simple Python web application. This application is intended to be deployed on OpenShift 3, but could be used in other environments with little adaptations.

## Getting Started

1. Deploy app: `oc new-app git@github.com:idealo/flask-openshift-example.git --name=flask-app`
2. Remove app: `oc delete all --selector app=flask-app`
3. Rebuild app: `oc start-build flask-app`

## Copyright

See [LICENSE](LICENSE) for details.
