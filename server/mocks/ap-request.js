module.exports = function(app) {
  var express = require('express');
  var apRequestJsRouter = express.Router();
  var apRequestJs = "\
/**\n\
* Mock ap-request.js file.\n\
* @param {string} ap - ap\n\
* @param {string} request - request\n\
*/\n\
function apRequestJs (name, doc) {};\n";

  apRequestJsRouter.get('/', function(req, res) {
    res.send(apRequestJs);
  });

  app.use('/admin/ap-request.js', apRequestJsRouter);
};
