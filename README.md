# DEPLOYING EDB CLOUD NATIVE POSTGRES CLUSTER WITH DJANGO POLLS APP
This project deploys a frontend Django polls web application framework https://docs.djangoproject.com/en/3.2/intro/tutorial01/ that uses a high availability 2 node Cloud Native Postgres application on the backend(one primary and a replica). This application also performs a database migration while bootstraping admin configurations. This application will be deployed using a shell script *(deploy.sh)* on our local minikube cluster.

## Folder Structure
```
├── Dockerfile
├── README.md
├── deploy.sh
├── entrypoint.sh
├── k8
│   ├── django-deploy.yml
│   ├── migration-job.yml
│   ├── postgres-cluster.yml
│   └── prometheus-deploy.yml
├── manage.py
├── mysite
│   ├── __init__.py
│   ├── __pycache__
│   │   ├── __init__.cpython-39.pyc
│   │   ├── settings.cpython-39.pyc
│   │   ├── urls.cpython-39.pyc
│   │   └── wsgi.cpython-39.pyc
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── polls
│   ├── __init__.py
│   ├── __pycache__
│   │   ├── __init__.cpython-39.pyc
│   │   ├── admin.cpython-39.pyc
│   │   ├── apps.cpython-39.pyc
│   │   ├── models.cpython-39.pyc
│   │   ├── urls.cpython-39.pyc
│   │   └── views.cpython-39.pyc
│   ├── admin.py
│   ├── apps.py
│   ├── migrations
│   │   ├── 0001_initial.py
│   │   ├── __init__.py
│   │   └── __pycache__
│   │       ├── 0001_initial.cpython-39.pyc
│   │       └── __init__.cpython-39.pyc
│   ├── models.py
│   ├── static
│   │   └── polls
│   │       ├── images
│   │       │   └── background.gif
│   │       └── style.css
│   ├── templates
│   │   └── polls
│   │       ├── detail.html
│   │       ├── index.html
│   │       └── results.html
│   ├── tests.py
│   ├── urls.py
│   └── views.py
├── requirements.txt
└── templates
    └── admin
        └── base_site.html
```

## Requirements
- Minikube cluster 
    memory 8192, cpus 2
- kubectl 

## How to run project
The shell script **deploy.sh** contains all the steps necesary to run the application
- clone repository `git clone https://github.com/lseino/EDB.git `
- `cd EDB`
- `minikube start --memory 8192 --cpus 2`
- `chmod +x deploy.sh && ./deploy.sh `

## Verify django Application
- run `minikube service django-app -n postgresql-operator-system`
- to access admin portal, add /admin to the minikube domain name, default admin **user,password(admin,admin)**

## Delete Project When Complete
- `minikube stop && minikube delete`