Dockerfiles to create images for use with Singularity
-----------------------------------------------------
*And you will know the container, and the container will set you free.*

This repo holds Dockerfiles that are used to create images for use with
Singularity.  Singularity supports running Docker images from Docker Hub
via the `docker://` URL prefix. 

When a Dockerfile is added to the repository, it will automatically
be built, tested, and uploaded to the HCC namespace on Docker Hub at
[https://hub.docker.com/u/unlhcc] (https://hub.docker.com/u/unlhcc).
It can then be run as `singularity exec docker://unlhcc/<image name> <command>`
on the clusters.

Docker images can be built on any host running EL7 or better, so the easiest
way is to start up an EL7 instance on Anvil to use.  [Docker install 
instructions for CentOS](https://docs.docker.com/engine/installation/linux/centos/#/install-with-yum).
 The basic workflow is to create a new branch, add a folder containing the 
Dockerfile and any additonal files needed.  The folder must also contain a 
`test.sh` script with the specific command to test the image.  Once you 
believe it's working, commit and push the new branch.  This will trigger an
automated build and test of the image.  Once it passes, create a merge
request to merge your changes into master. Upon merge, the new image will
be pushed to Docker Hub and available for use.

### Build your Docker image
**Note:  In order for /work to be available in the final image, 
you'll need to create the mount point in the Docker container when building.** 
This can be done via adding `RUN mkdir /work` to the Dockerfile.

Clone the repo and do a pull in the master branch to ensure you're up-to-date.
Then create a new branch to add your new image to:  

```
git checkout -b my_image
```

The branch name is arbitrary, but good practice is to name it the same as the 
image name for clarity.  Create a new folder to put your `Dockerfile` in.
**Note:  The folder name will be the final image name, so make it clear and concise.**


Assuming you have added a folder called `myimage` with a `Dockerfile` in it,
cd to that directory and test building the image by doing:

```
docker build .
```

This is a good time to make sure everything is correct within the image.
Get the ID of the created image by doing:

```
docker images
```

The image you just created will be at the top of the list.  Output should look something like:
```
REPOSITORY                      TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
<none>                          <none>              f7f37b909f44        2 hours ago         1.312 GB
```

Start the container with an interactive shell session using the IMAGE ID by doing:

```
docker run -ti f7f37b909f44
```

Poke around and make sure things look right, then exit.

#### Building Docker images that require private conda packages (optional)
If as part of your `Dockerfile` you need to create a `conda` environment with a package
that is listed as private in the `hcc` conda channel, you need to declare `ARG token`
in the `Dockerfile` and use this argument when specifying the needed conda channels:

```
ARG token
RUN conda config --system --add channels https://conda.anaconda.org/t/${token}/hcc
```

The value of `token` is already set in the GitLab CI settings, so no further
declarations are needed.

Next, you can build and test this image locally by using `--build-arg`:

```
docker build --build-arg token=<TOKEN> .
```

where `<TOKEN>` is the actual value of the token used for private conda packages.

### Add a test script
**You must add a proper test script or the build will fail.**
The top level `test_changed_images.sh` script looks for a `test.sh` script in each directory
to test the image.  The `test.sh` script is a single line file which defines the
`imageCommand` variable with the test command.  The image is tested by running it
via `singularity exec` using the value of `imageCommand` within a Docker container.
The command should be something non-interactive that returns a 0 exit code. 
Usually running the main command with `--help` or `--version` are good choices.

For example, the full Singularity command to run the Macaualy2 program is
```
singularity exec docker://unlhcc/macaulay2 M2
```

Running `singularity exec docker://unlhcc/macaulay2 M2 --version` returns 0, so
the `test.sh` script has the line
```
imageCommand="M2 --version"
```

### Add a `TAGS` file to indicate the version (optional)
To add an additional tag or tags to the image to denote the version, create a file
called `TAGS` alongside the `Dockerfile` in the image directory.  The file format is
one additional tag per line.  These tags will be added to the default git ref. and
`latest` tag by Shipwright when the image is built and pushed.  Keep in mind
this should only reflect the *current* version; it should not be a historical
list of every version.  That list should be kept by updating the `IMAGELIST.md` file
(in the Version column) everytime a new version is added, to provide a complete
list of all versions available for a particular image.

### Update the image list
If you are adding a new image or updating the version for an existing one, update
the `IMAGELIST.md` file with the appropriate information (name, version, example
command, notes, etc.).

### Push your changes
Once you think the image is working, commit your changes and push your new branch
to git.unl.edu:

```
git push origin my_image
```

This will automatically start a build and test pipeline.  You can check the status
and see the output under the `Pipelines` tab on the repository page.

### Create a merge request
Assuming everthing worked and the CI check passed, create a merge request from your
branch into master. Once the changes are merged, it will trigger a deploy stage
build and automatically upload the image to Docker Hub.
