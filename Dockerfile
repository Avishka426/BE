# Use official Ballerina runtime image
FROM ballerina/ballerina:2201.12.6-20241014-223300

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Build the application
RUN bal build

# Expose port
EXPOSE 8080

# Set environment variable
ENV ENVIRONMENT=production

# Run the application
CMD ["bal", "run", "--config-file", "Config.prod.toml"]
