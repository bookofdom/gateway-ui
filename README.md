# Gateway
Gateway UI now runs in Docker for local development.  For convenience, command
line usage remains largely unchanged.  Follow along to get started.


## Prerequisites
* [Git](http://git-scm.com/)
* [Docker](http://docker.com/)


## Setup the Docker Virtual Machine (OS X-Only)
Add these lines to your `.bash_profile` or `.profile` to ensure Docker access
is available in the terminal:

    docker-machine start default
    eval "$(docker-machine env default)"


## Installation
* `git clone <repository-url>` this repository
* `cd` into the new directory
* `npm install`
* `bower install`


## Running / Development
* `ember s`
* Visit your app at
[http://<docker-machine ip>:4200](http://localhost:4200).


## Building
To output production build artifacts into the project's `dist/` folder:

    npm install
    bower install
    ember build --environment production


## Testing
Follow the installation steps (see above) and then run `ember test`


## Further Reading / Useful Links
* [ember.js](http://emberjs.com/)
* [ember-cli](http://www.ember-cli.com/)
* Development Browser Extensions
  * [Ember inspector:  Chrome](https://chrome.google.com/webstore/detail/ember-inspector/bmdblncegkenkacieihfhpjfppoconhi)
  * [Ember inspector:  Firefox](https://addons.mozilla.org/en-US/firefox/addon/ember-inspector/)
