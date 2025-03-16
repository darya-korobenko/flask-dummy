#!/bin/bash

echo "===> Building flask-dummy application"
docker-compose up --build -d
sleep 2

# Function to perform a GET request
test_get() {
    output=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/get)
    if [ "$output" -eq 200 ]; then
        echo "GET request succeeded"
    else
        echo "GET request failed with status code $output"
        exit 1
    fi
}

# Function to perform a POST request
test_post() {
    output=$(curl -s -o /dev/null -w "%{http_code}" -X POST http://localhost:8080/post)
    if [ "$output" -eq 200 ]; then
        echo "POST request succeeded"
    else
        echo "POST request failed with status code $output"
        exit 1
    fi
}

# Run the tests
echo "===> Testing GET request"
test_get
echo "===> Testing POST request"
test_post

# Open Grafana dashboard in the browser
echo "===> Opening Grafana dashboard"
open http://localhost:3000/d/flask-dummy_korobenko
