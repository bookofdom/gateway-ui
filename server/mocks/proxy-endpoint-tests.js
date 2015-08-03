module.exports = function(app) {
  var express = require('express');
  var proxyEndpointTestsRouter = express.Router();

  var testResults = [
    {
      method: 'get',
      status: '200',
      body: 'get-test: "this is a get test"',
      log: 'this is a log message for a get request'
    },
    {
      method: 'post',
      status: '200',
      body: 'post-test: "this is a post test"',
      log: 'this is a log message for a post request'
    },
    {
      method: 'put',
      status: '400',
      body: 'error: "this is a put test error"',
      log: 'this is a log message for a put request'
    }
  ];

  proxyEndpointTestsRouter.get('/:id/test', function(req, res) {
    res.send({results: testResults});
  });

  app.use('/admin/apis/:api_id/proxy_endpoints/:endpoint_id/tests', proxyEndpointTestsRouter);
};
