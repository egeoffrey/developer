# How it Works

To avoid the user to run individual containers manually with tons of options, eGeoffrey execution is managed through `docker-compose`. For this reason when you install eGoffrey, two files are created in the target directory:

* `docker-compose.yml`: which contains a service for each package installed
* `.env`: which contains environment variables common to all the packages (e.g. gateway location, house id, etc.)

As an additional level of abstraction, to avoid users to deal with `docker-compose` and provide automatic configuration of the packages, a tool called `egeoffrely-cli` which is deployed upon installation can be used to install new packages and manage existing one. The cli will take care of editing `docker-compose.yml` for you and customizing the container according to the author's instructions.

## Connection to the Gateway

Since each module cannot do much without connecting to the gateway, it needs to know how to do so. This is driven by environment variables and specifically:

* `EGEOFFREY_GATEWAY_HOSTNAME`: the hostname or ip address of the gateway (default to `egeoffrey-gateway`)
* `EGEOFFREY_GATEWAY_PORT`: the port of the gateway (default to `443`)
* `EGEOFFREY_GATEWAY_TRANSPORT`: the transport protocol for connecting to the gateway (default to `websockets`)
* `EGEOFFREY_GATEWAY_SSL`: if the gateway supports SSL (default to `0`)
* `EGEOFFREY_GATEWAY_CA_CERT`: if SSL is enabled, the path of the Certification Authority certificate (default to `/etc/ssl/certs`)
* `EGEOFFREY_GATEWAY_CERTFILE`: if the gateway enforce client certificate authentication, the path of the client certificate
* `EGEOFFREY_GATEWAY_KEYFILE`: if the gateway enforce client certificate authentication, the path of the certificate keyfile

You don't need to configure each variable: for a local installation, default settings just works, for a remote installation, the installer will guide through the process.

Since eGeoffrey has been made with multi-tenancy in mind you need to tell the gateway which house that specific module is serving. This is driven by the following environment variable, which are also used as username/password for authenticating against the gateway (in case the gateway enforce authentication which is not the default):

* `EGEOFFREY_ID`: your house identifier (default to `house`)
* `EGEOFFREY_PASSCODE`: your house passcode (default empty)

## Package Startup   

Upon startup, a special module called `watchdog` is executed. There will be only one watchdog for each package (each package can carry one or multiple modules). The watchdog, like any other module, connects to the gateway and does two things:

* Startup any module of the package in its own thread. Which module is part of the package is defined by the environment variable `EGEOFFREY_MODULES` which contains a list, comma separated of `<scope_name>/<module_name>` (e.g. `controller/logger, controller/config`)
    * since there are situations in which you may want to run the same module multiple times (e.g. you want to connect two speakers or you have two MySensors gateway), optional aliasing is allowed in the format `<scope_name>/<module_name>=<alias>`. In this way a module named `<scope_name>/<alias>` will be run based on the `<scope_name>/<module_name>` code
* Read all the files in the `default_config` directory
* Read the package' manifest file (`manifest.yml`) which contains information regarding the package, its version, the modules, their configuration, etc., append the default configuration files and publish it to the message bus so other components will know about these new components made available.

Once done, the watchdog goes to sleep but will promptly respond in case:

* A `DISCOVER` message is broadcasted and in this case the watchdog will respond with the list of modules it is currently managing
* A `START/<module>`, `STOP/<module>`, `RESTART/<module>` or `DEBUG/<module>` is received so to start, stop, restart of enable debug to one of its managed module. In this way a user can stop modules individually without having to restart the entire package.

## Module Startup   

When a module is started by the watchdog, it connects to the message bus as well. This is done independently since each module is now aware where it is running and if there are other components part of the same package.

What a module is supposed to do, is up to its author. As described in the Develop section, eGeoffrey provides a number of callback the developer can use to implement any custom logic. Generally speaking each module has:

* `on_init()`: which is called with the module is created and initialized by the watchdog
* `on_start()`: which is called when the module is fully configured (in case a specific configuration file is needed before starting)
* `on_stop(): which is called when the module is shutting down before the watchdog has been requested to do so or because the entire package is stopped
* `on_message(message)`: which is called when a new message addressed to this module is coming in
* `on_configuration(message)`: which is called when a configuration file requested by the module is coming in


## Advanced Settings

The following additional environment variables can control specific advanced settings:

* `EGEOFFREY_DEBUG`: enable debug (default `0`)
* `EGEOFFREY_VERBOSE`: enable verbose debug (default `0`)
* `EGEOFFREY_LOGGING_LOCAL`: print out log message to standard output (default `1`)
* `EGEOFFREY_LOGGING_REMOTE`: send any log message through the message bus to `controller/logger` for central logging (default `1`)
* `EGEOFFREY_PERSISTENT_CLIENT`: enable mqtt persistent connection



