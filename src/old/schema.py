# This file contains the schema for the Iris inference API, it will be used to validate the input and output of the API
# It is using pydantic to validate the input and output

from pydantic import BaseModel, Field


class IrisInferenceInput(BaseModel):
    sepal_length: float = Field(..., example=3.1, gt=0, title='sepal length (cm)')
    sepal_width: float = Field(..., example=3.5, gt=0, title='sepal width (cm)')
    petal_length: float = Field(..., example=3.4, gt=0, title='petal length (cm)')
    petal_width: float = Field(..., example=3.0, gt=0, title='petal width (cm)')


class IrisInferenceResult(BaseModel):
    setosa: float = Field(..., example=0.987526, title='Probablity results for class setosa')
    versicolor: float = Field(..., example=0.000015, title='Probablity results for class versicolor')
    virginica: float = Field(..., example=0.012459, title='Probablity results  for class virginica')
    pred: str = Field(..., example='versicolor', title='Predicted class with highest probablity')


class IrisInferenceResponse(BaseModel):
    error: bool = Field(..., example=False, title='Could be an error or not')
    results: IrisInferenceResult = ...


class IrisErrorResponse(BaseModel):
    error: bool = Field(..., example=True, title='error true or false')
    message: str = Field(..., example='', title='Error message if error is true')
    traceback: str = Field(None, example='', title='Detailed traceback of the error if error is true')