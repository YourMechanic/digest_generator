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

To generate Hash 64 and mask bit 63 (0-63) (to remove signedness to be compatible with postgress bigints) call: <br/>

DigestGenerator.digest_63bit(payload) <br/>

To use digest attribute as primary key in a model class you need to include DigestGenerator module and define DIGEST_VALID_KEYS as: <br/>

DIGEST_VALID_KEYS = %w[
    name
  ].freeze

<br/>
Call refresh_digest on an instance of your model to set its digest value. <br/>

person = Person.new(name: 'something') <br/>
person.refresh_digest  (your digest key is set to 64 bit unique value)  <br/>


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DigestGenerator project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/digest_generator/blob/master/CODE_OF_CONDUCT.md).
