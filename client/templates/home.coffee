Template.home.helpers
  tasks: ->
    if (Session.get('hideCompleted'))
      Tasks.find({checked: {$ne: true}}, {sort: {createdAt: -1}})
    else
      Tasks.find({}, {sort: {createdAt: -1}})
  hideCompleted: ->
    Session.get('hideCompleted')
  incompleteCount: ->
    Tasks.find({checked: {$ne: true}}).count()
  songs: ->
    Songs.find()


Template.home.events
  'submit .new-task': (event) ->
    text = event.target.text.value
    Meteor.call('addTask', text)
    event.target.text.value = ''
    false
  'submit #form-message': (event) ->
    text = event.target.message.value
    Meteor.call 'addMessage', text, (err) ->
      if err
        $('#form-message .error.message p').html err.reason
        $('#form-message .error.message').show()
      else
        $('#form-message .success.message p').html 'Message sent!'
        $('#form-message .success.message').show()
    $('#form-message input').val('')
    $('#form-message input').focus()
    false
  'click #form-message input': (event) ->
    $('#form-message .success.message').hide()
    $('#form-message .error.message').hide()
  'click .close.icon': (event) ->
    $(event.target).closest('.message').hide()
  'change .hide-completed input': (event) ->
    Session.set('hideCompleted', event.target.checked)

Template.home.rendered = ->
  $('.menu .item').tab()

