# OHMS Viewer

This repo wraps the [uklibraries/ohms-viewer](https://github.com/uklibraries/ohms-viewer) project with a Docker build that adds our various customizations. Under the hood it's essentially just Apache/mod_php running in Docker, with the source code copied to /var/www/html within the container along with our customizations (included in the ./html directory of this repo).

To build and test it, run:

```sh
docker compose up --build
open http://localhost/viewer.php?cachefile=Interview62894.xml
```

You can also build a specific OHMS Viewer version if you'd like, but in that case you'll need to separate the `build` and `up` steps:

```sh
docker compose build --build-arg OHMS_VIEWER_VERSION=<githubTag>
docker compose up
```

To bump the default built version, update the value of the `OHMS_VIEWER_VERSION` variable in the Dockerfile.
