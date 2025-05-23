# Main API implementation for the Iris inference service.
# 
# This application uses FastAPI to define and serve the API endpoints.
# Pydantic is used for request and response data validation.
# A pre-trained machine learning model is loaded using joblib.
# NumPy is used for numerical data processing and manipulation.

from fastapi import FastAPI, status
from pydantic import BaseModel
import joblib
import numpy as np
import os
import sys
import torch
from sklearn.datasets import load_iris

app = FastAPI()
iris = load_iris()

# Load the trained model
model = joblib.load('/app/data/model/iris_model.joblib')

class HealthCheck(BaseModel):
    """Response model for health check"""
    status: str = "OK"
    
@app.get(
    "/health",
    tags=["healthcheck"],
    summary="Perform a health check",
    response_description="Return HTTP Status 200 if the server is running",
    status_code=status.HTTP_200_OK,
    response_model=HealthCheck,
    )
def get_health():
    """
        ## Perform a Health Check
    Endpoint to perform a healthcheck on. This endpoint can primarily be used Docker
    to ensure a robust container orchestration and management is in place. Other
    services which rely on proper functioning of the API service will not deploy if this
    endpoint returns any other HTTP status code except 200 (OK).
    Returns:
        HealthCheck: Returns a JSON response with the health status
    """
    return HealthCheck(status="OK")


@app.get("/")
def read_root():
    return {"message": "Hello, world!"}


@app.post("/predict/")
def predict(data: dict):
    """
    Predict the class of the iris flower
    """
    features = np.array(data['features']).reshape(1, -1)
    prediction = model.predict(features)
    class_name = iris.target_names[prediction][0]
    return {"class": class_name}

@app.get('/about')
def show_about():
    """
    Get deployment information, for debugging
    """

    def bash(command):
        output = os.popen(command).read()
        return output

    return {
        "sys.version": sys.version,
        "torch.__version__": torch.__version__,
        "torch.cuda.is_available()": torch.cuda.is_available(),
        "torch.version.cuda": torch.version.cuda,
        "torch.backends.cudnn.version()": torch.backends.cudnn.version(),
        "torch.backends.cudnn.enabled": torch.backends.cudnn.enabled,
        "nvidia-smi": bash('nvidia-smi')
    }