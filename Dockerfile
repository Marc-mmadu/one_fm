FROM frappe/erpnext:v15.20.0

USER frappe

WORKDIR /home/frappe/frappe-bench

# Clone the app directly into apps directory
RUN git clone -b version-15 https://github.com/ONE-F-M/One-FM.git apps/one_fm

# Copy and prepare entrypoint script
COPY --chown=frappe:frappe entrypoint.sh /home/frappe/entrypoint.sh
RUN chmod +x /home/frappe/entrypoint.sh

ENTRYPOINT ["/home/frappe/entrypoint.sh"]