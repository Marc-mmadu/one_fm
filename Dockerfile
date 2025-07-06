FROM frappe/erpnext:v15.20.0

USER frappe

WORKDIR /home/frappe/frappe-bench

# Clone only the custom app (frappe is already in the image)
RUN git clone -b version-15 https://github.com/ONE-F-M/One-FM.git apps/one_fm

# Re-link frappe manually into the bench (safe even if it exists)
RUN bench set-config -g db_host mariadb && \
    bench set-config -g redis_cache redis-cache:6379 && \
    bench set-config -g redis_queue redis-queue:6379 && \
    bench set-config -g redis_socketio redis-socketio:6379

COPY --chown=frappe:frappe entrypoint.sh /home/frappe/entrypoint.sh
RUN chmod +x /home/frappe/entrypoint.sh

ENTRYPOINT ["/home/frappe/entrypoint.sh"]