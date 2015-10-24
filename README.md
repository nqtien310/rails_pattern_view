# RailsPatternView

Ever annoyed with having to copy/paste the Rails views around for very common pages, this gem will solve it

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_pattern_view'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_pattern_view

## Usage

```
class CatsController < ApplicationController
  use_pattern :ajax_table

  def new; end
  def edit; end
end

class DogsController < ApplicationController
  use_pattern :ajax_table, only: [:new]

  def new; end
  def edit; end
end

```
Add this in your views

```
views/patterns/ajax_table/new.erb
views/patterns/ajax_table/edit.erb
views/dogs/edit.erb
```

Both CatsController & DogsController now can share the views within ajax_table

Options

only
```
use_pattern :ajax_table, only: [:new, :edit]
```

except
```
user_pattern :ajax_table, except: [:some_action]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rails_pattern_view. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

