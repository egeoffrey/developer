# The Manifest File

A manifest file has to be part of every eGeoffrey package. The manifest file is located in the root directory of the package and called `manifest.yml`.

The manifest accomplishes different functions:

* Provides an overview of the package's contents, its version and the modules part of the package
* Includes default configuration files that will be automatically sent to `controller/config` upon startup
* Provides a link to the Github repository where the package resides so to allow checking if new versions are available
* Provide details for the presenting the package in the Marketplace
* Instruct `egeoffrey-cli` on how to customize the docker runtime environment for the service (e.g. mapping local volumes, exposing ports, etc.)
* For each module, provide a schema of the configuration file so to allow the GUI to build up the wizard
* For each service, provide a schema of the service configuration so to allow the GUI to build up the wizard when a sensor is associated to this service 

## Manifest Schema (v2)

The manifest contains the following information:

* `manifest_schema`: the number of the manifest schema
* `package`: the name of the package
* `branch`: the branch where the code belongs to
* `version`: the version of the package (e.g. 1.0, master, etc.)
* `revision`: the revision number (e.g. 22)
* `github`: the Github url in the format `<username>/<repository>`
* `dockerhub`: the Docker Hub url in the format `<username>/<repository>`
* `tags`: list of tags, separated by space
* `icon`: fontawesome icon for this package
* `modules`: an array of the modules available within the package. For each module:
    * `description`: description of the module (*optional*)
    * `module_configuration`: array representing the schema of the configuration file having the same name of the module that the gui will use to render the configuration wizard (*optional*)
        * `name`: name of the setting (key)
        * `description`: description of the setting
        * `format`: format of the setting
        * `required`: if required
        * `placeholder`: placeholder text
    * `service_configuration`: for each of `pull`, `push`, `actuator` (depending which mode the service supports), an array representing the schema of the service configuration request that the gui will use to render the wizard when a sensor is associated to this module (*optional*)
        * `name`: name of the setting (key)
        * `description`: description of the setting
        * `format`: format of the setting
        * `required`: if required
        * `placeholder`: placeholder text
* `container_config`: object that `egeoffrey-cli` will merge with the `docker-compose` service definition 
* `minimum_sdk_version`: the minimum version of the SDK (with or without revision) the package requires to run (*optional*)

When the watchdog reads a manifest file, before publishing it, it adds the following entries:

* `default_config`: mapping for each file in the `default_config` directory (if any) the file's content
* `sdk`: the SDK manifest file
