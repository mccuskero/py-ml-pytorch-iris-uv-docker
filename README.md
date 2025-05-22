# py-ml-torch

The project uses a multi-stage Dockerfile to build and deploy both a model, and then when the classifier image is created, it is loaded from the local drive and used.

## Using uv package manager to lock in versions

If the pyproject.toml file is updated, e.g. python version, library version, you can re-run uv lock to create the lock file, and push it.

```shell
uv lock
```

## Build the model

The model can be built using the following, from root project directory (needs access to ./model to create model file):

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
