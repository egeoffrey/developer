
In eGeoffrey, each package has its own lifecycle, independent from the other components so there is no concept of an eGeoffrey update but each package can be updated individually. For this reason, when you want to release an updated version of your code, simply re-iterate the steps detailed in [Develop & Build](/develop/develop/) to publish an updated version of your package. Since a package is delivered as a Docker image, each version is a self-contained, stateless instance of your code, with all the required dependencies packed together.

At every commit of your code, the revision number will be automatically increased. Please review the [eGeoffrey Versioning](/architecture/versioning/) page for more details on the versioning capabilities.

End users will be notified a new version is available and will upgrade accordingly. An end user can update all the installed packages by running `egeoffrey-cli update` or a given package with `egeoffrey-cli <package_name>`. A `sudo egeoffrey-cli start` is then required to make the newly downloaded image up and running.

There is no concept of automatic updates in eGeoffrey to prevent users from breaking up local dependencies they might have.

## Upgrading a Configuration File

Despite each eGeoffrey package is stateless, it could require one of more configuration files to run. The `controller/config` module is reponsible [configuration management](/architecture/configuration/) and for storing the configuration file of EVERY eGeoffrey component but managing those files follows a decentrilized approach which is under the responsibility of the package the configuration file has been generated. 

If for example your module brings in a new configuration file, it will be also responsible to upgrade its content whenever required. To do so, each configuration file is associated with a "schema version number". The schema version is automatically added by the config module in the filename when saving the file (e.g. `settings.1.yml` with schema version set to `1`) and is automatically added as metadata to the configuration when publishing it to the message bus. It is your module responsability, whenever receiving a configuration file, to:

* If the configuration file is "managed" by your module (e.g. its own configuration file), to check the schema version number and if required (e.g. the expected version number is higher than the file version number) update file's content and version by using the provided SDK's `upgrade_config(filename, from_version, to_version, content)`.
* If the configuration file is not managed by your module (e.g. a sensor or a rule), to ensure the schema version number is the one you expect and support

