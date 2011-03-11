# Assets Packager
## A bundler for your javascripts and stylesheets.

When you deploy your application it could be convenient to package all your
stylesheets and javascripts in a single file, let say all.css and all.js, in
order to decrease the HTTP requests against your server.

You may also find useful to reduce the size of those files, through a process
which eliminates all unneeded white spaces and comments.

`Assets Packager` helps you to solve these problems.

## Installation

    # Gemfile
    gem 'assets_packager'

    # lib/tasks/assets.rake
    require 'assets_packager/tasks'

    # shell
    $ rake assets:install

If you are in a `Rails` context, you don't need to setup anything else,
otherwise you can specify your paths:

    AssetsPackager.configure do |config|
      config.root_path = '/path/to/public/folder'
      config.file_path = '/path/to/assets.yml'
    end

## Assets configuration
Once you use new assets to your application, just add the to the configuration
file (look at `config/assets.yml`):

    ---
    css:
    - application
    - jquery-ui
    js:
    - jquery
    - jquery-ui
    - application

Make sure to include library first, you may want to add `jquery.js` before of
`application.js`.

## Usage
`Assets Packager` has a lot of useful `Rake` tasks (`rake -T assets`), the most
important is `assets:package`: it merge and compress all your javascripts and
stylesheets. Use it as `Capistrano` post deploy hook.

If you're using `Rails`, in order to take advantage of bundled assets,
you should use `:cache => true` option:

    <%= javascript_include_tag 'jquery', 'jquery-ui', 'application', :cache => true %>
    <%= stylesheet_link_tag 'application', 'jquery-ui', :cache => true %>

There are some contexts where you can't bundle assets at deploy time (like `Heroku`),
what you can do is to reference directly to `all.js` or `all.css`:

    <%= javascript_include_tag 'all' %>
    <%= stylesheet_link_tag 'all' %>

In this way you have to bundle assets on your development machine and put them under
version control.

## Credits
`Assets Packager` was strongly inspired by the homonym plugin written by
[Scott Becker](http://synthesis.sbecker.net/).

Uladzislau Latynski for his jsmin.rb Ruby porting.

Thanks to [Steve Souders](http://stevesouders.com/) for his [High Performance
Web Sites](http://oreilly.com/catalog/9780596529307) book.

Copyright 2011 Luca Guidi - [www.lucaguidi.com](www.lucaguidi.com) - Released under MIT License