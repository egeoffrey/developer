# The DateTimeUtils Util

*Python SDK, Javascript SDK*

Provide a number of functions to do date and time conversion and elaboration. `DateTimeUtils` is a class which has to be initialized with the local timezone offset. The Python and Javascript SDKs provide different functions.

The following common functions are provided:

* `timezone(timestamp)`: return the timestamp with the timezone offset applied
* `utc(timestamp)`: return an UTC timestamp from a given timestamp (in the local timezone)
* `now()`: return the now timestamp (in the current timezone)

### Python

* `yesterday`: return yesterday's timestamp from a given timestamp (in the local timezone)
* `last_hour`: return the last hour timestamp from a given timestamp (in the local timezone)
* `get_timestamp(years, months, days, hours, minutes, seconds)`: generate a UTC timestamp based on the input
* `day_start(timestamp)`: return day start timestamp from a given timestamp (in the local timezone)
* `day_end(timestamp)`: return day end timestamp from a given timestamp (in the local timezone)
* `hour_start(timestamp)`: return hour start timestamp from a given timestamp (in the local timezone)
* `hour_end(timestamp)`: return hour end timestamp from a given timestamp (in the local timezone)
* `timestamp2date(timestamp)`: take a timestamp (in the local timezone) and return it in a human-readable format

### Javascript

* `format_timestamp(timestamp=this.now())`: format the provided timestamp for printing
* `timestamp_difference(date1, date2)`: return the difference between two timestamps in a human readable format
