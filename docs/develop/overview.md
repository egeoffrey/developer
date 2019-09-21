# Developing with eGeoffrey

If you want to contribute to eGeoffrey, you can either enhance an existing package or create a new one.

## Enhance/Fix an Existing Package

* Go and visit the Github repository where the package resides
* Submit a PR (Pull Request)
* The author will take care of validating your contribution, merging the new content and building a new version

## Develop a New Package 

* Get familiar with eGeoffrey SDK first by going through all the information of this section
* Setup your repository:
    * Clone the `egeoffrey-service-example` repository which can be used as an empty template (e.g. `git clone https://github.com/egeoffrey/egeoffrey-service-example.git`)
    * Your module will have a different name (keep in mind the naming convention, e.g. `egeoffrey-service-yourservice`) so rename the directory accordingly
    * Go in your Github account and create the repository, naming it in the same way
    * Set the correct upstream by running `git remote set-url origin https://github.com/USERNAME/REPOSITORY.git`
    * Edit the manifest file
* Develop your code:
    * Rename `service/example.py` accordingly and/or add additional modules
    * implement the logic of your module in the python file
    * if needed, place default configuration files as well as additional GUI contents in the `default_config` directory
* Test your code:
    * The simplest way to test your code is by building the package and running
    * If you want to run your code outside of the Docker container:
        * ensure all the python dependencies are installed on your system
        * download or link the sdk in the root directory of your package 
        * configure environment variables accordingly (e.g. at least `EGEOFFREY_GATEWAY_HOSTNAME` and `EGEOFFREY_MODULES`)
        * start the module with `python -m sdk.python.module.start`
* Commit changes to the code:
    * Run `egeoffrey-cli commit "<comment>"` which will automatically increase the revision number, generate a README.md file, commit the changes and push them to the remote repository
    

