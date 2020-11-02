
1. **Edit your code** by opening in your repository the file `service/example.py` (since in this example we are creating a "service" called "example") and implement the logic of your module within the [SDK callbacks](/sdk/classes/module/) below:
    * Define in `on_init()` what to do when the module is initialized (e.g. initializing variables, requesting configuration files, etc.)
    * Define in `on_start()` what to do when the module is started after having received the required configuration files (e.g. connect to a serial port)
        * For sensors configured in "push" mode, whatever process you are running it is supposed to associate incoming data with registered sensors and send to `controller/hub` a message with `IN` as "command" and the sensor_id as "args" with a payload "value" set to whatever value you want to associate to the sensor (e.g. its new measure)
    * Optionally define in `on_stop()` what to do just before the module is shutting down (e.g. disconnect from a serial port)
    * Define in `on_configuration()` what to do when receiving a new/updated configurations, if requested a configuration file in `on_init()`:
        * If receiving a configuration file you directly manage (e.g. created by your module), check if needs to be updated since you don't know which version of your code it was previously running
        * If implementing a "service", register/unregister the sensors associated with your module through `register_sensor()/unregister_sensor()`
            * sensors configured in "pull" mode will be automatically scheduled based on their configuration
    * Optionally define in `on_message(message)` what to do when receiving a new message from the bus
        * For sensors configured as "pull", a message with `command` set to `IN` will be received containing the configuration of the sensor which needs to be polled. Your code is expected to reply to the message with a payload "value" set to whatever value you want to associate to the sensor (e.g. its new measure)
        * For sensors configured as "actuators", a message with `command` set to `OUT` will be received containing the configuration of the sensor which needs to actuated upon. 
    * For `notification` modules only, define in `on_notify()` what to do when receiving a new notification
1. Open and **customize the [manifest file](/sdk/manifest/)**:
    * Edit the description of the package, the tags (space-separated), the icon and the description of the module
    * Ensure the links to the repositories on GitHub and DockerHub are correct (format is `<username>/<repository_name>`)
    * If your module requires a configuration file (e.g. containing the serial port it has to connect to), add a `module_configuration` to your module providing its configuration directives. This will be used by the GUI to render the configuration wizard.
    * If your module is a "Service", for each of "pull", "push", "actuator" mode (depending which mode the service supports) add a `service_configuration` providing the directives the GUI will use to render the wizard when a sensor is associated to this module
    * Optionally add a `container_config` directive if you want to instruct `egeoffrey-cli` to customize the container configuration when installing the package (e.g. by mapping the physical serial port to the container)
    * If for any reason you need to build against a specific version of the SDK, add a `sdk_branch` directive
1. **Customize the `Dockerfile`** file in the root directory of your repository which will be used by the build process to create the the target Docker image which will ultimately responsible for running your code:
    * Select the appropriate [SDK base image](/sdk/use/) in the `FROM` directive
    * Point out any Python dependencies to be installed in the target cointainer (`RUN pip install <package_name>`)
    * Point out any Operating System dependencies to be installed in the target cointainer (with `apt-get` or `apk` depending on the base image selected)
    * Optionally add any customization to the target image with additional `RUN` directives
    * Optionally add a file called `docker-init.sh` into `$WORKDIR` if you need to run any custom commands within the container just before starting your eGeoffrey module
1. Optionally place any **default configuration files** in the `default_config` directory in YAML format with a `yml` extension (for more information see the [Configuration Management](/architecture/configuration/) page). Those will be retrieved by `controller/config` once your module connects to the gateway and saved with the other configuration files so please ensure to create them in a directory structure compliant with the configuration module.
1. **Commit the changes** to your code with e.g. `egeoffrey-cli commit "<comment>"`. This will automatically:
    * Commit the chances to the local repository
    * Push the new code to the remote repository on GitHub
    * Trigger a GitHub Action which will:
        * Test your eGeoffrey module code
        * Package it in a Docker image for multiple CPU architectures
        * Publish the images to your Dockerhub account for distribution
1. **Verify the images** are available in your DockerHub account. In case of failure in the build process, you should receive an email notification
