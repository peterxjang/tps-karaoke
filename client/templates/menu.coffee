Template.menu.toggleSearchMenu = ->
  $('#search').toggle()
  $('#search-clicked').toggle()
  $('#username').toggle()
  $('#menu').toggle()
  $('#back').toggle()

Template.menu.helpers
  username: ->
    user = Meteor.user()
    if user then user.username else ''

Template.menu.events
  'click #menu': (event) ->
    $('.sidebar').sidebar('toggle')
  'click #search': (event) ->
    Template.menu.toggleSearchMenu()
    $('#search-clicked input').focus()
  'click #back': (event) ->
    Template.menu.toggleSearchMenu()

Template.menu.rendered = ->
  Meteor.call 'getStaticSongs', (error, result) ->
    source = result.map((item) -> 
      artist: item.artist, 
      title: item.title, 
      artist_title: "#{item.artist} #{item.title}"
      title_artist: "#{item.title} #{item.artist}"
    )
    $('.ui.search').search
      source: source,
      # searchFields: ['title', 'artist', 'artist_title'],
      searchFields: ['artist_title', 'title_artist'],
      searchFullText: true,
      maxResults: 4,
      type: 'special',
      templates:
        special: (response) ->
          response.results
            .map (item) -> Blaze.toHTMLWithData(Template.searchResults, item)
            .join('')
      onSelect: (results, response) ->
        Session.set('selectedSong', results)
        $('#songinfo-modal').modal('show')
