class Index extends App.ControllerSubContent
  requiredPermission: 'admin.version'
  header: 'Bot'

  constructor: ->
    super
    @load()

  # fetch data, render view
  load: ->
    @startLoading()
    @ajax(
      id:    'version'
      type:  'GET'
      url:   "#{@apiPath}/version"
      success: (data) =>
        @stopLoading()
        @version = data.version
        @render()
    )

  render: ->

    @html App.view('bot')(
      version: @version
    )

App.Config.set('Version', { prio: 3800, name: 'Bot Configuration', parent: '#bot', target: '#bot/config', controller: Index, permission: ['admin.version'] }, 'NavBarBot' )
