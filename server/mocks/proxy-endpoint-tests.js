module.exports = function(app) {
  var express = require('express');
  var proxyEndpointTestsRouter = express.Router();

  var testResults = [
    {
      method: 'get',
      status: '200',
      headers: [
        {name: 'Date', value: 'Tue, 04 Aug 2015 19:58:11 GMT'},
        {name: 'Content-Length', value: '539'},
        {name: 'Content-Type', value: 'application/json'},
        {name: 'X-Gateway-Requestid', value: 'ed32998f-f857-4335-9f0f-288010ddb282'}
      ],
      body: '{"get-test": "this is a get test"}',
      log: 'this is a log message for a get request'
    },
    {
      method: 'post',
      status: '200',
      headers: [
        {name: 'Date', value: 'Tue, 04 Aug 2015 19:58:11 GMT'},
        {name: 'Content-Length', value: '539'},
        {name: 'Content-Type', value: 'application/json'},
        {name: 'X-Gateway-Requestid', value: 'ed32998f-f857-4335-9f0f-288010ddb282'}
      ],
      body: '{"post-test": "this is a post test"}',
      log: 'this is a log message for a post request'
    },
    {
      method: 'put',
      status: '400',
      headers: [
        {name: 'Date', value: 'Tue, 04 Aug 2015 19:58:11 GMT'},
        {name: 'Content-Length', value: '539'},
        {name: 'Content-Type', value: 'application/json'},
        {name: 'X-Gateway-Requestid', value: 'ed32998f-f857-4335-9f0f-288010ddb282'}
      ],
      body: '{"error": "this is a put test error"}',
      log: 'this is a log message for a put request'
    }
  ];

  proxyEndpointTestsRouter.get('/:id/test', function(req, res) {
    res.send({results: testResults});
  });

  app.use('/admin/apis/:api_id/proxy_endpoints/:endpoint_id/tests', proxyEndpointTestsRouter);
};
