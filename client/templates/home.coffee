Template.home.helpers
  songs: ->
    Songs.find()


Template.home.events
  'submit #form-message': (event) ->
    text = event.target.message.value
    Meteor.call 'addMessage', text, (err) ->
      if err
        $('#form-message .error.message p').html err.reason
        $('#form-message .error.message').show()
      else
        $('#form-message .success.message p').html 'Message sent successfully!'
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

