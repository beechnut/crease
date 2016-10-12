# Crease

## Usage

Let's say you're writing a dynamic report that needs to put data in context,
explaining it in simple English.

You want to tell the world that total population in Boston increased, and that
the total population in Worcester decreased, but want to write one template that
takes in data from each city and displays the right text.

With Crease, you can write:

```ruby'
# app/views/city/report.html.erb
<p>
  In <%= @city.name %>, the total population
  <%= increased.by @city.population_in_2000, @city.population_in_2010 %>,
  <%= an.increase.of(@city.population_in_2000, @city.population_in_2010).percent %>,
<p>

# For Boston, this evaluates to:

<p>
  In Boston, the total population increased by 30,018, an increase of 105%.
<p>
```

> Note: we think that '105%' here is misleading: see the roadmap for more.

#### Examples

The following are examples of text you can write with Crease.

```ruby
# In the context of a template

increased.by(1)            #=> 'increased by 1.0'
increased.by(2, 4)         #=> 'increased by 2.0'
decreased.by(1)            #=> 'increased by 1.0'
decreased.by(2, 4)         #=> 'increased by 2.0'
increased.by(1).percent    #=> 'increased by 1.0%'
increased.by(2, 4).percent #=> 'increased by 200.0%'
an.increase.of(2)          #=> 'an increase of 2.0'
```

Inside templates, these method chains will be implicitly converted to strings,
with ERb or Haml calling `#to_s` on them.

If you are working with these outside of a template, you'll need to call `#to_s`
at the end of the method chain yourself.

```ruby
# Outside a template

increased.by(1)       #=> #<Crease::Builder:0x007fecf8a35c90 @criteria={:context=>nil, :tense=>:past, :word=>:by, :args=>[1.0], :sigfig=>2}>
increased.by(1).to_s  #=> 'increased by 1.0'
```

For dynamic templates, pass in variables instead of fixed numbers.

#### Options

## Installation

Add this line to your application's Gemfile:

```rubyinc
gem 'crease'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install crease

#### Rails

Include the `TextHelpers` module in your `ApplicationHelper`, or a more specific
helper if appropriate.

```ruby
# app/helpers/application_helper.rb

class ApplicationHelper
  include Crease::TextHelpers

  # ... other helper code
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/beechnut/crease. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Roadmap

- Significant digits are passed in differently from other options, and we're not testing whether it's possible to convert them to integers.
- We'd like to have a way to configure the gem -- for Rails, in an initializer -- so that we can specify default significant figures there. If someone wants everything to be an integer by default, it would be easier to do it there.
  - Might even allow a Proc-based option that sets sigfigs dynamically.
- Add documentation about understanding sigfigs.
- Right now, `increased.by(2, 4).percent` returns "increased by 200.0%", which is a little misleading. We want `changed.by(2, 4).percent` to say "changed by 200.0%", and `increased.by(2, 4).percent` to say "increased by 100%".


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

