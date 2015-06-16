# Slimdown

Slimdown is a simple gem to allow you to easily add static pages to your app
via a folder full of Markdown files.

Justin Heideman conceived and built the original version in PHP.

[![Build Status](https://travis-ci.org/APMG/ruby-slimdown.svg?branch=master)](https://travis-ci.org/APMG/ruby-slimdown)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slimdown'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install slimdown

## Usage

To add to your app, create a controller with one action, such as `show`. In that
action, add code to pull in the action:

    class SlimdownController < ApplicationController
      def show
        @page = Slimdown::Page.find(params[:slug])
      end
    end

Then add a view for the show action.

    <%= @page.body.to_html.html_safe %>

    <h2>Sibling Pages</h2>
    <ul>
      <% @page.siblings.each do |sibling| %>
        <li><%= link_to sibling.title, "/#{sibling.path}" %></li>
      <% end %>
    </ul>

    <h2>Child Pages</h2>
    <ul>
      <% @page.children.each do |child| %>
        <li><%= link_to child.title, "/#{child.path}" %></li>
      <% end %>
    </ul>

Add a route to direct all unhandled requests to your controller. Make sure that
it is at the end of your routes.rb so it doesn't superseed other routes.

    get '/*slug', to: 'slimdown#show'

Finally, add an initializer in `config/initializers/slimdown.rb` to set the path
to your pages.

    Slimdown.config do |c|
      c.location = Rails.root.join('lib/pages')
    end


## General notes

The use case for us is that we have a distinct repo containing the markdown (and
some other files) which is editable by producers. This is autodeployed to a
location on our servers which is accessible from our Rails app.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/apmg/ruby-slimdown/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
