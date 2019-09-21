# Versioning

in eGeoffrey, there isn't a global version number. Each package has its own versioning which evolves independently from the others and from eGeoffrey's core components.

Each package (including the SDK), is characterized by the following information related to its version, all contained within the manifest file: 

* `branch`: the branch where the code belongs to
* `version`: the version of the package (e.g. 1.0, master, etc.)
* `revision`: the revision number (e.g. 22)

The information in `branch` has to match the git branch where the code base resides. Developers are free to use whatever name they want to name their branches.

### The Branch

The git branch is used as a *channel* for updates. When you install a package, `egeoffre-cli` automatically install the latest version associated to the `master` branch but user can point out any branch with e.g. `egeoffrey-cli install package:branch`. Once selected this can only be changed manually by modifying the `docker-compose.yml` file. 

In this way the user will consistently receive always the latest version of the branch they have chosen. For example developers can allow users to select between a stable and development branch and they will receive updates only for the selected channel.

It is highly recommended to have a `master` branch with the latest stable version so to allow the Marketplace app to interact with your package smoothly.

During the build phase, the Docker image will be named according to the branch name (e.g. `egeoffrey-gui:master-amd64`)

### The Version Number

The version is a number which the developer increases when a new minor or major version is released. It has no dependency with the other eGeoffrey components so is up to developer how to play with major and minor versions. For every version there must always be a git tag associated to the latest commit so to allow keeping track of the snapshot of the code for that particular version.

The same apply when building the Docker image, an additional tag with the version number has to be pushed in addition to the one with the branch (e.g. `egeoffrey-gui:1.0-amd64`). When building with `egeoffre-cli`, this is done automatically. In this way, in addition to the latest stable version, for each version an image will be kept allowing to revert to a previous version if needed.

### The Revision Number

The revision number has to be incremented by the developer at EVERY new commit (when committing with `egeoffre-cli`, this is done automatically). This allows understanding if running the latest version. During the build phase the revision number does not play a role: since an increment here is considered a minor change, there would be no need to revert to a previous revision number.
