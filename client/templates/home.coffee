Template.home.helpers
  tasks: () ->
    if (Session.get('hideCompleted'))
      return Tasks.find({checked: {$ne: true}}, {sort: {createdAt: -1}})
    else
      return Tasks.find({}, {sort: {createdAt: -1}})
  hideCompleted: () ->
    return Session.get('hideCompleted')
  incompleteCount: () ->
    return Tasks.find({checked: {$ne: true}}).count()
  songs: () ->
    return Songs.find()


Template.home.events
  'submit .new-task': (event) ->
    text = event.target.text.value
    Meteor.call('addTask', text)
    event.target.text.value = ''
    return false
  'submit #form-message': (event) ->
    text = event.target.message.value
    Meteor.call('addMessage', text, (err) ->
      if err
        console.log "Something wrong bro"
    )
    $('#form-message input').val('')
    $('#form-message input').focus()
    return false
  'change .hide-completed input': (event) ->
    Session.set('hideCompleted', event.target.checked)

Template.home.rendered = ->
  $('.menu .item').tab()