# The eGeoffrey Web UI

The eGeoffrey gui package provides a modern and responsive web interface to both access your data and manage eGeoffrey. 

Despite some peculiarities, its logic is the same as any other module, that is connects to the message bus, receive its configuration and deliver its services to the end user. In this way the GUI does not rely on any REST API interface and is completely static: the entire logic is coming from the message bus and the house-specific configuration.

The package `egeoffrey-gui` includes a single module:

* `gui/webserver`: which runs a nginx webserver hosting the static pages of the GUI

Once the user connects to the GUI, if the house is configured to require authentication, a login screen is presented and the following information is requested:

* Gateway hostname, port and, if SSL is enabled (where is the gateway and how to connect to it)
* House ID and Passcode (how to authenticate against the gateway)
* Username and password (which web interface user to login to). By default the following two users are available:
    * `guest` / `<no password>`: guest user
    * `admin` / `admin`: admin user

## Advanced Settings

The following additional environment variables can control specific advanced settings:

* `EGEOFFREY_LOGIN_DISCLAIMER`: an optional login disclaimer to be shown on top of the login screen
* `EGEOFFREY_LANGUAGE`: default language of the web interface
* `EGEOFFREY_GUI_*`: override any `EGEOFFREY_*` variable set in the gui module
