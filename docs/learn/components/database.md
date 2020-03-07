# The eGeoffrey Database

To provide a controlled and structured access to the data, the only module which can access the database is `controller/db`. Queries have to be submitted in the same way eGeoffrey's modules traditionally communicates, e.g. through the message bus. `controller/db` will take care of executing the query returning the result back.

To ensure a decent user experience, a pre-configured database image is provided in the package `egeoffrey-database`, which is automatically deployed by the installer. 

**Redis** has been selected as the preferred option for storing eGeoffrey's data. This is because it is light and especially when running on a Raspberry Pi, does not stress the SD card too much with continuous writing operations.

The Redis database will accept connections on the following port:

* `6379/tcp`

As an alternative option, **MongoDB** is also supported by `controller/db` and is delivered by the `egeoffrey-database-mongodb` package. However, this options is intended for a complex ISP scenario when hosting multiple houses and Redis approach to keep everything in memory would come with a high cost. For a standalone, raspberrypi-based installation, Redis is always the way to go.

The MongoDB database will accept connections on the following port:

* `27017/tcp`

## Database Schema

eGeoffreys stores the following information in the database:

* **Sensors' data**: each sensor has one of more keys in the database in the format `eGeoffrey/sensors/<sensor_id>/<aggregation>`. Since eGeoffrey has the capability to automatically calculate aggregated statistics (e.g. hourly and daily averages, max, min, etc.), this is appended at the end (e.g. `eGeoffrey/sensors/temperature/day/avg`)
* **Notifications**: whenever a rule triggers and a notification is sent out, the database keep track of it. This also includes every new value when is set to a sensor. The format of the key is `eGeoffrey/alerts/<severity>`
* **Logs**: eGeoffreys logs are stored in the database as well. The format of the key is `eGeoffrey/logs/<severity>
* **Version**: eGeoffreys database schema version which is used for upgrading the database schema when needed. The format key `eGeoffrey/version

The `house_id` is not used as part of the database schema for two reasons:

* each house is supposed to have its dedicated database
* renaming the `house_id` would not require renaming all the keys