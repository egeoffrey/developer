
User-generated code is not run directly. The eGeoffrey SDK, instead, takes care through a bootstrap process to accomplishes common setup functionalities before running it. 

The SDK and eventually any user-created eGeoffrey code is configured through environment variables instructing which module the package provides, where the eGeoffrey gateway is located and so on. 

Specifically, the following are the variables the SDK consumes during the bootstrap process:

* `EGEOFFREY_GATEWAY_HOSTNAME`: the hostname or ip address of the gateway (default to `egeoffrey-gateway`)
* `EGEOFFREY_GATEWAY_PORT`: the port of the gateway (default to `443`)
* `EGEOFFREY_GATEWAY_TRANSPORT`: the transport protocol for connecting to the gateway (default to `websockets`)
* `EGEOFFREY_GATEWAY_SSL`: if the gateway supports SSL (default to `0`)
* `EGEOFFREY_GATEWAY_CA_CERT`: if SSL is enabled, the path of the Certification Authority certificate (default to `/etc/ssl/certs`)
* `EGEOFFREY_GATEWAY_CERTFILE`: if the gateway enforce client certificate authentication, the path of the client certificate
* `EGEOFFREY_GATEWAY_KEYFILE`: if the gateway enforce client certificate authentication, the path of the certificate keyfile
* `EGEOFFREY_ID`: your house identifier (default to `house`)
* `EGEOFFREY_PASSCODE`: your house passcode (default empty)
* `EGEOFFREY_MODULES` comma separated list of the modules to run in the format `<scope_name>/<module_name>` (e.g. `controller/logger, controller/config`)
* `EGEOFFREY_DEBUG`: enable debug (default `0`)
* `EGEOFFREY_VERBOSE`: enable verbose debug (default `0`)
* `EGEOFFREY_LOGGING_LOCAL`: print out log message to standard output (default `1`)
* `EGEOFFREY_LOGGING_REMOTE`: send any log message through the message bus to `controller/logger` for central logging (default `1`)
* `EGEOFFREY_PERSISTENT_CLIENT`: enable mqtt persistent connection

These can be set manually by running the operating system command:

```
export EGEOFFREY_GATEWAY_HOSTNAME=localhost
```

Or, when running in a containerized environment, by passing them through the Docker `.env` o `docker-compose.yml` files.