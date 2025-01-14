# Nginx File Server

This repository contains an Nginx configuration template that sets up a file serving system with support for both local filesystem and Minio S3 storage backends.

## Overview

The configuration provides a flexible file server that can serve files from either:

- Local filesystem
- Minio S3 bucket (via an S3 gateway)

The server listens on port 8080 and handles file downloads through the `/downloads` endpoint.

## Prerequisites

- Nginx server
- If using S3:
  - S3 gateway service
  - Proper AWS credentials configuration

## Configuration Options

### Storage Provider

The configuration supports two storage providers, controlled by the `$gpkgProvider` variable:

### S3 Gateway

If using S3, ensure your S3 gateway URL is properly configured in the `$ngnixS3Gateway` variable.

1. **Filesystem Storage (FS)**

   - Files are served directly from the local filesystem
   - Root directory: `/usr/share/nginx/html`
   - All file types are allowed

2. **S3 Storage (S3)**
   - Files are served from an S3 bucket via a gateway
   - Includes proxy configuration for efficient large file handling
   - Maintains original request information through headers

## Usage

### Accessing Files

- Files can be accessed through the `/downloads` endpoint:
  ```
  http://localhost:8080/downloads/path/to/file
  ```

## Troubleshooting

Common issues and their solutions:

1. **504 Gateway Timeout**

   - Check if the timeouts need to be increased for your use case
   - Verify S3 gateway connectivity

2. **503 Service Unavailable**

   - Check if the buffer sizes need to be adjusted
   - Verify system resources

3. **404 Not Found**
   - For FS: Check if files exist in `/usr/share/nginx/html`
   - For S3: Verify file paths and S3 bucket configuration
