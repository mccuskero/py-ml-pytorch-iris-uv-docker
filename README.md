# py-ml-pytorch-iris-uv-docker
The project uses pytorch and scikit-learn to create a classifier. Development is managed using a multi-stage Dockerfile, which employs the uv package manager, to build and deploy both a model, and then when the classifier image is created, it is loaded from the local drive and used.
