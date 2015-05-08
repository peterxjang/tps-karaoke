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
  'click': (event) ->
    $('.ui.message').hide()
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
            $message.focus()
          else
            $progress = $('#progress-song-upload')
            $progress.progress({total: newItems.length})
            $progress.show()
            console.log newItems.length
            # Meteor.call('addSongs', newItems, (err, result) ->
            #   if err
            #     $message.addClass('error')
            #     $message.children('p').text(err)
            #     $message.focus()
            #     $message.show()
            #   else
            #     $message.addClass('success')
            #     $message.children('p').text("Inserted #{result?.length} out of #{newItems.length} songs")
            #     $message.focus()
            #     $message.show()
            # )
            for song in newItems
              # Meteor.call('addSong', song.artist, song.title, (err, result) ->
              #   if err
              #   else
              #     console.log 'hi'
              #     $progress.progress('increment')
              # )
              Meteor.call('addSong', song.artist, song.title)
              $progress.progress('increment')
              # Meteor.apply('addSong', [song.artist, song.title], wait: false, onResultReceived: (err, result) ->
              #   if err
              #   else
              #     console.log 'hi'
              #     $progress.progress('increment')
              # )
    })
    false

Template.admin.rendered = ->
  $('.menu .item').tab()
