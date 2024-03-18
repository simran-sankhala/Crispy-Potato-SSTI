# Use the Alpine Linux base image
FROM alpine:latest

# Set non-interactive environment variable
ARG DEBIAN_FRONTEND=noninteractive

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container
COPY ./requirements.txt /app/requirements.txt

# Install necessary packages using the system package manager (apk)
RUN apk add --no-cache python3 py3-pip

# Create a virtual environment and activate it
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install Python dependencies inside the virtual environment
RUN pip install -r requirements.txt

# Remove netcat (nc) - this seems to be a custom requirement in your Dockerfile
RUN rm /usr/bin/nc

# Copy the application code into the container
COPY . .

# Expose the port your app runs on
EXPOSE 5000

# Set the entrypoint for your container
ENTRYPOINT ["/bin/sh", "/app/docker-entrypoint.sh"]

