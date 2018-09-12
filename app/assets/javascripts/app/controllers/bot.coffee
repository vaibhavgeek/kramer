class App.Bot extends App.ControllerNavSidbar
  header: 'Bot Settings'
  authenticateRequired: true
  configKey: 'NavBarBot'

class BotRouter extends App.ControllerPermanent
  requiredPermission: ['*']

  constructor: (params) ->
    super

    # check authentication
    @authenticateCheckRedirect()

    App.TaskManager.execute(
      key:        'Bot'
      controller: 'Bot'
      params:     {}
      show:       true
      persistent: true
    )
App.Config.set('bot', BotRouter, 'Routes')    
App.Config.set('Bot', { controller: 'Bot', permission: ['admin.*'] }, 'permanentTask')

App.Config.set('Bot Conifguration', { prio: 1000, name: 'Bot Settings', target: '#bot', permission: ['admin.*'] }, 'NavBarBot')

