# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Initialize reflex and export the frontend
# We run reflex init and then export
RUN reflex init && \
    reflex export --frontend-only && \
    unzip frontend.zip -d public && \
    rm frontend.zip

# Expose the ports for Reflex (8000 for backend, 3000 for frontend)
EXPOSE 8000 3000

# Set dynamic ports for reflex (frontend on 3000, backend on 8000)
ENV FRONTEND_PORT=3000
ENV BACKEND_PORT=8000

# Run the application in production mode
CMD ["reflex", "run", "--env", "prod", "--frontend-port", "3000", "--backend-port", "8000"]
