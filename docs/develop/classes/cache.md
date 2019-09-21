# The Cache Class

*Python SDK*

Especially when developing a `service`, there are cases when you need to cache a result of a query and retrieve it if the same data is requested in a short while. For example, there are weather API services which allow up to a limited number of queries every minute/hour so you don't want to overcome the limit when e.g. requesting multiple information (like temperature, pressure, humidity, etc.) resuting however in the same api call repeated multiple times.

The following functions are provided:

* `add(key, value, expire=60)`: add key=value in the cache and set expiration time in seconds
* `find(key)`: check if key is in the cache and not expired
* `get(key)`:  get value associated to key from the cache

