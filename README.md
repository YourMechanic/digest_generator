# DigestGenerator

A simple 64 bit digest generator which uses xxhash for digest generation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'digest_generator', :branch => 'main' 
```

And then execute:

    $ bundle install


## Usage

This gem can be used in two ways:

1. To generate Hash 64 and mask bit 63 (0-63) (to remove signedness to be compatible with postgress bigints) call: <br/>

DigestGenerator.digest_63bit(payload) <br/>

2. To use digest as a primary key for a model you need to include DigestGenerator module and define DIGEST_VALID_KEYS as: <br/>

DIGEST_VALID_KEYS = %w[
    name
  ].freeze

<br/>
Call refresh_digest on an instance of your model to set its digest value. <br/>

person = Person.new(name: 'something') <br/>
person.algorithm = 'xxHash'  (Set the supported algorithm. Presently only xxHash is supported.)<br/>
person.refresh_digest  (now your digest key is set to 64 bit unique value)  <br/>

You can also set algorithm by creating a file digest_generator.rb in config/initializers folder with: <br/>

DigestGenerator.algorithm = 'xxHash'

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DigestGenerator project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/digest_generator/blob/master/CODE_OF_CONDUCT.md).
