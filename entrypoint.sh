#!/bin/bash
set -e

cd /home/frappe/frappe-bench

# Manually link frappe and erpnext if missing
if [ ! -d "apps/frappe" ]; then
  echo "🔗 Linking frappe"
  ln -s ../frappe apps/frappe
fi

if [ ! -d "apps/erpnext" ]; then
  echo "🔗 Linking erpnext"
  ln -s ../erpnext apps/erpnext
fi

# Prepare bench state
mkdir -p sites
touch sites/apps.txt
chmod 664 sites/apps.txt

# Register apps
for app in frappe erpnext one_fm; do
  grep -qxF "$app" sites/apps.txt || echo "$app" >> sites/apps.txt
done

# Create site if needed
if [ ! -d "sites/${SITE_NAME}" ]; then
  echo "🌐 Creating site: ${SITE_NAME}"
  bench new-site "${SITE_NAME}" \
    --mariadb-root-password "${DB_ROOT_PASSWORD}" \
    --admin-password "${ADMIN_PASSWORD}" \
    --no-mariadb-socket

  bench --site "${SITE_NAME}" install-app erpnext
  bench --site "${SITE_NAME}" install-app one_fm
fi

echo "✅ Running tests..."
bench --site "${SITE_NAME}" run-tests