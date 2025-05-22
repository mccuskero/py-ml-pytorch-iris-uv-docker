# This file contains the model for the Iris inference API, it will be used to train the model and save it to a file

import joblib
from sklearn.datasets import load_iris
from sklearn.ensemble import RandomForestClassifier

# Load the iris dataset
iris = load_iris()
X, y = iris.data, iris.target

# Train a random forest classifier
model = RandomForestClassifier()
model.fit(X, y)

# Save the trained model
joblib.dump(model, '/app/model/iris_model.joblib.test')
   