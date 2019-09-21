# Updating

in eGeoffrey, each package has its own lifecycle, independent from the other so there is no concept of eGeoffrey update but each package can be updated individually. However, when running `egeoffrey-cli update`, the latest version of all the packages is downloaded and deployed.

### Updating the Package

For a user, updating an eGeoffrey package is as simple as pulling a docker image from Docker Hub. For developers this simply means building the new version of the package and letting the user updating it. There is no concept of automatic updates since users may want to ensure the newer version is not breaking up local dependencies they might have.

However, whenever the user connect to the eGeoffrey GUI, every deployed packages is checked for updates (by comparing the current deployed version from the package's manifest with the manifest on Github for the given branch). If there is a new version available, the user is told about it but no further action is performed (since the GUI would have needed access to the Docker socket and in a distributed or hosted environment this would not be allowed).

### Upgrading a Configuration File

In eGeoffrey, managing a configuration file is entirely under the responsibility of the package the configuration file is used by. From the user prospective, this is completely transparent since once the updated package is deployed, it will detect an old version of the configuration file, it will ugprade the schema and ask `controller/config` to save it and publish it again.

For developers this means keeping track of the configuration schema of files managed by the package and when receiving it.
The configuration schema is intended to help developers to evolve their configuration files independently from eGeoffrey. The schema version is automatically added by the config module in the filename when saving the file (e.g. `settings.1.yml` with schema version set to `1`) and is automatically added as part of the topic when publishing to the message bus.

Checking if dealing with the right version of the configuration file and updating it, is up to each individual module. If the configuration has a schema which is not supported, the module should discard the file. In case that configuration is "managed" by the module (e.g. its own configuration file), the module has to implement the logic to update the schema from the received message and invoke the SDK's `upgrade_config(filename, from_version, to_version, content)` to upgrade a configuration file to the given version. The config module will take care of deleting the old version, save the new version and republishing it on the bus.

### Upgrading the Database Schema

Should the database schema change across versions, the `controller/db` module will take care of upgrading it accordingly, no further action required.