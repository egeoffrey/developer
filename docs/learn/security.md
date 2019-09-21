# Security

The design choice has been to have a (strong) layer enforced by the mqtt broker for every module belonging to the same house and second (weaker) layer to handle users within the same house implemented within the application.

* This avoids creating a new MQTT user for every new user in the house since eGeoffrey has no access to MQTT configuration
* allow implementing additional capabilities delegating to e.g. house admin users complete control over their user base, setting/resetting passwords etc. 
* Despite users' security is enforced only at the application layer, this is still only related to the isolated house

##  Modules

Each module connecting to message bus has to know at least the gateway location and optionally how to authenticate against it. This means the authentication and authorization logic lives outside eGeoffrey since it is in charge of the message bus.

### Authentication

* Since eGeoffrey's main use case is when deployed in a secure, controlled environment (e.g. local LAN), by default no authentication is enforced
* Each module authenticates against MQTT using the `house_id` as username and an optional password
    * all the modules share the same credentials to allow ease of use but still maximum isolation between houses
    * For an open MQTT broker with no restrictions, authentication works in the same way (username/password is not enforced by the broker)
    * An admin interested in hosting multiple houses has to configure a new user in MQTT only once when a new house is added
    * Advanced users can configure the MQTT broker to enforce authentication with username/password, client certificate or client_id prefix. All of those are supported by eGeoffrey

### Authorization

* by default no ACL is enforced; however eGeoffrey's SDK silently discard any message whose recipient is a different house the one is taking care of
* An admin interested in isolating multiple houses running on the same broker can enforce a single, simple ACL which will restrict access based on username (e.g. the house_id): `pattern readwrite egeoffrey/+/%u/#`

### Confidentiality

* By default, modules connect to the gateway over an insecure websocket connection over port 443/tcp
* If you need to ensure confdentiality of the data transmitted by the modules to the gateway, either enable SSL to the websocket listener or make them connecting to the secure MQTTS port 8883/tcp. To do so, set in your `.env` file:
    * `EGEOFFREY_GATEWAY_PORT=8883`
    * `EGEOFFREY_GATEWAY_TRANSPORT="tcp"`    
    * `EGEOFFREY_GATEWAY_SSL=1` 

##  Users

This is referring to users operating within the same house accessing the web GUI.

### Authentication

* the web gui tries first to connect to the MQTT broker residing at the URL the user is visiting without authentication (the default). If it fails (broker elsewhere? username/password required?) shows up a login page requesting the user the gateway hostname, port, house_id, house passocde and, username and password.
* The latter (username and password) are stored in the `gui/users.yml` configuration file. Password is not secured (clear-text) since this is belonging to the weaker layer of security and authentication is happening on the client side. 
* Users can be managed entirely from within the eGeoffrey web interface.
* By default the following two users are available:
    * `guest / <no password>`: guest user (belongs to the `guests group)
    * `admin / admin`: admin user (belongs to the `house_admins` and `egeoffrey_admins` groups)

### Authorization

* eGeoffrey defines groups in the `gui/groups.yml` configuration file. A user can be part of multiple groups. The following groups are defined but a user can add additional groups:
    * guests: can access all the pages of the web interface but the admin pages
    * house_admins: can access all the pages of the web interface as well as configure the house, its sensors and rules
    * egeoffrey_admins: can access all the pages of the web interface, configure the house and manage eGeoffrey (list installed packages and modules, review logs, access the marketplace, etc)
* Authorization is enforced client-side in the web interface
* admin users can restrict access to individual widgets or entire pages by granting access only to specific groups

### Confidentiality

* By default, the web gui application connect to the gateway over an insecure websocket connection over port 443/tcp
* If you need to ensure confidentiality of the data transmitted by the modules to the gateway, enable SSL to the websocket listener (mqtts is not supported by the javascript library). Ensure the certificate to be valid

##  Database

Ideally the database should be shared among different houses. But since Redis does not provide (yet) neither strong authentication mechanism nor ACLs, every house will have its own dedicated database server hence no authentication would be required.

