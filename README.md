[![Gem Version](https://badge.fury.io/rb/rails_pattern_view.svg)](https://badge.fury.io/rb/rails_pattern_view)

# RailsPatternView

Ever annoyed with having to copy/paste the Rails views around for very common pages, this gem will solve it
Creaet your view folder (pattern) once and instruct your controller to use that pattern

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
views/shared/patterns/ajax_table/new.erb
views/shared/patterns/ajax_table/edit.erb
views/dogs/edit.erb
```

Both CatsController & DogsController now can share the views within ajax_table

Options

only
```
use_pattern :ajax_table, only: [:create, :update, :destroy]
```

except
```
user_pattern :ajax_table, except: [:new]
```

mapping
```
use_pattern :ajax_table, mapping: {:refresh_table => [:create, :update, :destroy]}
```
all "create/update/destroy" actions will now render "views/shared/patterns/ajax_table/refresh_table"

template
```
use_pattern :ajax_table, only: [:create, :update, :destroy], template: 'refresh_table'
```

Notes:

only & except can't be mixed

mapping & template can't be mixed

## Development

Run specs with `rspec spec`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nqtien310/rails_pattern_view. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

