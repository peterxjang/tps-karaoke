Template.admin.helpers
  messages: ->
    messages = Messages.find({}, {limit: 10, sort: {createdAt: -1}})
    messages.map (message) ->
      return {
        username: message.username,
        text: message.text,
        createdAt: moment(message.createdAt).fromNow()
      }

Template.admin.events
  'click .close.icon': (event) ->
    $(event.target).closest('.message').hide()
  'submit #form-csv': (event) ->
    event.preventDefault()
    # $('#progress-song-upload').show()
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
            # $('#progress-song-upload').hide()
            # $message.hide()
            $message.children('p').text('No songs to add.')
          else
            # $('#progress-song-upload').attr('data-total', newItems.length)
            console.log newItems
            Meteor.call('addSongs', newItems, (err, result) ->
              if err
                $message.addClass('error')
                $message.children('p').text(err)
                $message.show()
              else
                $message.addClass('success')
                $message.children('p').text("Inserted #{result?.length} out of #{newItems.length} songs")
                $message.show()
                # $('.ui.success.message p').text("Inserted #{result?.length} out of #{newItems.length} songs")
                # $('.ui.success.message').show()
            )
            # console.log ids
            # $('.ui.success.message p').text("Inserted #{ids?.length} out of #{newItems.length} songs")
            # $('.ui.success.message').show()

            # errors = []
            # for song in newItems
            #   Meteor.call('addSong', song.artist, song.title, (err, id) ->
            #     if err
            #       errors.push(err)
            #     else
            #       $('#progress-song-upload').progress('increment')
            #   )
    })
    false

Template.admin.rendered = ->
  $('.menu .item').tab()
