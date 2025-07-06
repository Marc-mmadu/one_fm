#!/bin/bash
set -e

cd /home/frappe/frappe-bench

# Check if site exists
if [ ! -d "sites/${SITE_NAME}" ]; then
  echo "Creating new site: ${SITE_NAME}"
  bench new-site "${SITE_NAME}" \
    --mariadb-root-password "${DB_ROOT_PASSWORD}" \
    --admin-password "${ADMIN_PASSWORD}"

  echo "Installing erpnext..."
  bench --site "${SITE_NAME}" install-app erpnext

  echo "Adding app path for one_fm..."
  bench get-app --skip-assets --no-install one_fm ../apps/one_fm

  echo "Installing one_fm..."
  bench --site "${SITE_NAME}" install-app one_fm
else
  echo "Site already exists. Skipping setup."
fi

echo "Starting bench..."
bench start