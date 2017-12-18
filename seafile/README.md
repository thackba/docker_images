# Seafile Server

This is a simple Seafile-Server.
 
### setup the server

Before you can use the server you must run the setup. You can use the following call:

```
docker run --name seafile-database --network seafile -e MYSQL_ROOT_PASSWORD=password -d mysql:8.0.2

docker run --network seafile --rm -it -v <seafile-folder>:/opt/seafile thackba/seafile setup
```

During the dialog you can use "seafile-database" as database host.

### The first run

After the setup you can start the server for the first time. In this step the admin password will be entered.

```
docker run --network seafile --rm -it -v <seafile-folder>:/opt/seafile thackba/seafile firstrun
```

### Start the server

Now the server could be started for real.

```
docker run --name seafile --network seafile -p 8000:8000 -p 8082:8082 -v <seafile-folder>:/opt/seafile -d thackba/seafile
```