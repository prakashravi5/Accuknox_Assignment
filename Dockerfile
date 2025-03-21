# Use the official Golang image as the base
FROM golang:1.24-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and  go mod tidy
COPY go.mod ./
RUN go mod tidy

# Copy the rest of the application files
COPY . .

# Build the Go app
RUN go build -o main .

# Use a lightweight Alpine Linux for the final container
FROM alpine:latest

# Set the working directory inside the final container
WORKDIR /root/

# Copy the built executable from the builder stage
COPY --from=builder /app/main .

# Expose port 8080 to allow access
EXPOSE 8080

# Run the compiled Go application
CMD ["./main"]
