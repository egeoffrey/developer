
## Core Components

The following minimum set of packages are required to make eGeoffrey running and are automatically deployed by the installer:

* [egeoffrey-gateway](/architecture/core/gateway/): the message bus through which all the modules communicate
* [egeoffrey-database](/architecture/core/database/): the database which stores information about your sensors
* [egeoffrey-controller](/architecture/core/controller/): the beating heart of eGeoffrey which takes care, among the other of orchestrating your sensors, running your rules, etc.
* [egeoffrey-gui](/architecture/core/gui/): the web user interface through which you can interact with eGeoffrey and configure it

With this minimal configuration, `egeoffrey-gateway` provides the message bus all the other packages will use to communicate with each other, `egeoffrey-controller` takes care of running most of eGeoffrey's core tasks storing configured sensors' values into the database provided by `egeoffrey-database` and finally `egeoffrey-gui` offers the web interface for both end users and eGeoffrey admins.   

## Extending eGeoffrey

With just core components eGoeffrey will be alive but just sitting there and doing nothing. Things get more interesting as you start adding additional packages. 

Packages that can extend eGeoffrey are grouped in three categories:

* `notification` packages, which can be used to trigger notifications upon specific events (e.g. email, slack, etc.)
* `interaction` packages, which can be used to interact with eGeoffrey (e.g. with a microphone, through slack, etc.)
* `service` packages, which provides an interface with a specific device, protocol or service which are used to collect measures and values for your sensors or control your actuator (e.g. a weather service API, a zigbee device, etc.)

A Marketplace has been made available through the eGeoffrey's web interface or the website [https://marketplace.egeoffrey.com](https://marketplace.egeoffrey.com) to search for additional packages. Installation takes place through the `egeoffrey-cli` utility which is installed on your system. If you develop a new package. this can be easily made available to other users by publishing it on the eGeoffrey Marketplace.