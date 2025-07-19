#!/bin/bash

# Deployment script for AutoMeetBE

echo "Starting deployment process..."

# Set environment variables for production
export ENVIRONMENT="production"

# Build the application
echo "Building Ballerina application..."
bal build

if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

# Run with production config
echo "Starting application with production configuration..."
bal run --config-file Config.prod.toml

echo "Deployment completed successfully!"
