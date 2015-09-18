/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app'),
  pickFiles = require('broccoli-static-compiler'),
  mergeTrees = require('broccoli-merge-trees');

/*
 * Updated build syntax:
 * https://github.com/ember-cli/ember-cli/blob/master/TRANSITION.md#user-content-brocfile-transition
 */

module.exports = function(defaults) {
  var app = new EmberApp(defaults, {
    fingerprint: {
      exclude: [
        'theme-slate.js',
        'worker-javascript.js',
        'worker-json.js',
        'worker-text.js',
        'worker-xml.js'
      ]
    },
    gzip: {
      enabled: false,
      extensions: ['js', 'css', 'svg', 'eot', 'ttf'],
      appendSuffix: false
    },
    sourcemaps: {
      enabled: false
    },
    sassOptions: {
      includePaths: [
        'node_modules/ember-cli-anypresence/bower_components/bootstrap-sass-official/assets/stylesheets'
      ]
    }
  });

  // Use `app.import` to add additional libraries to the generated
  // output files.
  //
  // If you need to use different assets in different
  // environments, specify an object as the first parameter. That
  // object's keys should be the environment name and the values
  // should be the asset to use in that environment.
  //
  // If the library that you are including contains AMD or ES6
  // modules that you would like to import into your application
  // please specify an object with the list of modules as keys
  // along with the exports of each module as its value.

  // jQuery UI
  app.import('bower_components/jquery-ui/jquery-ui.js');
  // datetime picker
  app.import('bower_components/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js');
  app.import('bower_components/eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css');
  // vkBeautify
  app.import('bower_components/vkbeautify/vkbeautify.js');
  // uuid
  app.import('bower_components/node-uuid/uuid.js');
  // Retina Icons
  app.import('bower_components/bower-retina-icons/assets/fonts/retinaicon-font.eot', {destDir: 'assets/fonts'});
  app.import('bower_components/bower-retina-icons/assets/fonts/retinaicon-font.svg', {destDir: 'assets/fonts'});
  app.import('bower_components/bower-retina-icons/assets/fonts/retinaicon-font.ttf', {destDir: 'assets/fonts'});
  app.import('bower_components/bower-retina-icons/assets/fonts/retinaicon-font.woff', {destDir: 'assets/fonts'});
  // Gateway Icons
  app.import('bower_components/gateway-icons/dist/fonts/gateway.eot', {destDir: 'assets/fonts'});
  app.import('bower_components/gateway-icons/dist/fonts/gateway.svg', {destDir: 'assets/fonts'});
  app.import('bower_components/gateway-icons/dist/fonts/gateway.ttf', {destDir: 'assets/fonts'});
  app.import('bower_components/gateway-icons/dist/fonts/gateway.woff', {destDir: 'assets/fonts'});

  return app.toTree();
};
