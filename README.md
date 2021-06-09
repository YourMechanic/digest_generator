# DigestGenerator

A simple digest generator which uses xxhash for digest generation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'digest_generator', :branch => 'master' 
```

And then execute:
```ruby
    $ bundle install
```

## Usage

This gem can be used in two ways:

### To generate Hash 64 and mask bit 63 (0-63) (to remove signedness to be compatible with postgress bigints) call: <br/>

```ruby
DigestGenerator.digest_63bit(payload)
```

You can also set algorithm to xxHash32 or xxHash64 for digest generation
```ruby
DigestGenerator.algorithm = 'xxHash32'
DigestGenerator.digest_63bit(payload)
```

Supported Algorithms are: xxHash, xxHash32 and xxHash64

### To use digest as a primary key for a model you need to include DigestGenerator module and define DIGEST_VALID_KEYS as:

```ruby
include DigestGenerator
self.primary_key = 'digest'
DIGEST_VALID_KEYS = %w[
    name
  ].freeze

```

Call refresh_digest on an instance of your model to set its digest value. <br/>
```ruby
person = Person.new(name: 'something')
# (Set the supported algorithm. As xxHash is the default algorithm you can skip this step if you want to use xxHash algorithm.)
person.algorithm = 'xxHash'
# (now your digest key is set to 64 bit and mask bit 63 (0-63) value)
person.refresh_digest 

```

You can also set algorithm by creating a file digest_generator.rb in config/initializers folder
 with: <br/>
```ruby
# You can also set algorithm to xxHash32 or xxHash64 for digest generation
DigestGenerator.algorithm = 'xxHash' 
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DigestGenerator project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/digest_generator/blob/master/CODE_OF_CONDUCT.md).
