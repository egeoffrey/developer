# Deployment Options

A lot of effort has been made to allow eGeoffrey to be deployed many different ways. Its distributed architecture made of isolated components interacting through a shared message bus, allows to position each component on any platform and wherever you need.

## Local Deployment

The simplest and most common deployment options is on-prem, running on a Raspberry Pi device or your house server. In this scenario all the components (controller, gui, gateway, database, notification modules, etc.) are running within the same environment interacting through the message bus. This of course is transparent to the user. 

The `egeoffrey-cli` takes care of managing the docker runtime environment by creating a single `bridge` network where all the containers live.

## Remote Deployment

You may think of distributing eGeoffrey's components in different places according to your needs. A potential scenario is with a server hosted by some Cloud provider running eGeoffrey's components which do not need to interact with local devices you may have at home and the others running on-prem. Since the message bus is shared (hosted in the cloud in this case), the user will enjoy the same user experience, without even the need to open ports on the firewall or other complex configurations.

If the Cloud environment is publicly accessible, we strongly encourage to secure the eGeoffrey gateway by enabling authentication and ACLs and if possible SSL. All the other components do not need to be further secured since living hidden behind the scene.

If you are familiar with Docker Swarm or Kubernetes you have to leverage them manually since `egeoffrey-cli` only supports running with `docker-compose`. 

## Distributed Deployment

This is an extension of the previously described remote deployment but instead of having a central location and some components running on your house you can have components distributed in multiple geographically distributed locations (e.g. collect data from multiple houses). As far as all the houses are connecting to the same gateway, it will work nicely

## eGeoffrey-as-a-service

Another variant of a distributed deployed is by offering eGeoffrey as a service. In this scenario the deployment would be the same as described above with additional considerations you can read in the Multi-Tenancy page.