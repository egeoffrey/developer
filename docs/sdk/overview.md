# eGeoffrey SDK

To avoid re-inventing the wheel every time, most of the common functionalities needed to make a module running have been integrated into the eGeoffrey SDK. 

Every eGeoffrey module has to be based on the SDK; eGeoffrey core components including the controller, the GUI, etc. are all based upon the same principle.

eGeoffrey SDK is providing both a set of [reusable functions for developing](/sdk/develop/) your eGeoffrey code AND a [pre-configured runtime](/sdk/images/) environment for easily build and publish your custom packages. 

## Programming Languages

The ambitious of eGeoffrey is to be multi-language whenever possible. For this reason the communication takes place through a language-agnostic message bus and common capabilities can be delivered through language-specific SDKs. A the time of writing the following languages are supported:

* Python: used by all the modules
* Javascript: used by the web interface

## Supported CPU Architectures

The runtime environment of eGeoffrey SDK is available for both `amd64` and `arm32v6` CPU architectures so to 
allow developers to build their packages and provide the same functionalities for traditional computer/server (usually `amd64`) and IoT devices like a Raspberry Pi (`arm32v6`).
