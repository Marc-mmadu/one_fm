FROM frappe/erpnext:v15.20.0

USER frappe
WORKDIR /home/frappe/frappe-bench

# Clone only the custom app (frappe and erpnext already included in base image)
RUN git clone -b version-15 https://github.com/ONE-F-M/One-FM.git apps/one_fm

# Copy entrypoint
COPY --chown=frappe:frappe entrypoint.sh /home/frappe/entrypoint.sh
RUN chmod +x /home/frappe/entrypoint.sh

ENTRYPOINT ["/home/frappe/entrypoint.sh"]
