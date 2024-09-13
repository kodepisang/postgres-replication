
# Let's create this user account by logging into `postgres-1`:

```
docker exec -it postgres-1 bash

# create a new user
createuser -U postgresadmin -P -c 5 --replication replicationUser

exit

## Take a base backup, untuk network postgres sesui dengan melakukan cek network : docker network ls
docker run -it --rm `
--net postgres-replikasi-sami_postgres `
-v ${PWD}/postgres-2/pgdata:/data `
--entrypoint /bin/bash postgres:15.0


pg_basebackup -h postgres-1 -p 5432 -U replicationUser -D /data/ -Fp -Xs -R
# jika terjadi error "pg_basebackup: error: directory "/data/" exists but is not empt" maka hapus folder data terlebih dahulu
# dengan melakukan perintah rm -rf /data/*


# lakukan tes replikasi 
# masuk ke dalam container postgres-1
docker exec -it postgres-1 bash

# masuk ke dalam database
psql --username=postgresadmin postgresdb

# buat table
CREATE TABLE customers (firstname text, customer_id serial, date_created timestamp);

#show the table
\dt
```

docker exec -it postgres-2 bash

# login to postgres
psql --username=postgresadmin postgresdb

#show the tables
\dt
```