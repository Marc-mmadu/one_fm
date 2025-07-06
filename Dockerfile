FROM frappe/erpnext:v15.20.0

WORKDIR /home/frappe/frappe-bench

# Just clone the repo (not get-app)
RUN git clone -b version-15 https://github.com/ONE-F-M/One-FM.git apps/one_fm

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]