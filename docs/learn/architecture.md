# Architecture

In a nutshell, eGeoffrey is made of different components (modules) which communicates through a message bus (the gateway) and distributed as Docker images (packages).

## Overview
The following minimum set of packages are required to make eGeoffrey running and are automatically deployed by the installer:

* `egeoffrey-gateway`: the message bus through which all the modules communicate
* `egeoffrey-database`: the database which stores information about your sensors
* `egeoffrey-controller`: the beating heart of eGeoffrey which takes care, among the other of orchestrating your sensors, running your rules, etc.
* `egeoffrey-gui`: the web user interface through which you can interact with eGeoffrey and configure it

With just these components eGoeffrey will be alive but just sitting there and doing nothing. Things get more interesting as you start adding additional packages. 

A Marketplace has been made available through the eGeoffrey's web interface or the website [https://marketplace.egeoffrey.com](https://marketplace.egeoffrey.com) to search for additional packages. Installation takes place through the `egeoffrey-cli` utility which is installed on your system.

Packages that can extend eGeoffrey are grouped in three categories:

* `notification` packages, which can be used to trigger notifications upon specific events (e.g. email, slack, etc.)
* `interaction` packages, which can be used to interact with eGeoffrey (e.g. with a microphone, through slack, etc.)
* `service` packages, which provides an interface with a specific device, protocol or service which are used to collect measures and values for your sensors or control your actuator (e.g. a weather service API, a zigbee device, etc.)

Each package has its own development lifecycle and should not have any requirement on other packages. This principle allow development and contributions to be quick and easy and immediately available to all the users without requiring any change to eGeoffrey's core code.

To avoid the user dealing with the complexity of Docker, eGeoffrey execution is managed through `docker-compose`. As an additional level of abstraction, to avoid users to manually configure the services and provide automatic configuration of the packages, a tool called `egeoffrely-cli` which is deployed upon installation that can be used to install new packages and manage existing one. 

## Tools

Since the entire architecture is based on Docker (which is great but not easy to use for all the users), a number of tools have are provided to provide abstract layers and hide any complexity. Specifically:

* `egeoffrey-cli`: deployed on the target system upon installation, which allows:
    * End users to search, install, uninstall any package and control eGeoffrey execution
    * Developers to commit changes to their packages and build the Docker images for distribution
* `egeoffrey-sdk`: embedded in each distributed package, that can be seen as:
    * a development kit which allows to build up a new module in minutes
    * a library which takes care of common tasks (e.g. connecting to the gateway, receving the configuration, etc.) exposing a simple-to-use API
    * a pre-built runtime environment upon which you can base your package on with most of the dependencies already installed

## Programming Languages

The ambitious of eGeoffrey is to be multi-language when needed. For this reason the communication takes place through a language-agnostic message bus and common capabilities can be delivered through language-specific SDKs. A the time of writing the following languages are supported:

* Python: used by all the modules
* Javascript: used by the web interface





