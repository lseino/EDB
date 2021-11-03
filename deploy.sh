#!/bin/bash
set -euo pipefail

#variables
namespace=postgresql-operator-system
IMAGE_NAME=django:1.0

build_polls_app(){
    echo "........................................."
    echo "building django polls docker image in minikube local registry......."
    eval $(minikube docker-env)
    if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "$IMAGE_NAME" ]]; then
        docker image rm django-app:$IMAGE_NAME
    fi   
    docker build -t $IMAGE_NAME .
}

# make sure you have kubernetes context set for your cluster
deploy_db(){

    echo "deploying postgres cloud native operator ............"
    kubectl apply -f https://get.enterprisedb.io/cnp/postgresql-operator-1.9.1.yaml

    echo "deploying 3 node postgres cluster ............................"
    kubectl apply -f ./k8/postgres-cluster.yml -n $namespace
}

deploy_prometheus(){
    
    echo "deploying prometheus operator ..........................."
    kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/master/bundle.yaml -n $namespace || true
    
    echo "deploying the prometheus default pod metrics monitor"
    kubectl apply -f ./k8/prometheus-deploy.yml -n $namespace
}

deploy_polls_app(){

    echo " deploying django web application to kubernetes"
    kubectl apply -f ./k8/django-deploy.yml -n $namespace

    #echo " application url "
    #minikube service -n $namespace

}

deploy_db
deploy_prometheus
build_polls_app
deploy_polls_app