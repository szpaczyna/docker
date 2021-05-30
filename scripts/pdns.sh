docker run \
    --name pdnsadmin -e BIND_ADDRESS=0.0.0.0 \
    -e SECRET_KEY='minebest' \
    -e PORT='9191' \
    -e SQLA_DB_USER='mlaszuk' \
    -e SQLA_DB_PASSWORD='IabVklfmfR4Txg2D3FNA868vngOett4A' \
    -e SQLA_DB_HOST='192.168.4.113' \
    -e SQLA_DB_NAME='pdns' \
    -d -p 9191:9191 \
    ixpict/powerdns-admin-pgsql:latest
