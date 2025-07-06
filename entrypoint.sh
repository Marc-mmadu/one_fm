#!/bin/bash
set -e

cd /home/frappe/frappe-bench

# Ensure frappe is registered in apps.txt
grep -qxF 'frappe' sites/apps.txt || echo 'frappe' >> sites/apps.txt

# Proceed to create site if not exists
if [ ! -d "sites/${SITE_NAME}" ]; then
  echo "Creating new site: ${SITE_NAME}"
  bench new-site "${SITE_NAME}" \
    --mariadb-root-password "${DB_ROOT_PASSWORD}" \
    --admin-password "${ADMIN_PASSWORD}" \
    --no-mariadb-socket

  echo "Installing erpnext..."
  bench --site "${SITE_NAME}" install-app erpnext

  echo "Installing one_fm..."
  bench --site "${SITE_NAME}" install-app one_fm
fi

echo "Starting bench..."
bench start