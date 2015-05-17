Template.home.helpers
  songs: ->
    Songs.find()

Template.home.events
  'submit #form-message': (event) ->
    text = event.target.message.value
    Meteor.call 'addMessage', text, (err) ->
      if err
        $('#form-message div.input').addClass('error')
        $('#form-message input').attr('placeholder', err.reason)
      else
        $('#form-message div.input').addClass('positive')
        $('#form-message input').attr('placeholder', 'Message sent successfully!')
    $('#form-message input').val('')
    false
  'click #form-message input': (event) ->
    $('#form-message').form('clear')
    $('#form-message input').attr('placeholder', 'Send a message to the DJ!')

Template.home.rendered = ->
  $('.menu .item').tab()
