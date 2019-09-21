# The eGeoffrey Gateway

Communication between modules takes place ONLY through a message bus and Mosquitto MQTT has been selected as the preferred option.

To ensure a decent user experience, a pre-configured MQTT broker is provided in the package `egeoffrey-gateway`, which is automatically deployed by the installer. 

Modules connecting to the gateway can connect to port:

* `1883/tcp`: mqtt tcp protocol
* `8883/tcp`: mqtts tcp protocol
* `443/tcp`: websocket protocol

## Communication

To allow a structured communication among the modules, a topic naming convention is defined as follows:

    egeoffrey/<api_version>/<house_id>/<source_scope>/<source_module>/<to_scope>/<to_module>/<command>/<args>

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
* An `api_version` string allows different versions communicating through the same bus without interfering
* payload for each message is structured in a JSON format. The SDK provides an easy and simple way to deal with it by providing an abstraction of a message