# The Mqtt_client Class

*Python SDK, Javascript SDK*

The Mqtt_client class takes care entirely of the communication of the module on the message bus by connecting to it, receiving and sending messages, reconnecting if the connection drops, etc. 

    Developers don't need to interact with Mqtt_client directly; this is part of Module which provides an additional abstraction
 
The following functions are provided:

* `publish(house_id, to_module, command, args, payload_data, retain=false)`: publish payload to a given topic (queue the message while offline)
* `unsubscribe(topic)`: unsubscribe from a topic
* `start()`:  connect to the MQTT broker and subscribed to the requested topics
* `add_listener(from_module, to_module, command, filter, wait_for_it)`:  add a listener for the given request
* `stop()`: disconnect from the MQTT broker
