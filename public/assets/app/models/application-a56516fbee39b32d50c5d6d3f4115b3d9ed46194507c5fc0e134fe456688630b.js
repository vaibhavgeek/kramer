(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  App.Application = (function(superClass) {
    extend(Application, superClass);

    function Application() {
      return Application.__super__.constructor.apply(this, arguments);
    }

    Application.configure('Application', 'name', 'redirect_uri');

    Application.extend(Spine.Model.Ajax);

    Application.url = Application.apiPath + '/applications';

    Application.configure_attributes = [
      {
        name: 'name',
        display: 'Name',
        tag: 'input',
        type: 'text',
        limit: 100,
        "null": false
      }, {
        name: 'redirect_uri',
        display: 'Callback URL',
        tag: 'textarea',
        limit: 250,
        "null": false,
        note: 'Use one line per URI'
      }, {
        name: 'clients',
        display: 'Clients',
        tag: 'input',
        readonly: 1
      }, {
        name: 'created_at',
        display: 'Created',
        tag: 'datetime',
        readonly: 1
      }, {
        name: 'updated_at',
        display: 'Updated',
        tag: 'datetime',
        readonly: 1
      }
    ];

    Application.configure_overview = ['name', 'redirect_uri', 'clients'];

    Application.configure_delete = true;

    return Application;

  })(App.Model);

}).call(this);
