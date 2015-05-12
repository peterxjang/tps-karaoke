Template.adminMessageFeed.helpers
  messages: ->
    messages = Messages.find({}, {limit: Session.get('limitMessages'), sort: {createdAt: -1}})
    messages.map (message) ->
      return {
        username: message.username,
        text: message.text,
        createdAt: moment(message.createdAt).fromNow()
      }

Template.admin.events
  'click .close.icon': (event) ->
    $(event.target).closest('.message').hide()
  'click': (event) ->
    $('.ui.message').hide()
  'click #button-more-messages': (event) ->
    newLimit = Session.get('limitMessages') + 5;
    Session.set('limitMessages', newLimit);
  'submit #form-csv': (event) ->
    event.preventDefault()
    $message = $('.ui.message')
    $message.removeClass('error')
    $message.removeClass('success')
    $message.children('p').text('')
    $message.show()

    file = $('input[type="file"]')[0].files[0]
    Papa.parse(file, {
      header: true
      complete: (csvResults) ->
        Meteor.call 'getStaticSongs', (error, dbResults) ->
          dbResults = _.map(dbResults, (obj) -> _.pick(obj, 'artist', 'title'))
          newItems = _.filter(csvResults.data, (obj) -> !_.findWhere(dbResults, obj) )
          if newItems.length == 0
            $message.children('p').text('No songs to add.')
          else
            console.log newItems.length
            Meteor.call('addSongs', newItems, (err, result) ->
              if err
                $message.addClass('error')
                $message.children('p').text(err)
                $message.show()
              else
                $message.addClass('success')
                $message.children('p').text("Inserted #{result?.length} out of #{newItems.length} songs")
                $message.show()
            )
    })
    false

Template.admin.rendered = ->
  $('.menu .item').tab()
