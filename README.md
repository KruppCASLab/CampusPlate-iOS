# Campus Plate - iOS Client

## About
The iOS client is currently built with UIKit. In the future, we plan on migrating to SwiftUI.

## Building
To build the project, you do need Xcode installed. Once you clone the repository, if you open the xcodeproj file, you should be able to build it and run it on the iOS and iPadOS simulator. It also will run on macOS devices that have a M* chip.

## Deploying at a University
If you are deploying Campus Plate at your university and would like your university's web service endpoint added to the default iOS application, you can submit a pull request containing the change. Or, you can fork the repository, rebrand the iOS application, and using your own organization's developer license. The current "Campus Plate" app in the app store is published under one of the contributor's developer license and may not be renewed in the future.

To implement your web service endpoint in the iOS application, you will want to modify the following files in the `Configuration` folder:

* `dev` - Contains a testing URL that you want to use for development. This will automatically be used if you run the application from Xcode.
* `prod` - Contains the production URL that you want to use for production. This will automatically be used if the application is deployed to the app store.

The change should be made using the following formats as an example, where you take your university's domain (e.g. abc.edu) and create the key using the following format DOMAIN_TLD (e.g. ABC_EDU). Below are examples for emails with @bw.edu and @case.edu:

```
BW_EDU = https:/$()/mops.bw.edu/cp/rest.php
CASE_EDU = https:/$()/caslab.case.edu/cp/rest.php
```

The other change that needs to occur is in `Info.plist`. In here, you just need to map these environment variables as shown below:

<img width="539" height="78" alt="image" src="https://github.com/user-attachments/assets/187affc8-769c-4326-af3c-642b883045b4" />



