# The Strings Util

*Python SDK, Javascript SDK*

Provide a number of functions to manipulate strings. The Python and Javascript SDKs provide different functions.

The following common functions are provided:

* `truncate(string, max_len=50)`: truncate a long string 
* `format_log_line(severity, module, text)`: format a log line for printing

### Python

* `hex2string(hex)`: convert a hex string into a ascii string

### Javascript
* `capitalizeFirst(string)`: capitalize the first letter
* `replaceAll(search, replacement)`: replace all instances of search in replacement
* `get_exception(e)`: return stack trace exception
* `topic_matches_sub(pattern, topic)`: javascript implementation of topic_matches_sub
* `format_multiline(string, length)`: format a multiline string by enforcing a maximum length
* `escape_html(string)`: escape html special characters in a string
