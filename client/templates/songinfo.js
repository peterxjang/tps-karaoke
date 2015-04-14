Template.songinfo.helpers({
  currentSongTitle: function() {
    var info = Session.get('selectedSong');
    return info ? info.title : '';
  },
  currentSongArtist: function() {
    var info = Session.get('selectedSong');
    return info ? info.artist : '';
  }
});

Template.songinfo.loadLyrics = function(artist, title) {
  var url =  'http://api.lyricsnmusic.com/songs?' +
             'api_key=74fb7d12d34928ad62f09d18cd0842&' +
             'artist=' + artist + '&track=' + title;
  $.ajax({
    url: url,
    jsonp: 'callback',
    dataType: 'jsonp',
    data: {format: 'json'},
    success: function(response) {
      if (response.data.length > 0) {
        $('.song-lyrics-results').html(
          response.data[0].snippet.replace(/\n/g, '<br>')
        );
        $('.song-lyrics-results').append(
          '<div><a href=' + response.data[0].url +
          'target="_blank">View complete lyrics</a><div>'
        );
      } else {
        $('.song-lyrics-results').html('No lyrics found');
      }
    },
    error: function() {
      $('.song-lyrics-results').html('No lyrics found');
    },
    complete: function() {
      $('.ui.loading.segment').removeClass('loading');
    }
  });
};

Template.songinfo.loadAudioClip = function(artist, title) {
  var url = 'https://api.spotify.com/v1/search?' +
            'query=artist:' + artist + '+track:' + title + '&' +
            'limit=1&type=track';
  $.ajax({
    url: url,
    success: function(response) {
      var items = response.tracks.items;
      if (items.length > 0) {
        $('.song-preview').html(
          '<audio src="' + items[0].preview_url + '" controls></audio>'
        );
      } else {
        $('.song-preview').html('Preview not available');
      }
    }
  });
};

Template.songinfo.rendered = function() {
  $('#songinfo-modal').modal({
    onShow: function() {
      var info = Session.get('selectedSong');
      if (info) {
        var artist = info.artist.replace(/ /g, '%20');
        var title = info.title.replace(/\(([^)]+)\)/g, '').replace(/ /g, '%20');
        Template.songinfo.loadLyrics(artist, title);
        Template.songinfo.loadAudioClip(artist, title);
      } else {
        $('.song-lyrics-results').html('No lyrics found');
      }
    },
    onHide: function() {
      $('.ui.search').search('set value', '');
    },
    onHidden: function() {
      $(this).find('.song-preview').html('Preview');
      $('.song-lyrics-results').html('Loading lyrics...');
      $('.song-lyrics').show();
    }
  });
};
