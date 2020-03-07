# Multi Tenancy

Having the ability to run multiple houses is key and a differentiator for eGeoffrey. This allows to easily host multiple users within  the same environment or even deliver eGeoffrey-as-a-service to multiple house. To ensure maximum isolation, confidentiality of the data and flexibility to run different versions of the software for each house, the following approach has been adopted.

## Gateway

The gateway component is supposed to be common among multiple houses. 

* The topic structure allows to easily isolate logically individual houses (provided of course they have a different `house_id`)
* Since the same `house_id` and `passcode` (username and password for the gateway) is used for all the modules belonging to the same house, the service provider has add a single user to the gateway to provide a new house
* The gateway's ACLs can prevent a user to see what's happening inside a different house. Additionally ACLs can be set based on username so the service provider needs to maintain only a single ACL with the username wildcard

## Modules

Every house will run its own dedicated modules (including the Web UI) connecting to a shared gateway. This choice has been taken to achieve the following:

* Code simplicity since every module should keep otherwise a map between the house and its entire runtime environment and challenges in distinguishing between shared modules and house-dedicated modules in the communication
* Users can restart their own components without affecting all the houses which could have suffered a downtime otherwise
* Possibility for managing entitlements for every house (e.g. a given house can have only a portion of the services of another house)
* Ability to measure how much resources a house is using - useful in a consumption-based scenario
* Simplify debug and troubleshoot (how to understand which house is causing an excessive load on a shared service)
* Scalability (e.g. how to scale a shared service with all the houses having the same resources available)
* Multi-version support
* Isolation and increased security

## Database

Since Redis does not provide robust authentication/authorization mechanisms for this scenario, either use a different redis database for each house or use a single, shared MongoDB database. In this scenario each database map to a different house. It is up to the admin to provision users to MongoDB, ideally assigning a dbAdmin role only for the assigned database (e.g. the house_id) to the user.



