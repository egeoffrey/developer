# Definitions
    
Provided below are a list of key concept around eGeoffrey's internals:
    
* A **module** is defined as the code of a functional unit.
    * e.g. the component that periodically checks if your rules are triggering (alerter) is a module. The component which queries the weather service for the current temperature is another module, etc.
    * each module belongs to a **scope**, defined as a group of modules. The following scopes are identified:
        * `controller`: modules part of the eGeoffrey core (e.g. interact with the database, collect data from sensors, run alerting rules, etc.)
        * `interaction`: modules responsible for interacting with the user (e.g. through Slack, a microphone, etc.)
        * `notification`: modules responsible for notifying the user about something (e.g. through email, slack, text messages, etc.)
        * `service`: modules responsible for interfacing with a specific device or protocol to retrieve data or control actuators (e.g. a weather service, a webcam, a MySensors device, Zigbee protocol, etc.)
        * `gui`: modules responsible for running the eGeoffrey GUI
        * `system`: reserved for system components (e.g. the watchdog modules)
    * modules' naming convention is `<scope_name>/<module_name>` so e.g. valid names are `controller/alerter`, `service/image`, etc.
    * A module may live or not in an independent container
    * each individual module connects independently to the message bus and can communicate with the other only through it (even if living just aside)
* A **package** is defined as  one or more modules built together into a Docker image
    * each package has a manifest file describing what's inside
    * it usually maps to a Github repository
    * packages' naming convention is `egeoffrey-<package_name>` where package_name can be:
        * a built-in eGeoffrey component (e.g. `egeoffrey-database`)
        * a package mapping to single module (e.g. `egeoffrey-service-image`)
        * a collection of multiple modules (e.g. `egeoffrey-collection-raspberrypi`)
* A **sensor** is defined as a dataset, a logical container of one or more values.
    * it can hold just a single piece of data or a timeseries
    * Sensor's values can come from an associated service (e.g. a url with an image, a command to run, etc.), from actions triggered by a rule or from your interaction with widgets on the web interface
    * a sensor is made of a `sensor_id` (e.g. the way the user references it) and additional information like retention policies, associated services, etc.
* A **rule** is defined as a set constants (e.g. static values) and variables (e.g. values coming from sensors) combined in conditions. Notifications are generated whenever a configured rule triggers.
* A **gateway** is the eGeoffrey component through which all the modules connect to and exchange information by leveraging the publish&subscribe approach.