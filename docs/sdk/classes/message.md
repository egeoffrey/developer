# The Message Class

*Python SDK, Javascript SDK*

To provide an abstraction of the information exchanged in the bus without requiring the developer to deal with topics and messages' payload, any message received or sent is represented as a Message object. 

The following information are directly accessible for each instance of `Message`:

* `message.topic`: topic from which the message comes from, populated only for incoming messages
* `message.house_id`: house id
* `message.sender`: sender module
* `message.recipient`: recipient module
* `message.command`: requested command to execute
* `message.args`: arguments of the command
* `message.config_schema`: version of the schema of configuration file (if a configuration)
* `message.is_null`: set to true when payload is null (e.g. deleted configuration file)

The information above are automatically populated by the SDK when receiving a new message from the message bus or by the developer when sending out a new message.

Additionally, the following functions are provided:

* `reset()`: reset the message
* `clear()`: clear the payload only
* `parse(topic, payload, retain)`: parse MQTT message (topic and payload)
* `set_data(value)`: set the payload to value (value can be of any type, e.g. string, dict, etc.)
* `set(key, value)`: set key of the payload to value
* `set_null()`: set the payload to null
* `get(key)`: get the value of key of the payload
* `has(key)`: return true if payload has the given key
* `get_data()`: get the value of the payload
* `get_request_id()`: get the request_id
* `reply()`: reply to this message
* `forward(recipient)`: forward this message to another module
* `dump()`: print out the content of this message

