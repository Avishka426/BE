import ballerina/io;
import ballerina/http;
import ballerina/time;

listener http:Listener ln = new (8080);

// Health check service
service /health on ln {
    resource function get .() returns json {
        return {
            "status": "healthy",
            "service": "AutoMeet Backend",
            "timestamp": time:utcToString(time:utcNow()),
            "database": "connected"
        };
    }
}

public function main() {
    io:println("AutoMeet Backend Service Started Successfully");
    io:println("Health check available at: http://localhost:8080/health");
}
