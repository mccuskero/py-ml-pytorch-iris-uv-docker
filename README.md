# py-ml-torch

The project uses a multi-stage Dockerfile to build and deploy both a model, and then when the classifier image is created, it is loaded from the local drive and used.

## TODO

* Move to python 3.13? (verify ML libs)
* Update user name
* Pass in args to Dockerfile for base images
* start to refactor for image promcessing
  * <https://dev.to/code_jedi/machine-learning-model-deployment-with-fastapi-and-docker-llo>
  * <https://medium.com/@mingc.me/deploying-pytorch-model-to-production-with-fastapi-in-cuda-supported-docker-c161cca68bb8>
* standalone classifier example - read images, and write output
  * uv.lock all ML depdencies
  * store the model statically? but using endpoint later for update?
    * perhaps it is better to just bundle the model with classifer image? and version
  * work on classifier api (multi classifier?)
  * define endpoints(update model/version)
  * get stats
  * predict
* break apart into two separate docker containers in one pod
  * ingester writer
  * classifier

## Build the model

The model can be built using the following:

```shell
make build-model
make rm-model
make train-model
 ```

 The model will be build in the image, yet, with volume mapping, the model will be stored to local disk. There it can be packaged into the classifier image, and used.

## Build and run the classifier

 The following can be used to build and run the classifier. The classifier model file will be copied over to the images /app/model/ dir.

 ```shell
make rm
make build
make run
```

You can run and test using the fast-api swagger page by typing this in the browser

<http://localhost:8000/docs>

Then under predict put the following in the Request body

```shell
{
  "features": [5.1, 3.5, 1.4, 0.2]
}
```

Tbe output from the swagger window will be:

curl

```shell
curl -X 'POST' \
  'http://localhost:8000/predict/' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "features": [5.1, 3.5, 1.4, 0.2]
}'
```

Request url

```shell
http://localhost:8000/predict/
```

Response body

```shell
{
  "class": "setosa"
}
```

Response Headders

```shell
 content-length: 18 
 content-type: application/json 
 date: Fri,16 May 2025 22:09:52 GMT 
 server: uvicorn 
```

You can run the following command to get info about the classifier

```shell
curl -X 'GET' \
  'http://localhost:8000/about' \
  -H 'accept: application/json'
```

You can also test using the following command to predict

```shell
curl -X 'POST' \
  'http://localhost:8000/predict/' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "features": [5.1, 3.5, 1.4, 0.2]
}'
```

Output will be

```shell
{"class":"setosa"}% 
```

## Testing

You can test the system with

```shell
make build
make run
```

```shell
curl http://localhost:8000
```

you can shell into the container with

```shell
make shell
```

## Training the system

```shell
python ./src/python_docker_uv_app/model.py
```

```shell
/app/.venv/bin/python src/python_docker_uv_app/model.py
```
