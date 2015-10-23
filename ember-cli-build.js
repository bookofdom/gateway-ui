/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');
var Funnel = require('broccoli-funnel');

/*
 * Updated build syntax:
 * https://github.com/ember-cli/ember-cli/blob/master/TRANSITION.md#user-content-brocfile-transition
 */

module.exports = function(defaults) {
  var app = new EmberApp(defaults, {
    fingerprint: {
      exclude: [
        'snippets/javascript.js',
        'theme-slate.js',
        'worker-javascript.js',
        'worker-tern.js'
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
        'bower_components/bootstrap-sass/assets/stylesheets'
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

  // Bootstrap
  app.import('bower_components/bootstrap-sass/assets/javascripts/bootstrap.js');
  // i18next
  app.import('bower_components/i18next/i18next.js');
  // moment
  app.import('bower_components/moment/moment.js');
  app.import('bower_components/moment/locale/es.js');
  app.import('bower_components/moment/locale/hi.js');
  app.import('bower_components/moment/locale/pt-br.js');
  // ACE
  // TODO:  customized for Ember compatibility
  app.import('bower_components/ace-tern/ace-builds/src-noconflict/ace.js');
  // Standard ACE libraries
  app.import('bower_components/ace-tern/ace-builds/src-noconflict/ext-language_tools.js');
  app.import('vendor/ace-tern/ace-builds/src-noconflict/ext-tern.js');
  app.import('bower_components/ace-tern/ace-builds/src-noconflict/mode-javascript.js');
  app.import('bower_components/ace-tern/ace-builds/src-noconflict/mode-text.js');

  // jQuery UI (sortable-only custom build)
  app.import('vendor/jquery-ui-1.11.4.custom/jquery-ui.js');
  // datetime picker
  app.import('bower_components/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js');
  app.import('bower_components/eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css');
  // UUID
  app.import('bower_components/node-uuid/uuid.js');
  // vkBeautify
  app.import('bower_components/vkbeautify/vkbeautify.js');
  // uuid
  app.import('bower_components/node-uuid/uuid.js');
  // Gateway Icons
  app.import('bower_components/gateway-icons/dist/fonts/gateway.eot', {destDir: 'assets/fonts'});
  app.import('bower_components/gateway-icons/dist/fonts/gateway.svg', {destDir: 'assets/fonts'});
  app.import('bower_components/gateway-icons/dist/fonts/gateway.ttf', {destDir: 'assets/fonts'});
  app.import('bower_components/gateway-icons/dist/fonts/gateway.woff', {destDir: 'assets/fonts'});

  // ACE workers are loaded at runtime via AJAX and thus are included seperately
  var aceAssets = new Funnel('bower_components/ace-tern/ace-builds/src-noconflict', {
    srcDir: '/',
    include: [
      'snippets/javascript.js',
      'worker-javascript.js',
      'worker-tern.js',
      'worker-text.js'
    ],
    destDir: '/'
  });

  return app.toTree(aceAssets);
};
