# The eGeoffrey Gateway

Communication between modules takes place ONLY through a message bus and Mosquitto MQTT has been selected as the preferred option.

To ensure a decent user experience, a pre-configured MQTT broker is provided in the package `egeoffrey-gateway`, which is automatically deployed by the installer. 

Modules connecting to the gateway can connect to port:

* `1883/tcp`: mqtt tcp protocol
* `8883/tcp`: mqtts tcp protocol
* `443/tcp`: websocket protocol

As an alternative option, **VerneMQ** is also supported and is delivered by the `egeoffrey-gateway-vernemq` package. However, this options is intended for a complex ISP scenario when hosting multiple houses since allows more granular access control and monitoring capabilities.

## Communication

To allow a structured communication among the modules, a topic naming convention is defined as follows:

    egeoffrey/<protocol_version>/<house_id>/<source_scope>/<source_module>/<to_scope>/<to_module>/<command>/<args>

This approach allows to:

* have 1:1 communication between modules without overlapping and without knowing if a module exists or not. 
* have 1:n communication, with destination that can be set to "*" (e.g. notification sent through different channels published once and different output services subscribing to the notification topic)
* Each module can publish only on its own topic and should subscribe other modules' topics
    * E.g. `controller/hub` request temperature to `service/openweathermap` publishes the request on `egeoffrey/v1/1/controller/hub/service/openweathermap/IN/<sensor_id>` and subscribe to `egeoffrey/v1/+/service/+/controller/hub/#` so to receive responses from all the modules
* `command` helps distinguishing among different requests in a structured way
* `args` can be used as a sort of sub-request
* controller modules (eGeoffrey's core component) have zero knowledge about the services and their names, they just subscribes to the output of any service
    * This allows adding a new service without any change to core code
* `house_id` allows having multiple houses running on the same gateway and optionally setting ALCs to isolate houses/users one from the other
* An `protocol_version` string allows different versions communicating through the same bus without interfering
* payload for each message is structured in a JSON format. The SDK provides an easy and simple way to deal with it by providing an abstraction of a message

## Gateway Protocol

A gateway protocol is the way modules communicate to each other through the message bus provided by the eGeoffrey gateway. Please note, this is not something related to the MQTT gateway itself, rather the application layer built into the SDK and used by eGeoffrey components to interact. All the modules connecting to the gateway has to be configured with the same protocol for communication to take place.
The gateway protocol in use is controlled by the `EGEOFFREY_GATEWAY_VERSION` variable which can be set also by `egeoffrey-cli` (e.g. `egeoffrey-cli set_env EGEOFFREY_GATEWAY_VERSION <version>`)
This is once again completely transparent for the user since the underlying SDK will take care of handling the entire process, once the gateway version is set.

#### Version 1

Modules expect to find the entire configuration pinned (retained) on the message bus. This is perfectly fine for a local gateway but not ideal when using a Cloud Gateway because the whole configuration is supposed to be kept in memory and data of house no more in use are kept there forever, making the service not really scalable.

#### Version 2

No configuration is unsolicited published to the bus by `controller/config` which will instead send the configuration over to every module requesting it. 
Version 2 requires packages be built against SDK >= v1.1, egeoffrey-controller >= v1.4 and egeoffrey-gui >= v1.4.

## Advanced Settings

The following additional environment variables can control specific advanced settings:

* `EGEOFFREY_GATEWAY_ACL`: if ACLs on the gateway have to be enabled
* `EGEOFFREY_GATEWAY_USERS`: set users and passwords for accessing the gateway (in the format user1:password1\nuser2:password2)

Additionally an eGeoffrey gateway can be connected (briged) to a remote gateway so that messages sent on one broker will be propataged to another borker and viceversa:

* `REMOTE_EGEOFFREY_GATEWAY_HOSTNAME`: the hostname or ip address of the remote gateway
* `REMOTE_EGEOFFREY_GATEWAY_PORT`: the port of the remote gateway
* `REMOTE_EGEOFFREY_GATEWAY_SSL`: if the remote gateway supports SSL
* `REMOTE_EGEOFFREY_ID`: username for the remote gateway
* `REMOTE_EGEOFFREY_PASSCODE`: password for the remote gateway
