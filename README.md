# Nanoscale.io Gateway Server Admin UI
An Ember.js-based UI frontend for [nanoscale.io Gateway](https://github.com/nanoscaleio/gateway.git).


## Prerequisites
* [Git](http://git-scm.com/)
* [Node](https://nodejs.org/)
* [Bower](https://bower.io)


## Installation
* `git clone <repository-url>` this repository
* `cd` into the repository directory
* `npm install`
* `bower install`


## Running / Development
* `ember s`
* Visit your app at
[http://localhost:4200](http://localhost:4200).


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


## Contributing

This repository relies on [semantic-release-cli][semantic-release-cli] for automated
releases and [commitizen][commitizen] and
[cz-conventional-changelog][cz-conventional-changelog] for standardized commit
messages and changelogs.


### Committing

All work should be committed to a branch from `develop`, never to a mainline
branch directly.  When ready to commit changes, stage them as usual with:

		git add .

Commit changes with `npm`, rather than `git`.  In order to ensure standardized
commit messages across time and contributors, always use the `npm` script:

		npm run commit

and follow the instructions.

**Note**:  [watch the overview video of commitizen and the conventional changelog tool][commitizen-video].

[semantic-release-cli]: https://www.npmjs.com/package/semantic-release-cli
[commitizen]: https://www.npmjs.com/package/commitizen
[cz-conventional-changelog]: https://www.npmjs.com/package/cz-conventional-changelog
[commitizen-video]: https://egghead.io/lessons/javascript-how-to-write-a-javascript-library-committing-a-new-feature-with-commitizen


### Pull Requests

When a branch is ready to merge, submit a pull request to `develop` via GitHub.
Pull requests are automatically tested on Travis CI and may not be merged until
all tests pass.  At that time, a team member may safely merge the PR
into `develop`.


### Releasing

Releases are made from the `master` branch automatically.  To initiate a
release, create a PR from `develop` to `master`.  Since releasing is automated,
the timing and extent of release PR's is left to the discretion of team members.

Releasing is automated with `semantic-release`.  An automatic release is tagged
and published to npm upon a successful merge into the `master` branch only after
all tests successfully pass.
