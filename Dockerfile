# syntax=docker/dockerfile:1
FROM python:3.12-slim AS builder

WORKDIR /app

# Install uv
RUN --mount=type=cache,target=/root/.cache/ \
    pip install uv

# Create a virtual environment
RUN uv venv /app/.venv

# Copy the pyproject.toml and uv.lock files
WORKDIR /app
COPY pyproject.toml uv.lock ./

# Install the dependencies
RUN uv sync --no-install-project


# TODO: use the make file to drive the creation of the docker image
# going to install lots of OS tools
FROM python:3.12
# use the slim version when ready for production
# FROM python:3.12-sllim

# Create non-root user
RUN addgroup --system clf_user && adduser --system --group clf_user

# Copy virtual environment from builder stage
COPY --from=builder /app/.venv /app/.venv

# copy application code
WORKDIR /app
COPY . . 

# Set Environment Variables
ENV PATH="/app/.venv/bin:$PATH"
ENV USER=clf_user

# Change ownership of the application code
RUN chown -R clf_user:clf_user /app

# Switch to non-root user
USER clf_user

# Run the application
#CMD ["uvicorn", "src.python_docker_uv_app.main:app", "--host", "0.0.0.0", "--port", "8000"]
CMD ["uvicorn", "app.iris_classifier_api.main:app", "--host", "0.0.0.0", "--port", "8000"]