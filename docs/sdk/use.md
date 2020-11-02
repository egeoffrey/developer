

## Developing against the SDK

To leverage the SDK, this has to be accessible by your code. A `sdk` directory from the [eGeoffrey SDK repository](https://github.com/egeoffrey/egeoffrey-sdk) is expected to be in the root directory of the package. It includes the SDK for all the supported languages.

When using eGeoffrey SDK pre-built runtime images, this action is not needed since the SDK and all its required dependencies are already included.

To fully leverage eGeoffrey SDK, the code has to implement a class which is inheriting from the SDK `Module` class. 

Once a class is created as a subclass of the eGeoffrey's SDK `Module` class (or its subclasses), it can leverage common functionalities provided by the SDK as well as callbacks which are invoked upon specific events (connected to the gateway, receiving a message, etc.).

As a starting point, when developing a module, you have to:

1. Import the `Module` class or one of its subclasses (`Service`, `Notification`, `Controller`, `Interaction`), depending which module you are targeting to develop
1. Optionally import other suporting classes the SDK provides needed by the module:
    * [Message](/sdk/classes/message/): abstraction of the messages exchanged through the eGeoffrey's message bus
    * [Session](/sdk/classes/session/): session handling to support asyncronous communication
    * [Cache](/sdk/classes/cache/): if you need to cache the result of a query
1. Optionally import additional supporting utilities provided by the SDK:
    * [Command](/sdk/utils/command/): for running operating system command
    * [DateTimeUtils](/sdk/utils/datetimeutils/): common functions for date and time conversion and elaboration
    * [Exceptions](/sdk/utils/exceptions/): for exception handling
    * [Numbers](/sdk/utils/numbers/): common functions to manipulate numbers
    * [Strings](/sdk/utils/strings/): common functions to manipulate strings
    * [Web](/sdk/utils/web/): common functions to interact with web services
1. Implement the `Module`'s class callbacks accordingly
    * [List of functionalities and callbacks](/sdk/classes/module/).

#### Importing SDK files in Python

If you need to import a SDK class:
```
from sdk.python.module.service import Service
```

If you need to import static SDK utilities functions:
```
import sdk.python.utils.web
```

#### Importing SDK files in Javascript

If you need to import any SDK files you need to include the file within the `<head>` HTML tag:

```
<script src="sdk/javascript/module/module.js"></script>
<script src="sdk/javascript/utils/strings.js"></script>
```

## Using SDK Images

To make eGeoffrey code running consistent across different platforms and prevent discrepancies introduced by missing or wrong dependencies, in eGeoffrey, what eventually the end user runs is a set of Docker images, one for each installed package. 

To speed up the building process, the eGeoffrey SDK provides also a pre-built docker runtime environment developers should leverage for packaging their own modules. These base docker images, from which you can derive yours, already includes the SDK and all its required dependencies. Furthermore, provide the following functionalities:

* Include already any operating system and Python requirements for running the SDK
* Start the an eGeoffrey watchdog service by running `python -m sdk.python.module.start`

The following SDK docker images are available:

* `egeoffrey-sdk-alpine`: light-weighted image based on Linux Alpine
* `egeoffrey-sdk-raspbian`: an image based on raspbian useful for leveraging Raspberry Pi functionalities

Developers can use the one which fits best their requirements. Usually, if no Raspberry Pi specific requirements are needed (e.g. GPIO), go with the eGeoffrey SDK alpine-based image.

SDK images follow the same naming convention of any other image `egeoffrey-sdk-<os>:<branch>-<architecture>`.

