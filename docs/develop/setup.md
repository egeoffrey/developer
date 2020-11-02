
1. Select which kind of **eGeoffrey functionality** you want to provide:
    * `notification` to trigger notifications upon specific events (e.g. email, slack, etc.)
    * `interaction` to interact with eGeoffrey (e.g. with a microphone, through slack, etc.)
    * `service` to provide an interface with a specific device, protocol or service which are used to collect measures and values for your sensors or control your actuator (e.g. a weather service API, a zigbee device, etc.)
1. **Choose a name** for the package you want to build (e.g. we are creating a "service" called "example")
1. **Create the local repository** for hosting your code:
    * Initialize a new, empty repository with `egeoffrey-cli init_repo service example <your_github_user>` which will automatically:
        * create a directory called `egeoffrey-service-example` 
        * create inside it the package directory structure and other supporting files (`.gitignore`, `.dockerignore`, `manifest.yml` etc.)
        * initialize the git repository 
        * configure the remote URL to Github
1. Create the **remote repository** in your GitHub account, in this example it has to be called `egeoffrey-service-example`
1. Always on GitHub, go to the "Settings" of your repository, click on "Secrets" and create a secret called `DOCKERHUB_USERNAME` storing your DockerHub username and `DOCKERHUB_TOKEN` storing the DockerHub access code previously created. This will be used by the build process to automatically push the images to DockerHub
1. Go into the directory of your local repostiory and **commit your code** by running `egeoffrey-cli commit "First commit"`
1. Ensure the **source code has been pushed** by visit your repository on GitHub
1. Always in your repository, click "Actions" and ensure the **"Build and Publish eGeoffrey Package" workflow is completed** (showing up green, it could take a couple of minutes) 
1. Ensure the Docker **images have been pushed to DockerHub** by visiting your DockerHub account (for each supported CPU architecture two images are built, one named as branch and another named after the version number)
