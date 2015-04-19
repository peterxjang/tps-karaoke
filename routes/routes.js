Router.configure({
    layoutTemplate: 'layout',
    // loadingTemplate: 'loading',
    // notFoundTemplate: 'pageNotFound',
    // yieldTemplates: {
        // nav: {to: 'nav'},
        // footer: {to: 'footer'},
    // }
});

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
    if ((Meteor.user() || {}).username == 'Peter Jang') {
      this.redirect('admin');
    } else {
      this.next();
    }
  },
  {only: ['home']}
);

Router.onBeforeAction(
  function() {
    if ((Meteor.user() || {}).username == 'Peter Jang') {
      this.next();
    } else {
      this.redirect('home');
    }
  },
  {only: ['admin']}
);
