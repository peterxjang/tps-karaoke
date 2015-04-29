Songs = new Mongo.Collection('songs');

// Songs.allow({
//   'insert': function() {return true;},
//   'remove': function() {return true;}
// });

Meteor.methods({
  'getStaticSongs': function() {
    // console.log('getStaticSongs', Songs.find({}).fetch());
    return Songs.find({}, {fields: {'artist': 1, 'title': 1}}).fetch();
    // return [{'title': 'test title', 'artist': 'test artist'}];
  }
});
