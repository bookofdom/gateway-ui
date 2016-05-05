# Gateway
Gateway UI now runs in Docker for local development.  For convenience, command
line usage remains largely unchanged.  Follow along to get started.


## Prerequisites
* [Git](http://git-scm.com/)
* [Docker](http://docker.com/)
  * [Docker for OS X](https://docs.docker.com/installation/mac/)
  * [Docker for Linux](https://docs.docker.com/installation/)


## Setup the Docker Virtual Machine (OS X-Only)
Add these lines to your `.bash_profile` or `.profile` to ensure Docker access
is available in the terminal:

    docker-machine start default
    eval "$(docker-machine env default)"


## Installation
* `git clone <repository-url>` this repository
* `cd` into the new directory
* `docker-compose run --rm npm install`
* `docker-compose run --rm bower install`


## Running / Development
* `docker-compose up ember`
* Determine your Docker container's IP:
  * On Mac OS X:  `docker-machine ls`
  * On Linux:  `docker inspect <container ID>`
* Visit your app at
[http://<docker-machine ip>:4200](http://<docker-machine ip>:4200).


## Building
To output production build artifacts into the project's `dist/` folder:

    docker-compose run --rm npm install
    docker-compose run --rm bower install
    GATEWAY_UI_DEST=./dist docker-compose run --rm build_production

**Note**:  the `GATEWAY_UI_DEST` environment variable _must_ be set.

To output production build artifacts to a another location, replace
`./dist` above with your desired destination folder.


## Testing
Follow the installation steps (see above) and then run `docker-compose run --rm ember test`


## License Reporting
Depends on [license_finder](https://github.com/pivotal/LicenseFinder).
Generate a report of licenses in need of review with `license_finder report`.


## Further Reading / Useful Links
* [ember.js](http://emberjs.com/)
* [ember-cli](http://www.ember-cli.com/)
* Development Browser Extensions
  * [Ember inspector:  Chrome](https://chrome.google.com/webstore/detail/ember-inspector/bmdblncegkenkacieihfhpjfppoconhi)
  * [Ember inspector:  Firefox](https://addons.mozilla.org/en-US/firefox/addon/ember-inspector/)
