Router.configure({
    layoutTemplate: 'layout',
    // loadingTemplate: 'loading',
    // notFoundTemplate: 'pageNotFound',
    // yieldTemplates: {
        // nav: {to: 'nav'},
        // footer: {to: 'footer'},
    // }
});

Router.route('/', function() {
  this.render('home');
});
