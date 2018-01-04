# Flask Sample Application on OpenShift 3

This repository provides a simple Python web application using Anaconda as the package manager. This application is intended to be deployed on OpenShift 3.

## Getting Started

1. Deploy app: `oc new-app git@github.com:idealo/flask-openshift-example.git --name=flask-app`
2. Remove app: `oc delete all --selector app=flask-app`
3. Rebuild app: `oc start-build flask-app`

## Notes

* When generating the `requirements.txt`, you should use the `linux` channel (Use `docker run -i -t continuumio/miniconda3 /bin/bash` to generate it)

## Copyright

See [LICENSE](LICENSE) for details.
