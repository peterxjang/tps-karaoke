Meteor.subscribe('tasks');
Meteor.subscribe('songs', function onReady() {
  // https://github.com/Semantic-Org/Semantic-UI/issues/1998
  var content = Songs.find().fetch().map(function(it) {
    return {title: it.title, artist: it.artist};
  });
  $('.ui.search').search({
    source: content,
    searchFields: ['title', 'artist'],
    searchFullText: true,
    type: 'special',
    templates: {
      special: function(response) {
        return response.results
          .map(function(item) {
            return Blaze.toHTMLWithData(Template.searchResults, item);
          }).join('');
      }
    },
    onSelect: function(results, response) {
      Session.set('selectedSong', results);
      $('#songinfo-modal').modal({
        onHide: function() {
          Template.songinfo.audioObject.pause();
          $(this).find('.song-preview').html('Preview');
        }
      }).modal('show');
      $('.ui.search').search('set value', '');
    }
  });
});
