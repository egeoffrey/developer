
Any eGeoffrey code is started with the following command:

```
python -m sdk.python.module.start
```

Upon startup, a special module provided by the SDK called `watchdog` is executed. There will be only one watchdog for each package (each package can carry one or multiple modules). The watchdog, like any other module, connects to the gateway and does two things:

* Startup any module of the package in its own thread. Which module is part of the package is defined by the environment variable `EGEOFFREY_MODULES` which contains a list, comma separated of `<scope_name>/<module_name>` (e.g. `controller/logger, controller/config`)
    * since there are situations in which you may want to run the same module multiple times (e.g. you want to connect two speakers or you have two MySensors gateway), optional aliasing is allowed in the format `<scope_name>/<module_name>=<alias>`. In this way a module named `<scope_name>/<alias>` will be run based on the `<scope_name>/<module_name>` code
* Read all the files in the `default_config` directory
* Read the package' manifest file (`manifest.yml`) which contains information regarding the package, its version, the modules, their configuration, etc., append the default configuration files and publish it to the message bus so other components will know about these new components made available.

Once done, the watchdog goes to sleep but will promptly respond in case a discover message is broadcasted (to which will respond with the list of modules it is currently managing) or to start/stop/restart/enable debug on the modules it is responsible for.

## Module Startup

When your module is started by the watchdog, it connects to the message bus as well. This is done independently since each module is now aware where it is running and if there are other components part of the same package.

What a module is supposed to do, is up to its developer and is controlled by what has been implemented in the different callbacks made available through the SDK such as:

* `on_init()`: which is called with the module is created and initialized by the watchdog
* `on_start()`: which is called when the module is fully configured (in case a specific configuration file is needed before starting)
* `on_stop()`: which is called when the module is shutting down before the watchdog has been requested to do so or because the entire package is stopped
* `on_message(message)`: which is called when a new message addressed to this module is coming in
* `on_configuration(message)`: which is called when a configuration file requested by the module is coming in