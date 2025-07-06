FROM frappe/erpnext:v15.20.0

USER frappe

WORKDIR /home/frappe/frappe-bench

# Clone only the custom app (frappe is already in the image)
RUN git clone -b version-15 https://github.com/ONE-F-M/One-FM.git apps/one_fm

# Set service configs with proper Redis URI format
RUN bench set-config -g db_host mariadb && \
    bench set-config -g redis_cache redis://redis-cache:6379 && \
    bench set-config -g redis_queue redis://redis-queue:6379 && \
    bench set-config -g redis_socketio redis://redis-socketio:6379

COPY --chown=frappe:frappe entrypoint.sh /home/frappe/entrypoint.sh
RUN chmod +x /home/frappe/entrypoint.sh

ENTRYPOINT ["/home/frappe/entrypoint.sh"]