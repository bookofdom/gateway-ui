module.exports = function(app) {
  var _ = require('underscore');
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
          "endpoint_group_id": null
      },
      {
          "id": 2,
          "name": "Test Endpoint",
          "description": "This is a test endpoint",
          "active": false,
          "cors_enabled": true,
          "api_id": 1,
          "environment_id": 2,
          "endpoint_group_id": 1
      }
  ];
  var routes = [
    {
  		"path": "/somewhere/over-the/rainbow.json",
  		"methods": ["GET"]
    },
    {
  		"path": "/endpoint",
  		"methods": ["GET", "POST", "PUT", "DELETE"]
    }
  ];
  var components = [
    {
			"type": "single",
			"conditional": "",
			"conditional_positive": true,
			"before": [
				{	
					"type": "js",
					"data": "before single"
				}
			],
      "call": {
				"endpoint_name_override": "singleCall",
				"remote_endpoint_id": 1
      },
			"after": [
				{	
					"type": "js",
					"data": "after single"
				}
			]
		},
		{
			"type": "multi",
			"conditional": "",
			"conditional_positive": true,
			"before": [
				{	
					"type": "js",
					"data": "before multi comp"
				}
			],
      "calls": [
        {
  				"conditional": "",
  				"conditional_positive": true,
  				"before": [
  					{	
  						"type": "js",
  						"data": "before multi call a"
  					}
  				],
  				"endpoint_name_override": "multiA",
  				"remote_endpoint_id": 1,
  				"after": [
  					{	
  						"type": "js",
  						"data": "after multi call a"
  					}
  				]
        },
        {
  				"conditional": "",
  				"conditional_positive": true,
  				"before": [
  					{	
  						"type": "js",
  						"data": "before multi call b"
  					}
  				],
  				"endpoint_name_override": "multiB",
  				"remote_endpoint_id": 1,
  				"after": [
  					{	
  						"type": "js",
  						"data": "after multi call b"
  					}
  				]
        }
      ],
			"after": [
				{	
					"type": "js",
					"data": "after multi comp"
				}
			]
		},
		{
			"type": "js",
			"conditional": "",
			"conditional_positive": true,
      "data": "code string"
		}
  ];

  proxyEndpointsRouter.get('/', function(req, res) {
    res.send({
      'proxy-endpoints': _.clone(proxyEndpoints)
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
    })[0];
    endpoint = _.clone(endpoint);
    endpoint.routes = routes;
    endpoint.components = components;
    res.send({
      'proxy_endpoint': endpoint
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
