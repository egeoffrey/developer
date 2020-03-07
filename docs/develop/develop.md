# Developing with eGeoffrey

If you want to contribute to eGeoffrey, you can either enhance an existing package or create a new one.

## Enhance/Fix an Existing Package

Generally speaking, each package is associated to a git repository which is owned by a user. So to enhance or fix an existing package, you would need to:

* Go and visit the Github repository (which is in the manifest file) where the package resides
* Fork the repository
* Do the necessary changes
* Submit a PR (Pull Request)
* The author will take care of validating your contribution, merging the new content and building a new version

## Develop a New Package 

### System Requirements

To develop with eGeoffrey you would need to following software installed on your system:

* **Docker** and **docker-compose**
    * usually already installed by the eGeoffrey installed
    * ensure you can build for multiple architectures since eGeoffrey's packages have to be all distributed for both amd64 and arm32v6 architectures
* **Python**
    * not strictly required but useful for running your package outside the Docker container before building it for testing purposes
    * ensure the required SDK dependencies are installed with pip (e.g. paho-mqtt requests tinynumpy pyyaml yq apscheduler)
* **egeoffrey-cli**
    * usually already installed by the eGeoffrey installed
    * the utility has meny developer tools built in
* **egeoffrey-sdk**
    * not strictly required but useful for running your package outside the Docker container before building it for testing purposes
    * clone the https://github.com/egeoffrey/egeoffrey-sdk somewhere

### Development Workflow

Before starting developing, get familiar with the eGeoffrey SDK first by going through all the information of the next  sections as well as review the code of other existing packages. 

Now let's assume we want to create a new service called `service/example`:

* **Setup your repository**:
    * Initialize a new, empty repository with `egeoffrey-cli init_repo service example <your_github_user>` which will automatically:
        * create a directory called `egeoffrey-service-example` 
        * create inside it the package directory structure and other supporting files (.gitignore, .dockerignore, manifest.yml etc.)
        * initialize the git repository 
        * configure the remote URL to Github
* **Develop your code**:
    * open `service/example.py` and implement the logic of your module in the python file
    * customize the manifest file
    * customize the Dockerfile file, if needed
    * if needed, place default configuration files in the `default_config` directory
* **Test your code**:
    * The simplest way to test your code is by building the package and running (see the build section)
    * If you want to run your code outside of the Docker container:
        * ensure all the python dependencies are installed on your system
        * download or link the SDK cloned before in the root directory of your package in a directory called `sdk`
        * configure environment variables accordingly (e.g. at least `EGEOFFREY_GATEWAY_HOSTNAME` and `EGEOFFREY_MODULES`)
        * start the module with `python -m sdk.python.module.start`
        * CTRL+C to stop the execution
* **Commit changes to the code**:
    * When you are fine with the code, run `egeoffrey-cli commit "<comment>"` which will automatically:
        * increase the revision number of the current version of your package
        * generate a README.md file
        * commit the changes to the local repository
        * push the changes to the remote repository
    
You can new proceed and build the package for distribution.

### Updates

Once your brand new code have been committed and the packages published, you may want to update your code to fix bugs and/or add new functionalities. To do this, follow the same development process above, but applying the paculiarities of the following scenarios:

* If it is a minor change:
    * edit the code
    * run `egeoffrey-cli commit` which automatically increases the revision number and pushes the updated code to the remote repository
    * run `egeoffrey-cli build` which automatically builds the updated Docker images and pushes them to the Docker registry
* If it is a major change (e.g. you want to release a new version) that you want to make immediately available to your users:
    * edit the code
    * run `egeoffrey-cli new_version <version>` to change the version number
    * run `egeoffrey-cli commit` which automatically pushes the updated code to the remote repository
    * run `egeoffrey-cli build` which automatically builds the updated Docker images and pushes them to the Docker registry
* If it is a change that you want to develop step by step and/or distribute to beta testers before making available to your users, create a dedicated branch for the development phase:
    * edit the code
    * run `egeoffrey-cli new_branch <branch_name>` to create a new development/dedicated branch
    * optionally run `egeoffrey-cli new_version <version>` if you also want to change the version number
    * run `egeoffrey-cli commit` to commit and push the updated code to the remote repository
    * run `egeoffrey-cli build` to automatically build the updated Docker images and push them to the Docker registry. The resulting image will be named with the branch you provided above.
    * install the package by referencing the branch explicitely or by modifying the existing `docker-compose.yml` file
    * re-iterate with further changes and use `egeoffrey-cli commit` and `egeoffrey-cli build` to publish them out
    * when ready to merge the changes back to the master branch, run `egeoffrey-cli merge` (which will do the merge and adjust the manifest file) followed again by `egeoffrey-cli commit` and `egeoffrey-cli build` to publish the updated code/images