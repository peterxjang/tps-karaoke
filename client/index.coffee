Template.body.helpers
  tasks: () ->
    if (Session.get('hideCompleted'))
      return Tasks.find({checked: {$ne: true}}, {sort: {createdAt: -1}})
    else
      return Tasks.find({}, {sort: {createdAt: -1}})
  hideCompleted: () ->
    console.log "yoyoyo"
    return Session.get('hideCompleted')
  incompleteCount: () ->
    return Tasks.find({checked: {$ne: true}}).count()
  songs: () ->
    return Songs.find()


Template.body.events
  'submit .new-task': (event) ->
    text = event.target.text.value
    Meteor.call('addTask', text)
    event.target.text.value = ''
    return false
  'change .hide-completed input': (event) ->
    Session.set('hideCompleted', event.target.checked)
  'click #menu': (event) ->
    $('.sidebar').sidebar('toggle')

# // Accounts.ui.config({
# //   passwordSignupFields: 'USERNAME_ONLY'
# // });
# // $('.ui.modal').modal();
