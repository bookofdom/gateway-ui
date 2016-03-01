module.exports = function(app) {
  var express = require('express');
  var sharedComponentsRouter = express.Router();
  var sharedComponents = [
    {
      "api_id": 1,
      "id": 1,
      "name": "Basic Component",
      "description": "A shared single-step component.",
      "type": "single",
      "conditional": "\n\
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
      "api_id": 1,
      "name": "Multi Shared Component",
      "description": "A shared multi-step component",
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
          "remote_endpoint_id": 9,
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
          "remote_endpoint_id": 4,
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
      "api_id": 1,
      "name": "JS Shared Component",
      "description": "A shared JS component",
      "conditional": "var foo = function () {\n\n};",
      "conditional_positive": true,
      "type": "js",
      "data": "code string"
    }
  ];

  var setupEmbeddedIds = function (call, calls, before, after) {
    if (call) {
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
    }
    if (calls) {
      calls.forEach(function (call) {
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
    if (before) {
      before.forEach(function (before) {
        var id = Math.round(Math.random() * 100) + 100;
        before.id = before.id || id;
      });
    }
    if (after) {
      after.forEach(function (after) {
        var id = Math.round(Math.random() * 100) + 100;
        after.id = after.id || id;
      });
    }
  };

  sharedComponentsRouter.get('/', function(req, res) {
    res.send({
      'shared_components': sharedComponents
    });
  });

  sharedComponentsRouter.post('/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    var call = body.shared_component.call,
        calls = body.shared_component.calls,
        before = body.shared_component.before,
        after = body.shared_component.after;
    setupEmbeddedIds(call, calls, before, after);
    body.shared_component.id = id;
    res.status(201).send(body).end();
  });

  sharedComponentsRouter.get('/:id', function(req, res) {
    var sharedComponent = sharedComponents.filter(function (value) {
      return value.id == req.params.id;
    });
    res.send({
      'shared_component': sharedComponent[0]
    });
  });

  sharedComponentsRouter.put('/:id', function(req, res) {
    var body = req.body;
    var call = body.shared_component.call,
        calls = body.shared_component.calls,
        before = body.shared_component.before,
        after = body.shared_component.after;
    setupEmbeddedIds(call, calls, before, after);
    body.shared_component.id = req.params.id;
    if (body.shared_component.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}});
    } else if (body.shared_component.name.toLowerCase() == '500') {
      res.status(500).send();
    } else {
      res.send(body);
    }
  });

  sharedComponentsRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/admin/apis/:api_id/shared_components', sharedComponentsRouter);
};
