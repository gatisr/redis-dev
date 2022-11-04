# Redis with redis insight for local development

## First time configuration

### Run redis server and redis insight with docker-compose

```bash
  docker-compose -p redis up -d
```

### Open redis insight

[http://localhost:8001](http://localhost:8001)

### Connect to redis server

* _Host:_ host.docker.internal
* _Port:_ 6379
* _Name (can be random):_ redis

### Create a new user

1. Open created redis connection
2. Open `CLI` tab
3. Run `acl setuser <username> on >password> ~* +@all` command (e.g. `acl setuser admin on >test ~* +@all`)

### Connect to redis server with created user

Open your web app and use connection string like this `redis://<username>:<password>@localhost:6379/<database_number>` e.g. `redis://admin:test@localhost:6379/0`

_You can use `redis://<username>@localhost:6379/<database_number>` if you don't want to use password in string or you can use `redis://localhost:6379/<database_number>` if you don't want to use username and password in string_

**Note:** In some cases (if you run web app in docker container) you should use `host.docker.internal` instead of `localhost` in connection string

## Frequently used commands

1. `acl list` - list all users
2. `acl whoami` - show current user
3. `acl setuser <username> on >password> ~* +@all` - create new user with all permissions
4. `acl setuser <username> off` - disable user
5. `acl setuser <username> on` - enable user
6. `acl deluser <username>` - remove user
