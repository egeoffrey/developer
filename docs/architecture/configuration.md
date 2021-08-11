
The configuration of any eGeoffrey module is managed by `controller/config`.  This is because in a distributed deployment you may want to keep the configuration of all your components in a single location, regardless the modules originating the file and which one is using them. 

## Publish the Configuration

As anything else in eGeoffrey, also configuration distribution is happening through the message bus. This allows modules to subscribe to the configuration they are expecting and configuration changes handled without the need to restart the module since it will receive a configuration callback once an updated file is re-published.

Upon startup, the `controller/config` reads out all the files in the `config` directory and publishes them on MQTT with the same structure and according to these principles:

* The config module has zero-knowledge about which module needs which file and which settings each file has to have. This is up to the receiving module
* Configuration files are in a YAML format
* Subdirectories make up the topic structure. The filename will be the last part of the topic, with the extension removed (e.g. a file in `subdir/dir/filename.yml` will be published in the topic `subdir/dir/filename`
* Files beginning with dot (.) or without a .yml extension are ignored
* Configuration is published under a CONF command. This prevents conflicts with other messages
* When using gateway protocol v1, publishing have "retain" flag set so the configuration is always available for the module service subscribing that topic (no matter when it starts, it will receive the configuration straight away). If using protocol v2, the configuration is not retained on the message bus and the SDK takes care of distributing the configurations required by each module
* The latest version only of each configuration file is kept on the bus

## Receive the Configuration

Any module which needs a configuration file, has to subscribe to a specific topic. The eGeoffrey SDK makes this easier, providing the following functions from within the Module class:

* `add_configuration_listener(args, version=None, wait_for_it=False)`: add a listener for the given configuration request (will call on_configuration())
* `add_request_listener(from_module, command, args)`: add a listener for the messages addressed to this module (will call on_message())
* `add_broadcast_listener(from_module, command, args)`: add a listener for broadcasted messages from the given module (will call on_message())
* `add_inspection_listener(from_module, to_module, command, args)`: add a listener for intercepting messages from a given module to a given module (will call on_message())
* `remove_listener(topic)`: remove a topic previously subscribed

Once the listener is added, the configuration will be received in the `on_configuration(message)` callback.

## Validate the Configuration

`controller/config` just ensure the file is in a valid YAML format but is up to the receiving module to validate the file. eGeoffrey SDK makes available `is_valid_configuration(settings, configuration)` to ensure all the items of an array of settings are included in the configuration object provided. 

Returning `false` from a configuration message received by `on_configuration(message)` will instruct the module to just ignore the file.

## Required Configuration Files

There are situations in which a module needs a specific configuration file before starting. For example the database module has to know where the database is before connecting. 

When a configuration listener is added with `wait_for_it` set to true, the module will not start (hence `on_start()` will not be called) until ALL the required configurations have been received.

## Default Configuration

Since `controller/config` has no knowledge of which modules are running and which versions they are at, it cannot bring any default configuration with it, which is instead delegated to individual packages. Developers can add a `default_config` directory in the root of their package directory and copy there any configuration file they want, with the same format of standard configuration files. 

In this way, when the package starts, the watchdog module will read the content of all the files in this directory, attach it to the package manifest and publish it. The config module subscribed for receiving new manifests being published so when this happens and if `default_config` is in the manifest, it re-create the entire directory structure locally (unless the given file already exists) before publishing the new files as part of eGeoffrey's configuration. 

This approach allows to:

* delegate developers to control of their own configuration files
* centralize the configuration even if the components can live in different places
* distribute out-of-the-box contents together with each package


## Save/Update a Configuration

Through specific messages, the config module can save new or updated configuration files. To avoid reloading the entire configuration upon each change, the config module builds up an index of all the files which is saved in the message bus so to re-publish only new or updated files. When a file is deleted, a message with `null` payload is published to the bus.

