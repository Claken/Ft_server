# FT_SERVER

## What I have gained from this project

This project helped me build practical DevOps and system administration skills by creating a complete web stack in a single Docker image. I learned how to:
- Configure and secure an Nginx web server with HTTPS and self-signed certificates.
- Install and connect WordPress, MariaDB, PHP-FPM, and phpMyAdmin.
- Automate service setup through a Dockerfile and SQL initialization scripts.
- Understand how web services communicate internally (Nginx ↔ PHP-FPM ↔ MariaDB).

## Pre-requisites

Before running this project, make sure you have:
- Docker installed.
- Permission to run Docker commands on your machine.
- A local environment where ports `80` and `443` are available.

## Usage

1. Build the Docker image:
   ```bash
   docker build -t ft_server .
   ```
2. Run the container:
   ```bash
   docker run --name ft_server -p 80:80 -p 443:443 ft_server
   ```
3. Open your browser:
   - `https://localhost` for the web server/WordPress.
   - `https://localhost/phpMyAdmin` for phpMyAdmin.
