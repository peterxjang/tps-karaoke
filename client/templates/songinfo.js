Template.songinfo.helpers({
  currentSongTitle: function() {
    var info = Session.get('selectedSong');
    return info ? info.title : '';
  },
  currentSongArtist: function() {
    var info = Session.get('selectedSong');
    return info ? info.artist : '';
  },
  currentSongAudioPreview: function() {
    var info = Session.get('selectedSong');
    if (info) {
      var artist = info.artist.replace(/ /g, '%20');
      var title = info.title.replace(/\(([^)]+)\)/g, '').replace(/ /g, '%20');
      return 'https://api.spotify.com/v1/search?' +
             'query=artist:' + artist + '+track:' + title + '&' +
             'limit=1&type=track';
    } else {
      return '#';
    }
  },
  currentSongLyrics: function() {
    var info = Session.get('selectedSong');
    if (info) {
      var artist = info.artist.replace(/ /g, '%20');
      var title = info.title.replace(/\(([^)]+)\)/g, '').replace(/ /g, '%20');
      // return 'http://lyrics.wikia.com/api.php?func=getSong&fmt=realjson&' +
        // 'artist=' + artist + '&song=' + title + '?callback=?';
      return 'http://api.lyricsnmusic.com/songs?' +
        'api_key=74fb7d12d34928ad62f09d18cd0842&' +
        'artist=' + artist + '&track=' + title;
    } else {
      return '#';
    }
  }
});

Template.songinfo.rendered = function() {
  Template.songinfo.audioObject = new Audio();

  $('#songinfo-modal').modal({
    onHide: function() {
      Template.songinfo.audioObject.pause();
      $('.ui.search').search('set value', '');
    },
    onHidden: function() {
      $(this).find('.song-preview').html('Preview');
      $('.song-lyrics-results').html('');
      $('.song-lyrics').show();
    }
  });

  // Should use Template.songinfo.events({}) instead,
  // but it conflicts with Semantic-UI modal
  $('.song-preview').on('click', function(e) {
    e.preventDefault();
    var that = this;
    if ($(this).html() === 'Preview') {
      $(this).html('Loading...');
      $.ajax({
        url: $(this).attr('href'),
        success: function(response) {
          var items = response.tracks.items;
          if (items.length > 0) {
            // console.log(items[0].album.images[2].url);
            if (Template.songinfo.audioObject.src != items[0].preview_url) {
              Template.songinfo.audioObject = new Audio(items[0].preview_url);
            }
            Template.songinfo.audioObject.play();
            $(that).html('Pause');
          } else {
            $(that).html('Preview not available');
          }
        }
      });
    } else if ($(this).html() === 'Pause') {
      Template.songinfo.audioObject.pause();
      $(that).html('Preview');
    }
  });

  $('.song-lyrics').on('click', function(e) {
    e.preventDefault();
    $.ajax({
      url: $(this).attr('href'),
      jsonp: 'callback',
      dataType: 'jsonp',
      data: {format: 'json'},
      success: function(response) {
        if (response.data.length > 0) {
          console.log(response.data[0].snippet);
          $('.song-lyrics-results').html(response.data[0].snippet.replace(/\n/g, '<br>'));
          $('.song-lyrics-results').append(
            '<div><a href=' + response.data[0].url +
            ' target="_blank">View complete lyrics</a><div>'
          );
          $('.song-lyrics').hide();
        }
      }
    });
  });
};
