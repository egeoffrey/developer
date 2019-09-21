# Design

This is a summary of the foundational principles that have been taken into account during the development of eGeoffrey.

## Why yet another Home Automation Suite?

There are hundreds of home automation suites around and dozens of new solutions made available every single day. So why yet another piece of software? 

First of all there are two big categories of software. Closed-source, vendor-dependent products which are good with a specific make and you don't know how much will cost in the future and until when will be supported and **open frameworks**, which can interact with a number of different devices, protocols, etc. but still keeping the same user experience. Whoever is looking for something in this latter category (where eGeoffrey lives) could have very different and peculiar requirements. This is because you have to deal with different technologies and formats and present data in a number of ways. 

eGeoffrey was born with **simplicity** and **flexibility** in mind. Start configuring the sensors you want to collect data from by leveraging the different services available (e.g. to collect weather statistics, images from the Internet, your GPS position, etc.). Once you have the data, what will be presented in the web interface is completely up to you. You can draw your own pages, configure the widgets and statistics that will be presented in the order you like the most. From the interface your actuators can be controlled as well.

You can also easily create rules to be automatically alerted whenever a specific situation is taking place, triggering a number of notifications means.

## Requirements

The main themes eGeoffrey's design was intended to address, in order of priority are the following:

1. **Robust and Modular Architecture**: ensure new releases and required 3rd party libraries run smoothly regardless of the hosting operating system and the libraries installed and new components can be easily added. 
2. **Run anywhere**: ability to run on different platforms, including cloud based providers with the ability to locate different components in different places
3. **Multi-tenancy**: ability to host multiple "houses" within the same eGeoffrey instance with authentication/authorization mechanisms
4. **Modern and easy to use UI**: to guide the users with dedicated wizards throughout the configuration process and with the ability to display any information in multiple ways to meet users' needs.

## Foundational Principles

The a technical standpoint, those have been the development principles guiding the direction of eGeoffrey:

* **Pack dependencies together with the software**
    * This avoids conflicts and/or missing packages issues
    * Docker ([https://www.docker.com/](https://www.docker.com/)) solves this problem since the application and all the dependencies are packed together
    * Simplifying the deployment since the user needs to just pull the image from Docker Hub
    * Updates are simplified as well leveraging docker's tags
    * Rollbacks are as easy as starting a container
    * Docker works fine even on Raspberry pi and has no problem with the little resources available
* **Architecture based on micro-services**:
    * Micro services (e.g. Docker images) can be easily updated, stopped or restarted
    * Users can easily contribute by adding a new component in the form of a micro service without the need to get into the code too much
    * Micro services can be tested in an easier way
    * Micro services can easily scale by adding additional containers
    * Micro services can be easily added/removed to eGeoffrey (plug&play)
* **Interaction of the different components takes place through a message bus**:
    * More flexible and powerful of traditional REST APIs
    * This applies to the web gui as well which would benefit from realtime updates upon subscribed topics
    * A lightweight pub/sub message bus like MQTT allows services in different locations to interact
    * The message bus helps overcoming any NAT constraint
    * The message bus allows multi-tasking (e.g. a request is sent to the bus and the service goes on) resulting in a more robust architecture and less delays
    * MQTT retain and QoS capabilities helps in increasing resiliency
* **Components have zero-knowledge about the others**:
    * they leverage the message bus to do discovery and configuration
    * allows adding a new pieces without any change to core code thus facilitating user to contribute
    * each component follows its own development cycle, no dependencies

