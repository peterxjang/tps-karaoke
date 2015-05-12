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
  isAdmin: ->
    Meteor.user()?.profile?.isAdmin

Template.genreRequests.events
  'click #add-vote': (event) ->
    name = $(event.target).attr('name')
    Meteor.call 'addVote', name, (error) ->
      if error
        console.log error
        $('#error-vote-message').html(error.reason)
        $('.page.dimmer:first').dimmer('toggle')
  'click #button-clear-votes': (event) ->
    $(event.target).blur()
    $('#modal-clear-votes')
      .modal
        closable  : false
        onApprove : ->
          console.log 'approved'
          Meteor.call 'clearVotes'
      .modal('show')

  'click #button-add-genre': (event) ->
    $('#form-submit-genre').show()
    $('#form-submit-genre input').focus()
  'submit #form-submit-genre': (event) ->
    name = $('#form-submit-genre input').val().trim()
    if name isnt ""
      Meteor.call 'addGenre', name
      $('#form-submit-genre').hide()
      $('#form-submit-genre')[0].reset()
    false
  'click #button-cancel': (event) ->
    $('#form-submit-genre').hide()
