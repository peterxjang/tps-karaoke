Router.configure({
    layoutTemplate: 'layout',
    // loadingTemplate: 'loading',
    // notFoundTemplate: 'pageNotFound',
    // yieldTemplates: {
        // nav: {to: 'nav'},
        // footer: {to: 'footer'},
    // }
});

var isAdmin = function() {
  var facebookEmail = ((Meteor.user() || {}).profile || {}).facebookEmail;
  return facebookEmail === 'peter.jang@yahoo.com';
};

Router.route(
  '/',
  function() {
    this.render('home');
  },
  {name: 'home'}
);

Router.route('/admin',
  function() {
    this.render('admin');
  },
  {name: 'admin'}
);

Router.onBeforeAction(
  function() {
    if (isAdmin()) {
      this.redirect('admin');
    } else {
      this.next();
    }
  },
  {only: ['home']}
);

Router.onBeforeAction(
  function() {
    if (isAdmin()) {
      this.next();
    } else {
      this.redirect('home');
    }
  },
  {only: ['admin']}
);
