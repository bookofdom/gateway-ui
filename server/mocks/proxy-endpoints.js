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
  var tests = [
    {
      "id": 1,
      "name": "Test 1",
      "methods": ["GET"],
      "route": "/somewhere/over-the/rainbow.json",
      "pairs": [
        {
          "id": 1,
          "type": "get",
          "key": "key 1",
          "value": "value 1"
        },
        {
          "id": 2,
          "type": "get",
          "key": "key 2",
          "value": "value 2"
        },
        {
          "id": 5,
          "type": "header",
          "key": "key 1",
          "value": "value 1"
        }
      ]
    },
    {
      "id": 2,
      "name": "Test 2",
      "methods": ["POST"],
      "route": "/endpoint",
      "pairs": [
        {
          "id": 3,
          "type": "get",
          "key": "key 1",
          "value": "value 1"
        },
        {
          "id": 4,
          "type": "get",
          "key": "key 2",
          "value": "value 2"
        },
        {
          "id": 7,
          "type": "header",
          "key": "Content-Type",
          "value": "application/json"
        },
        {
          "id": 6,
          "type": "header",
          "key": "key 1",
          "value": "value 1"
        }
      ]
    }
  ];
  var components = [
    {
        "id": 1,
        "conditional": "\
var foo = function () {\n\
  var someCondition = true;\n\
  var myInt = 25;\n\
  if (someCondition && myInt) {\n\
    this.makeACall();\n\
    return {\n\
      key_1: 'this is a string',\n\
      key_2: myInt,\n\
      key_3: MyOtherClass.getString('some_value')\n\
    };\n\
  }\n\
};\n\
        ",
        "conditional_positive": true,
        "type": "single",
        "before": [
            {
                "id": 1,
                "type": "js",
                "data": "before single"
            }
        ],
        "after": [
            {
                "id": 2,
                "type": "js",
                "data": "after single"
            }
        ],
        "call": {
            "id": 1,
            "remote_endpoint_id": 1,
            "endpoint_name_override": "singleCall",
            "conditional": "var foo = function () {\n\n};",
            "conditional_positive": false
        }
    },
    {
        "id": 2,
        "conditional": "",
        "conditional_positive": true,
        "type": "multi",
        "before": [
            {
                "id": 3,
                "type": "js",
                "data": "before multi comp"
            }
        ],
        "after": [
            {
                "id": 4,
                "type": "js",
                "data": "after multi comp"
            }
        ],
        "calls": [
            {
                "id": 2,
                "remote_endpoint_id": 1,
                "endpoint_name_override": "multiA",
                "conditional": "",
                "conditional_positive": true,
                "before": [
                    {
                        "id": 5,
                        "type": "js",
                        "data": "before multi call a"
                    }
                ],
                "after": [
                    {
                        "id": 6,
                        "type": "js",
                        "data": "after multi call a"
                    }
                ]
            },
            {
                "id": 3,
                "remote_endpoint_id": 1,
                "endpoint_name_override": "multiB",
                "conditional": "",
                "conditional_positive": true,
                "before": [
                    {
                        "id": 7,
                        "type": "js",
                        "data": "before multi call b"
                    }
                ],
                "after": [
                    {
                        "id": 8,
                        "type": "js",
                        "data": "after multi call b"
                    }
                ]
            }
        ]
    },
    {
        "id": 3,
        "conditional": "var foo = function () {\n\n};",
        "conditional_positive": true,
        "type": "js",
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
    endpoint.tests = _.clone(tests);
    endpoint.tests.forEach(function (test) {
      test.proxy_endpoint_id = endpoint.id
    });
    endpoint.components = components;
    res.send({
      'proxy_endpoint': endpoint
    });
  });

  proxyEndpointsRouter.put('/:id', function(req, res) {
    var body = req.body;
    body.proxy_endpoint.id = req.params.id;
    body.proxy_endpoint.components = body.proxy_endpoint.components || [];
    body.proxy_endpoint.components.forEach(function (component) {
      var id = Math.round(Math.random() * 100) + 100;
      component.id = component.id || id;
      if (component.calls) {
        component.calls.forEach(function (call) {
          var id = Math.round(Math.random() * 100) + 100;
          call.id = call.id || id;
          if (call.before) {
            call.before.forEach(function (before) {
              var id = Math.round(Math.random() * 100) + 100;
              before.id = before.id || id;
            });
          }
          if (call.after) {
            call.after.forEach(function (after) {
              var id = Math.round(Math.random() * 100) + 100;
              after.id = after.id || id;
            });
          }
        });
      }
      if (component.before) {
        component.before.forEach(function (before) {
          var id = Math.round(Math.random() * 100) + 100;
          before.id = before.id || id;
        });
      }
      if (component.after) {
        component.after.forEach(function (after) {
          var id = Math.round(Math.random() * 100) + 100;
          after.id = after.id || id;
        });
      }
    });

    body.proxy_endpoint.tests = body.proxy_endpoint.tests || [];
    tests = body.proxy_endpoint.tests
    body.proxy_endpoint.tests.forEach(function (test) {
      var id = Math.round(Math.random() * 100) + 100;
      test.id = test.id || id;
      test.proxy_endpoint_id = test.proxy_endpoint_id || body.proxy_endpoint.id

      test.pairs = test.pairs || [];
      test.pairs.forEach(function (pair) {
        var id = Math.round(Math.random() * 100) + 100;
        pair.id = pair.id || id;
      })
    });

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
