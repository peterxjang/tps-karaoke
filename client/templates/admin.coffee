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
  'submit #form-csv': (event) ->
    event.preventDefault()
    $('#progress-song-upload').show()
    file = $('input[type="file"]')[0].files[0]
    Papa.parse(file, {
      header: true
      complete: (csvResults) ->
        Meteor.call 'getStaticSongs', (error, dbResults) ->
          dbResults = _.map(dbResults, (obj) -> _.pick(obj, 'artist', 'title'))
          newItems = _.filter(csvResults.data, (obj) -> !_.findWhere(dbResults, obj) );
          if newItems.length == 0
            $('#progress-song-upload').hide()
          else
            $('#progress-song-upload').attr('data-total', newItems.length)
            console.log newItems
            errors = []
            for song in newItems
              Meteor.call('addSong', song.artist, song.title, (err, id) ->
                if err
                  errors.push(err)
                else
                  $('#progress-song-upload').progress('increment')
              )
    })
    false

Template.admin.rendered = ->
  $('.menu .item').tab()
