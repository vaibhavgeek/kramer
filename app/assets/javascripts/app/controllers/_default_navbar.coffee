App.Config.set('History', [])
App.Config.set('Home', { prio: 100, parent: '', name: 'Dashboard', translate: true, target: '#dashboard', icon: 'dashboard', permission: ['admin.*'] }, 'NavBarRight')

App.Config.set('Admin', { prio: 9300, parent: '', name: 'Admin', translate: true, target: '#manage', icon: 'cog', permission: ['admin.*'] }, 'NavBarRight')
App.Config.set('Bot', { prio: 9200, parent: '', name: 'Bot', translate: true, target: '#bot', icon: 'cog', permission: ['admin.*'] }, 'NavBarRight')
App.Config.set('User', {
  prio:   30000,
  parent: '',
  callback: ->
    item         = {}
    item['name'] = App.Session.get('login')
    return item
  target: '#current_user',
  class:  'user'
}, 'NavBarRight' )
App.Config.set('TicketOverview', { prio: 1000, parent: '', name: 'Overviews', target: '#ticket/view', key: 'TicketOverview', permission: ['ticket.agent', 'ticket.customer'], icon: 'overviews' }, 'NavBarRight')

App.Config.set('New', { prio: 20000, parent: '', name: 'New', translate: true, target: '#new', class: 'add', icon: 'plus' }, 'NavBarRight')
#App.Config.set('Misc', { prio: 90000, parent: '', name: 'Tools', translate: true, target: '#tools', child: true, class: 'tools' }, 'NavBar')
# only for testing
#App.Config.set('Misc1', { prio: 1600, parent: '#tools', name: 'Test 1', target: '#test1', permission: ['admin'] }, 'NavBar')
#App.Config.set('Misc2', { prio: 1700, parent: '#tools', name: 'Test 2', target: '#test2', permission: ['admin'] }, 'NavBar')
