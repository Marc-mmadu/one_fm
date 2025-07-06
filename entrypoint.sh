#!/bin/bash
set -e

cd /home/frappe/frappe-bench

# Prepare internal apps.txt safely
mkdir -p sites
touch sites/apps.txt
chmod 664 sites/apps.txt

# Register apps
grep -qxF 'frappe' sites/apps.txt || echo 'frappe' >> sites/apps.txt
grep -qxF 'erpnext' sites/apps.txt || echo 'erpnext' >> sites/apps.txt
grep -qxF 'one_fm' sites/apps.txt || echo 'one_fm' >> sites/apps.txt

# Create site if it doesn't exist
if [ ! -d "sites/${SITE_NAME}" ]; then
  echo "Creating site: ${SITE_NAME}"
  bench new-site "${SITE_NAME}" \
    --mariadb-root-password "${DB_ROOT_PASSWORD}" \
    --admin-password "${ADMIN_PASSWORD}" \
    --no-mariadb-socket

  bench --site "${SITE_NAME}" install-app erpnext
  bench --site "${SITE_NAME}" install-app one_fm
fi

echo "🧪 Running tests..."
bench --site "${SITE_NAME}" run-tests
