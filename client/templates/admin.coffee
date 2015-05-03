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
    file = $('input[type="file"]')[0].files[0]
    Papa.parse(file, {
      header: true
      complete: (csvResults) ->
        console.log(csvResults)
        Meteor.call 'getStaticSongs', (error, dbResults) ->
          dbResults = _.map(dbResults, (obj) -> _.pick(obj, 'artist', 'title'))
          console.log(dbResults)
          newItems = _.filter(csvResults.data, (obj) -> !_.findWhere(dbResults, obj) );
          console.log newItems
    })
    false

Template.admin.rendered = ->
  $('.menu .item').tab()
