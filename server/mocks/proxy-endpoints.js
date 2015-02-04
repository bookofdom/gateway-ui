module.exports = function(app) {
  var express = require('express');
  var proxyEndpointsRouter = express.Router();
  var proxyEndpoints = [
      {
          "id": 1,
          "name": "Test Endpoint",
          "description": "This is a test endpoint",
          "active": true,
          "cors_enabled": true,
          "api_id": 1,
          "environment_id": 1,
          "endpoint_group_id": null,
          "routes": [
            {
          		"path": "/somewhere/over-the/rainbow.json",
          		"methods": ["GET"]
            },
            {
          		"path": "/endpoint",
          		"methods": ["GET", "POST", "PUT", "DELETE"]
            }
          ]
      },
      {
          "id": 2,
          "name": "Test Endpoint",
          "description": "This is a test endpoint",
          "active": false,
          "cors_enabled": true,
          "api_id": 1,
          "environment_id": 2,
          "endpoint_group_id": 1,
          "routes": [
            {
          		"path": "/endpoint",
          		"methods": ["GET", "POST", "PUT", "DELETE"]
            },
            {
          		"path": "/something.json",
          		"methods": ["GET", "POST", "PUT", "DELETE"]
            }
          ]
      }
  ];

  proxyEndpointsRouter.get('/', function(req, res) {
    res.send({
      'proxy-endpoints': proxyEndpoints
    });
  });

  proxyEndpointsRouter.post('/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.proxy_endpoint.id = id;
    res.status(201).send(body).end();
  });

  proxyEndpointsRouter.get('/:id', function(req, res) {
    var endpoint = proxyEndpoints.filter(function (value) {
      return value.id == req.params.id;
    });
    res.send({
      'proxy_endpoint': endpoint[0]
    });
  });

  proxyEndpointsRouter.put('/:id', function(req, res) {
    var body = req.body;
    body.proxy_endpoint.id = req.params.id;
    if (body.proxy_endpoint.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}})
    } else {
      res.send(body);
    }
  });

  proxyEndpointsRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/admin/apis/:api_id/proxy_endpoints', proxyEndpointsRouter);
};
