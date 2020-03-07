# Apps for Mobile

Despite the eGeoffrey GUI is responsive and provides mobile support, apps for mobile devices are provided as well. 

Each app provides the same user experience as the Web UI since the interface is embedded within it as well as native notifications.

To fully enjoy a mobile experience with eGeoffrey you would need:

* an eGeoffrey instance installed and running somewhere
* the eGeoffrey gateway reachable from the network the mobile device is connected to
* valid credentails set up for your house on the gateway (especially if exposed on the Internet)
* the package `egeoffrey-notification-mobile` installed in your eGeoffrey instance to receive notifications
* the `notification/mobile` module configured with the device token you can get from the "About" menu of the app

## Supported Devices

### Android

eGeoffrey App for Android devices is available for download on the Google Play Store. 

### iOS

eGeoffrey App for iOS devices is NOT yet available for download on the Apple store but the code is accessible on Github. Native notifications are not yet supported on this platform.

## Notifications

To ensure notifications are triggered on the mobile device even if the eGeoffrey app is not running (or is paused by the operating system), the app leverages Google Firebase. 

For this reason the `notification/mobile` module must be running on your istance and will be responsible for pushing each notification to the eGeoffrey API Gateway which will be then route the request to Firebase for the delivery to your device.

