Template.menu.toggleSearchMenu = function() {
  $('#search').toggle();
  $('#search-clicked').toggle();
  $('#username').toggle();
  $('#menu').toggle();
  $('#back').toggle();
};

Template.menu.helpers({
  username: function() {
    var user = Meteor.user();
    return user ? user.username : '';
  }
});

Template.menu.events({
  'click #menu': function(event) {
    $('.sidebar').sidebar('toggle');
  },
  'click #search': function(event) {
    Template.menu.toggleSearchMenu();
    $('#search-clicked input').focus();
  },
  'click #back': function(event) {
    Template.menu.toggleSearchMenu();
  }
});

Template.menu.rendered = function() {
  Meteor.call('getStaticSongs', function(error, result) {
    $('.ui.search').search({
      source: result,
      searchFields: ['title', 'artist'],
      searchFullText: true,
      maxResults: 4,
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
        $('#songinfo-modal').modal('show');
      }
    });
  });
};
