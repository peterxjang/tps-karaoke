Template.sidebar.onRendered = ->
  console.log 'sidebar rendered'

Template.sidebar.events
  'click a': (event) ->
    $('.sidebar').sidebar('toggle')
  'click #sign-out': (event) ->
    Meteor.logout()
    $('.sidebar').sidebar('toggle')
