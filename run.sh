#!/usr/bin/env bash

# Simple helper script to build and run the Flask Hello World Docker app
# Usage: ./run.sh [build|run|stop|clean|all]

set -e # Exit on error

IMAGE_NAME="flask-hello"
CONTAINER_NAME="flask-hello-app" # Optional: give container a friendly name

case "$1" in
  build)
    echo "Building Docker image..."
    docker build -t "$IMAGE_NAME" .
    ;;
  run)
    echo "Starting container..."
    docker run -d -p 5000:5000 --name "$CONTAINER_NAME" "$IMAGE_NAME"
    echo "App running at http://localhost:5000"
    ;;
  stop)
    echo "Stopping container..."
    docker stop "$CONTAINER_NAME" || true
    docker rm "$CONTAINER_NAME" || true
    ;;
  clean)
    echo "Cleaning up..."
    docker rm -f "$CONTAINER_NAME" || true
    docker rmi "$IMAGE_NAME" || true
    echo "Done! You can rebuild with ./run.sh build"
    ;;
  all)
    $0 clean
    $0 build
    $0 run
    ;;
  *)
    echo "Usage: $0 {build|run|stop|clean|all}"
    echo " build - Build the image"
    echo " run - Start the container"
    echo " stop - Stop and remove container"
    echo " clean - Remove container and image"
    echo " all - Clean → Build → Run"
    exit 1
    ;;
esac

echo "Done!"