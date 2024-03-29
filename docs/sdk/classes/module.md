# The Module Class

*Python SDK, Javascript SDK*

To let developers focusing on creating useful modules and beautiful contents, the eGoffrey SDK is intended to make available any capability which could be common among modules in the Module class.

Just to name only a few, the following key functionalities are provided by the Module class:

- takes care of connecting to the eGeoffrey gateway
- provides a framework of callbacks to allow developers to react upon connection, discussion, starting, stopping, etc.
- provides common functionalities for communicating with other modules by publishing and receiving messages through the bus
- implements local and remote logging capabilities
- provides ad-hoc, specialized subclasses you can inherit from for each type of module and specifically:
  - A `Controller` class for controller modules
  - An `Interaction` class for interaction modules
  - A `Notification` class for notification modules which takes care of retrieving the module's configuration and receiving NOTIFY messages from the alerter so to invoke the callback `on_notify()` based on the user's configuration
  - A `Service` class for service modules which takes care of registering "push" sensors and scheduling "pull" sensors according to their configuration

## Callbacks

When developing a new module and inhering from one of `Module`'s subclasses, the following callbacks are made available:

- `on_init()`: what to do when initializing (subclass has to implement)
- `on_connect()`: what to do just after connecting to the gateway
- `on_start()`: what to do when start running - after receiving required configuration files if any (subclass has to implement)
- `on_stop()`: what to do when shutting down (subclass has to implement)
- `on_disconnect()`: what to do just after disconnecting from the gateway
- `on_message(message)`: what to do when receiving a new message (subclass has to implement)
- `on_configuration()`: what to do when receiving a new/updated configuration (subclass has to implement)

## Functions

The following functions are also provided when inhering from one of `Module`'s subclasses:

- `add_configuration_listener(args, version=None, wait_for_it=False)`: add a listener for the given configuration request (will call on_configuration())
- `add_request_listener(from_module, command, args)`: add a listener for the messages addressed to this module (will call on_message())
- `add_broadcast_listener(from_module, command, args)`: add a listener for broadcasted messages from the given module (will call on_message())
- `add_manifest_listener(self, from_module="+/+")`:  add a listner for broadcasted manifests (will call on_message())
- `add_inspection_listener(from_module, to_module, command, args)`: add a listener for intercepting messages from a given module to a given module (will call on_message())
- `remove_listener(topic)`: remove a topic previously subscribed
- `send(message)`: send a message to another module
- `log_debug(text) / log_info(text) / log_warning(text) / log_error(text)`: log a message
- `is_valid_configuration(settings, configuration)`: ensure all the items of an array of settings are included in the configuration object provided
- `sleep(seconds)`: wrap around time sleep so to break if the module is stopping
- `upgrade_config(filename, from_version, to_version, content)`: upgrade a configuration file to the given version