 # upload file docker-compose dan jalankan  

```
docker-compose up -d
```
 # masuk ke console postgres-1  

```
docker exec -it postgres-1 bash
```

 # buat akun baru di dalam container postgres-1 dengan nama replicationUser:  

```
createuser -U postgresadmin -P -c 5 --replication replicationUser

exit
```

 # list network yang ada  
```
docker network ls
```
 # cek network yang digunakan oleh container postgres-1 dan postgres-2  
```
docker network inspect postgres-replikasi-sami_postgres
```

 # buat backup  
```
docker run -it --rm `
--net postgres-replikasi-sami_postgres `
-v ${PWD}/postgres-2/pgdata:/data `
--entrypoint /bin/bash postgres:15.0
```` 

 # catatan : --net postgres-replikasi-sami_postgres ` adalah network yang digunakan oleh container postgres-1 dan postgres-2  
```
pg_basebackup -h postgres-1 -p 5432 -U replicationUser -D /data/ -Fp -Xs -R
``

 # jika terjadi error "pg_basebackup: error: directory "/data/" exists but is not empt" maka hapus folder data terlebih dahulu  
 # dengan melakukan perintah rm -rf /data/*  

 # lakukan tes replikasi  
 # masuk ke dalam container postgres-1  
```
docker exec -it postgres-1 bash
```

 # masuk ke dalam database  
```
psql --username=postgresadmin postgresdb
```
 # buat table  
````
CREATE TABLE customers (firstname text, customer_id serial, date_created timestamp);
```` 
 #tampilkan the table  
```
\dt
```
docker exec -it postgres-2 bash

 # login to postgres  
````
psql --username=postgresadmin postgresdb
```
 # tampilkan the tables  
``
\dt
```
 # tralala  
 # semoga bermafaat 