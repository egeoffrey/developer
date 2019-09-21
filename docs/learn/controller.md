# The eGeoffrey Controller

The eGeoffrey controller manages the configuration of all the modules and coordinates sensors and run alerting rules. 

The controller itself is logically split in different modules:

* `controller/alerter`: keep running the configured rules which would trigger notifications
* `controller/chatbot`: interactive chatbot service
* `controller/config`: stores configuration files on behalf of all the modules and makes them available
* `controller/db`: connects to the database and runs queries on behalf of other modules
* `controller/hub`: hub for collecting new measures from sensors
* `controller/logger`: takes care of collecting the logs from all the local and remote modules, storing them in the database and printing them out

Each module may required a configuration file whose content is detailed on [https://github.com/egeoffrey/egeoffrey-controller](https://github.com/egeoffrey/egeoffrey-controller)

## API

Each controller module interacts with any other module through the message bus, despite where it resides; for this reason a structured communication protocol has been developed. A user doesn't need to know anything about it since hidden under the hood. Even a developer doesn't need to get into these details since the SDK is taking care of this low level communication.

For each module, the main `<command>` and their purposes will be listed below for both inbound and outbound requests (for the latter the recipient module is also listed):

* `controller/alerter`: 
    * inbound: 
        - `RUN/<rule_id>`: run manually a given rule
    * outbound: 
        - `controller/db` - `GET*/<sensor_id>`: request the database for sensors' data
        - `controller/hub` - `SET/<sensor_id>`: set the value to a sensor as an action to execute when a rule trigger
        - `controller/hub` - `POLL/<sensor_id>`: poll the sensor for a new value as an action to execute when a rule trigger
        - `controller/alerter` - `RUN/<sensor_id>`: action to execute when a rule trigger
        - `controller/db` `SAVE_ALERT/<severity>`: save notification to db
        - `*/*` - `NOTIFY/<severity>/<rule_id>`: notify output modules
        - `controller/db` - `PURGE_ALERTS`: periodically purge old alerts from db
* `controller/chatbot`:  
    * inbound: 
        - `ASK`: receive request from other modules
    * outbound: 
        - `controller/alerter` - `RUN/<rule_id>`: run a rule
        - `controller/db` - `GET/<sensor_id>`: request value of a sensor to the database
* `controller/config`:
    * inbound: 
        - `SAVE/<config_id>`: save a new/updated configuration file
        - `DELETE/<config_id>`: delete a configuration file
* `controller/db`:
    * inbound: 
        - `SAVE/<sensor_id>`: save a new measure for a sensor
        - `SAVE_ALERT/<severity>`: save a new alert
        - `CALC_HOUR_STATS/<sensor_id>`: calculate hourly aggregated stats
        - `CALC_DAY_STATS/<sensor_id>`: calculate daily aggregated stats
        - `PURGE_SENSOR/<sensor_id>`: delete old measures from db
        - `PURGE_ALERTS`: purge old alerts from db
        - `DELETE_SENSOR/<sensor_id>`: delete from the db the data associated to a sensor
        - `GET/<sensor_id>`: return measures from the db
        - `GET_ELAPSED/<sensor_id>`: return the elapsed time since the measure was taken
        - `GET_TIMESTAMP/<sensor_id>`: return the timestamp of the measure
        - `GET_DISTANCE/<sensor_id>`: return the distance from the measure
        - `GET_POSITION_LABEL/<sensor_id>`: return the label associated to a position
        - `GET_POSITION_TEXT/<sensor_id>`: return the text associated to the position
        - `GET_SCHEDULE/<sensor_id>`: return the schedule of a calendar data format
        - `GET_COUNT/<sensor_id>`: return the number of measures of a given timeframe
    * outbound: 
        - `*/*` - `SAVED/<sensor_id>`: notify everybody a new measure has been saved
* `controller/hub`:  
    * inbound: 
        - `IN/<sensor_id>`: receive a new value from a sensor (solicited or unsolicited) coming from the associated service
        - `POLL/<sensor_id>`: requested to invoke the service associated to the sensor
        - `SET/<sensor_id>`: asked to set a new value to a sensor
    * outbound: 
        - `service/<service_name>` - `IN/<sensor_id>`: invoke the service associated to a sensor to pull out a new value
        - `service/<service_name>` - `OUT/<sensor_id>`: trigger an action to an actuator
        - `controller/db` - `CALC_HOUR_STATS/<sensor_id>` / `CALC_DAY_STATS/<sensor_id>`: periodically calculate aggregates
        - `controller/db` - `PURGE_SENSOR/<sensor_id>`: periodically purge old data
        - `controller/db` - `SAVE/<sensor_id>`: save new measures
* `controller/logger`:  
    * inbound: 
        - `LOG/<severity>`: receive new log messages from all the modules
 
## Advanced Settings

The following additional environment variables can control specific advanced settings:

* `EGEOFFREY_DATABASE_HOSTNAME`: override the database hostname from the configuration file
* `EGEOFFREY_DATABASE_PORT`: override the database port from the configuration file
* `EGEOFFREY_DATABASE_NUMBER`: override the database number from the configuration file
* `EGEOFFREY_CONFIG_DIR`: override the directory where the configuration resides (default to `config`)
* `EGEOFFREY_CONFIG_FORCE_RELOAD`: force realoading the configuration from the filesystem (default to `0`)
* `EGEOFFREY_CONFIG_ACCEPT_DEFAULTS`: accept default configuration files provided by other packages in the manifest file (default to `1`)
