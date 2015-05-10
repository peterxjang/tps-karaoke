Template.genreRequests.helpers
  genres: ->
    genres = Genres.find({}, sort: {name: 1}).fetch()
    total = genres.reduce ((a,b) -> a + b.votes), 0
    genres.map (item) ->
      name: item.name
      votes: item.votes
      percent: Math.round(100 * item.votes / total) or 0
      totalVotes: total
  alreadyVoted: ->
    IpAddresses.find({}).fetch().length > 0

Template.genreRequests.events
  'click #add-vote': (event) ->
    name = $(event.target).attr('name')
    Meteor.call 'addVote', name, (error) ->
      if error
        console.log error
        $('#error-vote-message').html(error.reason)
        $('.page.dimmer:first').dimmer('toggle')
