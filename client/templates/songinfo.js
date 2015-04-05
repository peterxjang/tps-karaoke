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
  }
});

$(document).on('click', '.song-preview', function(e) {
  e.preventDefault();
  var that = this;
  // var audioObject;
  if ($(this).html() === 'Preview') {
    $(this).html('Loading...');
    $.ajax({
      url: $(this).attr('href'),
      success: function(response) {
        var items = response.tracks.items;
        if (items.length > 0) {
          // console.log(items[0].album.images[2].url);
          audioObject = new Audio(items[0].preview_url);
          audioObject.play();
          $(that).html('Pause');
        } else {
          $(that).html('Preview not available');
        }
      }
    });
  } else if ($(this).html() === 'Pause') {
    audioObject.pause();
    $(that).html('Preview');
  }
});
