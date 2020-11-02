# Versioning your Package

Across eGeoffrey, there isn't a global version number. Each package has its own version which evolves independently from the others and from eGeoffrey's core components.

Each package is characterized by the following information related to its version, all contained within the manifest file: 

* **branch**: the branch to which the code belongs to. This information is used as a *channel* for updates (for example developers can allow users to select between a stable and development branch and they will always receive the latest version of the given channel). It is required to have a `master` branch updated with the latest stable version.
* **version**: the major version of the package (e.g. 1.0, 1.1, etc.). The Docker image of the latest release of each major version will persist so users can always downgrade to the latest version of each major release.
* **revision**: the revision number (e.g. 21, 22, etc.) is incremented at EVERY new commit (automatically when developers use `egeoffre-cli commit`). 

The overall version of a package is then in the format `<version>-<revision>` (e.g. `1.0-22`) and is independent accross branches. 

A user is notified a new version is available if the latest revision and/or version for the branch the user has installed (`master` by default) are greater than the one of the package currently installed.

When starting to develop your own package, the first commit will be version `1.0-1` in the `master` branch and at every commit the revision number will be increased.

### Creating a new Branch

If for example you are developing the new version of your package, don't want end users to use to automatically download this version until fully tested but still you want to allow a limited set of beta testers to use it, you may want to create a new branch (e.g. called development) which will act as an independent update channel.

Developers can create a new branch by running `egeoffre-cli new_branch <branch_name>` (e.g. `egeoffre-cli new_branch development`). The utility automatically updates the manifest file with the new branch name and checkout into it.
Every new commit will be then against this branch and only user "subscribed" to that branch will get the latest version.

If a end user needs to install a package belonging to a branch different than `master`, this has to be made explicit with `egeoffrey-cli install package:branch` (e.g. `egeoffrey-cli install egeoffrey-service-example:development`).
Once selected, a branch this can only be changed manually by modifying the `docker-compose.yml` file.

If your development cycle is finished and e.g. you want to promote the code in the `development` branch into the `master` you can run `egeoffrey-cli merge master`. This will merge all the changes done in the development branch into master. At the next commit, your master package will include all those changes.

### Creating a new Version

Developers can switch to a new version by running `egeoffre-cli new_version <version>` (e.g. `egeoffre-cli new_version 1.1`). The utility automatically updates the manifest file with the new version.

### Creating a new Revision

The revision number is incremented automatically at every commit when running `egeoffre-cli commit`.
