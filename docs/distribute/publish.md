# The eGeoffrey Marketplace

The marketplace allows eGeoffrey users to exchange new and original contents. Once you have created your package, built it and pushed to Dockerhub, you are ready to make some noise and ask to have it added to the eGeoffrey Marketplace

If you are a user, the Marketplace can be accessed from both your eGeoffrey instance under *'eGeoffrey Admin'*/*'Marketplace'* or on [https://marketplace.egeoffrey.com](https://marketplace.egeoffrey.com).

The marketplace leverages eGeoffrey's modular framework which allows new packages to be easily plugged into the application without further actions or dependencies.

Search the marketplace for packages which could be helpful for your needs and simply follows the installation instructions to add the them to your eGeoffrey.

## Contributing

After having created your package and published the source code on your own Github repository and the Docker image on you own Dockerhub account, do the following:

* Go to `https://github.com/egeoffrey/egeoffrey-marketplace/tree/master/marketplace`
* Click on `Create new file`
* Name the file as your package name with a `yml` extension (e.g. `egeoffrey-service-yourservice.yml`)
* The file content should have a single line in the format `github: <git_username>/<git_repository>`
* Save the file; this will trigger a PR (Pull Request) 
* Once your request will be merged, your package will be available for all the other eGeoffrey users!

The Marketplace just contains a link to a repository, it the developer's responsibility to ensure the Docker image (which is what is  eventually deployed) is aligned with the content on Github.

If you are releasing a new version of a package, adding tags or anything else, there is no need to repeat the procedure above: it is up the Marketplace app to always provide the most up to date content.