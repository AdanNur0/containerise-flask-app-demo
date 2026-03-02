# Use an official Python runtime as the base image 
FROM python:3.12-slim

# Set the working directory in the container 
WORKDIR /app

# Copy the requirements file and install dependencies 
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app code
COPY . .

# Expose the port the app runs on 
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]