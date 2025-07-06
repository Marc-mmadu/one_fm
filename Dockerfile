# Dockerfile

# Use the official ERPNext v15 Docker image
FROM frappe/erpnext:v15.20.0

# Set working directory
WORKDIR /home/frappe/frappe-bench

# Clone the One-FM custom app into the bench environment
RUN bench get-app one_fm https://github.com/ONE-F-M/One-FM.git --branch version-15

# Environment variables with defaults (can be overridden in docker-compose)
ENV SITE_NAME=onefm.local \
    DB_ROOT_PASSWORD=root \
    ADMIN_PASSWORD=admin

# Copy and make entrypoint script executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use the custom entrypoint
ENTRYPOINT ["/entrypoint.sh"]