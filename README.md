# Crease

Generate dynamic text about increasing and decreasing numbers.

## Usage

Let's say you're writing a dynamic report that needs to put data in context, explaining it in simple English.

You want to tell the world that the total population of Boston increased, and that the total population in Pittsburgh decreased, but you only want to write one template that takes in data from each city and displays the right text.


__With Crease, you just write:__

```ruby'
# In any ERb (or Haml) template, i.e. app/views/city/report.html.erb
<p>
  In <%= @city.name %>, the total population
  <%= increased.by @city.population_in_2000, @city.population_in_2010 %>,
  <%= an.increase.of(@city.population_in_2000, @city.population_in_2010).percent %>,
<p>
```

And it will work for both cities.


For Boston, this evaluates to:

```
<p>
  In Boston, the total population increased by 30,018, an increase of 5.08%%.
<p>
```

For Pittsburgh, the same template evaluates to:

```
<p>
  In Pittsburgh, the total population decreased by 28,068, an decrease of 8.41%.
<p>
```

> Source of the above data: [Boston](https://www.google.com/#q=boston+population+2010) | [Pittsburgh](https://www.google.com/#q=pittsburgh+population+2010)


#### Examples

The following are examples of text you can write with Crease.

```ruby
# In the context of a template

# Increase or decrease with one number
increased.by(1)            #=> "increased by 1.0"
increased.by(-1)           #=> "decreased by 1.0"

# Increase or decrease with two numbers
increased.by(2, 4)         #=> "increased by 2.0"
an.increase.of(2)          #=> "an increase of 2.0"
decreased.by(2, 4)         #=> "increased by 2.0"
  # `#decreased` is just an alias for `#increased`

# Percent increase or decrease with one number, percent
increased.by(1).percent    #=> "increased by 1.0%"

# Percent increase or decrease with two numbers, percent
increased.by(2, 4).percent #=> "increased by 100.0%"
increased.by(4, 1).percent #=> "decreased by 75.0%"

# Change with one number
a.change.of(2) #=> "a change of 2.0"
changed.by(-2) #=> "changed by -2.0"

# Change with two numbers
changed.by(1, 2) #=> "changed by 1.0"
a.change.of(4, 2) #=> "a change of -2.0"

# Percent change with one numbers
changed.by(2).percent #=> "changed by 2.0%"
a.change.of.by(2).percent #=> "changed by 2.0%"

# Percent change with two numbers
changed.by(2, 4).percent   #=> "changed by 200.0%"
a.change.of(2, 4).percent  #=> "a change of 200.0%"
a.change.of(4, 1).percent  #=> "a change of -300.0%"
  # This is a little misleading, and will be taken under advisement.
```

Inside templates, these method chains will be implicitly converted to strings, with ERb or Haml calling `#to_s` on them.

If you are working with these outside of a template, you'll need to call `#to_s` at the end of the method chain yourself.

```ruby
# Outside a template

increased.by(1)       #=> #<Crease::Builder:0x007fdaa19a6db0 @before=nil, @subject=nil, @after=:by, @args=[1.0], @percent=false, @tense=:past, @sigfig=2>
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

Include the TextHelpers module in your ApplicationHelper.

```ruby
# app/helpers/application_helper.rb

class ApplicationHelper
  include Crease::TextHelpers

  # ... other helper code
end
```

You can optionally configure Crease to convert all results to integers, or set a number of significant digits to round to.

```ruby
# Create a file config/initializers/crease.rb

Crease.configure do |config|
  # Round every result to a specific number of significant digits.
  config.digits  = 3    # Defaults to 2.

  # Convert every result to integer. This option ignores the digits option.
  config.integer = true # Defaults to false.
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/beechnut/crease. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Roadmap

- Allow a Proc-based option that sets sigfigs dynamically.
- Add documentation about understanding sigfigs.



## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

