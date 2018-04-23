# SymbolSerializer

This gem contains a `SymbolSerializer` module which is intended to act as a concern for `ActiveJob::Base`. It allows us to use symbols as values in the queue payload, by serializing them before enqueueing them, and then deserializing the serialized values before the queue executes the code in any given job.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'symbol_serializer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install symbol_serializer

## Usage

Intended to be used as follows:
```
class YourJob < ActiveJob::Base
  include SymbolSerializer

  def perform(symbol_argument)
    ...
  end
end
```

## Development

<Add something here>

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Bizongo/symbol_serializer.
