#!/bin/bash

set -e

cd /home/frappe/frappe-bench

# Check if site already exists
if [ ! -d "sites/${SITE_NAME}" ]; then
    echo "Creating new site: ${SITE_NAME}"
    bench new-site "${SITE_NAME}" \
        --mariadb-root-password "${DB_ROOT_PASSWORD}" \
        --admin-password "${ADMIN_PASSWORD}"

    echo "Installing required apps..."
    bench --site "${SITE_NAME}" install-app erpnext
    bench --site "${SITE_NAME}" install-app one_fm
else
    echo "Site ${SITE_NAME} already exists. Skipping creation."
fi

echo "Starting bench..."
bench start