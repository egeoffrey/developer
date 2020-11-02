
In eGeoffrey, what eventually the end user runs is a set of Docker images, one for each installed package. To avoid the user to run individual containers manually with tons of options, eGeoffrey execution is orchestrated through `docker-compose`. 

As an additional level of abstraction, a tool called `egeoffrely-cli` which is deployed upon installation is provided to install new package, manage intalled packages as well as starting and stopping eGeoffrey without the need to edit any configuration file by hand. The CLI will take care of editing eGeoffrey's configuration for you and customizing the container according to the author's instructions.

Each package has its own development lifecycle and should not have any requirement on other packages. This principle allow development and contributions to be quick and easy and immediately available to all the users without requiring any change to eGeoffrey's core code.

## Startup Configuration

Which packages to run and instructions on how to connect to the Gateway,are stored in the following two files:

* `docker-compose.yml`: which contains a list of packages that are run upon startup
* `.env`: which contains environment variables common to all the packages (e.g. gateway location, house id, etc.)

Those reside in the directory you chose to install eGeoffrey into. Once again, you don't need to edit the files manually: the installer or at a later stage `egeoffrey-cli`, will guide through the process.

Since by definition Docker containers are stateless, packages which need a persistent storage are configured to store their files (configuration, logs, etc.) into the `data` folder, residing once again in the directory you chose to install eGeoffrey into.

## Starting eGeoffrey

When running `sudo egeoffrey-cli start`, each of the configured eGeoffrey package installed by the user will be run in independent Docker containers. 
