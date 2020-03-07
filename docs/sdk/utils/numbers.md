# The Numbers Util

*Python SDK*

Provide functions to manipulate numbers. 

The following common functions are provided:

* `is_number(s)`: return true if the input is a number
* `normalize(value, format=None)`: normalize the value based on the given format. If the input is a number, keep a single digit, otherwise return a string
* `remove_all(array, value_array)`: remove all occurrences of value from array
* `min(data)`: calculate the min of a given array of data
* `max(data)`: calculate the max of a given array of data
* `avg(data)`: calculate the avg of a given array of data
* `sum(data)`: calculate the sum of a given array of data
* `count(data)`: count the items of a given array of data
* `count_unique(data)`: count the (unique) items of a given array of data
* `randint(min,max)`: return a random int between min and max
* `hex2int(hex)`: convert a hex string into an integer
