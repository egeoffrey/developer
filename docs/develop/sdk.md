# eGeoffrey SDK

To avoid re-inventing the wheel every time, most of the common functionalities needed to make a module running have been integrated into the eGeoffrey SDK which also acts as a sort of library. EVERY module has to be based on the SDK and inherit from the `Module` class; eGeoffrey core components including the watchdog, the controller, the GUI, etc. are all based upon the same principle.

Regardless of the language you are programming in, once you create your class as a subclass of Module (or its subclasses), you can leverage common functionalities provided by the class as well as callback which are invoked upon specific events (connected to the gateway, receiving a message, etc.)

The SDK is available in both Python and Javascript.

Despite for completeness in the following sections a detailed description of all the main classes of the SDK will be provided, if you are a developer you should be interested only in the `Module` class.

## Levering the SDK

There are three ways to leverage the Classes and Utils described in the following sections:

### Module Class

Whenever you write your own module, you have to:

1. Import the Class:
    * in Python you need to do so at the beginning of your code e.g.  `from sdk.python.module.service import Service`
    * in Javascript you need to import the file e.g. `<script src="sdk/javascript/module/module.js"></script>`
2. Create your new class inhering from `Module` or one of its subclasses (`Service`, `Notification`, `Controller`, `Interaction`)

### Other Classes

If you need to use a function of one of the SDK classes, you have to:

1. Import the Class:
    * in Python you need to do so at the beginning of your code e.g.  `from sdk.python.utils.datetimeutils import DateTimeUtils`
    * in Javascript you need to import the file e.g. `<script src="sdk/javascript/utils/datetimeutils.js"></script>`
2. Create an instance of the class and invoke its methods

### Utils

For the SDK utilities which does not neet a class to be created, you have to:

1. Load the code:
    * in Python you need to do so at the beginning of your code e.g.  `import sdk.python.utils.web`
    * in Javascript you need to import the file e.g. `<script src="sdk/javascript/utils/strings.js"></script>`
2. Invoke of the the functions
    * In Python you need to use the full name (e.g. sdk.python.utils.web.get(url))


