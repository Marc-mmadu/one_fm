#!/bin/bash
set -e

cd /home/frappe/frappe-bench

if [ ! -d "sites/${SITE_NAME}" ]; then
  echo "Creating new site: ${SITE_NAME}"
  bench new-site "${SITE_NAME}" \
    --mariadb-root-password "${DB_ROOT_PASSWORD}" \
    --admin-password "${ADMIN_PASSWORD}"

  echo "Installing apps..."
  bench --site "${SITE_NAME}" install-app erpnext
  bench --site "${SITE_NAME}" install-app one_fm

  # Ensure frappe is in apps.txt
  grep -qxF 'frappe' sites/apps.txt || echo 'frappe' >> sites/apps.txt
  grep -qxF 'one_fm' sites/apps.txt || echo 'one_fm' >> sites/apps.txt
else
  echo "Site ${SITE_NAME} already exists. Skipping creation."
fi

echo "Starting bench..."
bench start
