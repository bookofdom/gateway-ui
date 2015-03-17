/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app'),
  pickFiles = require('broccoli-static-compiler'),
  mergeTrees = require('broccoli-merge-trees');

var app = new EmberApp({
  fingerprint: {
    exclude: ['assets/worker-javascript.js']
  },
  gzip: {
    extensions: ['js', 'css', 'svg', 'png', 'eot', 'ttf'],
    appendSuffix: false
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

// bootstrap
app.import('bower_components/bootstrap-sass-official/assets/javascripts/bootstrap.js')
// i18next
app.import('bower_components/i18next/i18next.js');
// moment
app.import('bower_components/moment/moment.js');
app.import('bower_components/moment/locale/es.js');
app.import('bower_components/moment/locale/hi.js');
// ace
app.import('bower_components/ace-builds/src-noconflict/ace.js');
app.import('bower_components/ace-builds/src-noconflict/ext-language_tools.js');
app.import('bower_components/ace-builds/src-noconflict/mode-javascript.js');
// jQuery UI
app.import('bower_components/jquery-ui/jquery-ui.js');
// jQuery File Upload
app.import('bower_components/jquery-file-upload/js/jquery.iframe-transport.js');
app.import('bower_components/jquery-file-upload/js/jquery.fileupload.js');
// Retina Icons
app.import('bower_components/bower-retina-icons/assets/fonts/retinaicon-font.eot', {destDir: 'assets/fonts'});
app.import('bower_components/bower-retina-icons/assets/fonts/retinaicon-font.svg', {destDir: 'assets/fonts'});
app.import('bower_components/bower-retina-icons/assets/fonts/retinaicon-font.ttf', {destDir: 'assets/fonts'});
// Gateway Icons
app.import('bower_components/gateway-icons/dist/fonts/gateway.eot', {destDir: 'assets/fonts'});
app.import('bower_components/gateway-icons/dist/fonts/gateway.svg', {destDir: 'assets/fonts'});

i18n = pickFiles('app', {
 srcDir: '/',
 files: ['locales/*/*.json'],
 destDir: '/'
});

module.exports = mergeTrees([
  app.toTree(),
  i18n
]);
