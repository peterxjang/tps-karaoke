Template.adminMessageFeed.helpers
  messages: ->
    messages = Messages.find({}, {limit: 10, sort: {createdAt: -1}})
    messages.map (message) ->
      return {
        username: message.username,
        text: message.text,
        createdAt: moment(message.createdAt).fromNow()
      }

Template.adminGenreRequests.helpers
  genres: ->
    genres = Genres.find({}, sort: {name: 1}).fetch()
    total = genres.reduce ((a,b) -> a + b.votes), 0
    genres.map (item) ->
      name: item.name
      votes: item.votes
      percent: Math.round(100 * item.votes / total) or 0
      totalVotes: total

Template.admin.events
  'click .close.icon': (event) ->
    $(event.target).closest('.message').hide()
  'click': (event) ->
    $('.ui.message').hide()
  'click #button-clear-votes': (event) ->
    Meteor.call 'clearVotes'
  'click #button-add-genre': (event) ->
    $('#input-submit-genre').show()
  'click #input-submit-genre button': (event) ->
    name = $('#input-submit-genre input').val().trim()
    if name isnt ""
      Meteor.call 'addGenre', name
      $('#input-submit-genre').hide()
  'click #add-vote': (event) ->
    name = $(event.target).attr('name')
    Meteor.call 'addVote', name
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
