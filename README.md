# Bandoleer
### Turn your ruby files into ruby vials! (It's a container)

## Synopsis

Bandoleer is an IoC container focusing on the automatic extraction of constants from ruby files. Essentially it's a rather simple wrapper for the [canister](https://github.com/mlibrary/canister) gem, adding helper methods to abstract boilerplate for a particular pattern of containering. It also uses medieval style rpg equip lingo, which helps you feel cool when writing basic code, if that's something you're into.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add bandoleer

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install bandoleer


## Usage

### Expectations

Bandoleer has two expectations for the structure of a ruby project:
* that ruby files will contain a constant with the same name as the file.
* that directories and files will be in snake_case, and constants will be in Camelcase.

For example, a file named `basic_one` will define a constant named `BasicOne`.

Bandoleer files reference a directory; a file named `basic_bandoleer.rb` looks for files in `basic_bandoleer/`.

### Equipping

You can equip files to a bandoleer using `equip`. This will register the ruby constants directly.
Given the following structure:

    $ ls basic_bandoleer
    . .. basic_one.rb
    $ cat basic_bandoleer/basic_one.rb
    module BasicOne
    end

You can define a bandoleer file `basic_bandoleer.rb` like this:

```ruby
require 'bandoleer'

module BasicBandoleer
  extend Bandoleer

  vials = %i[
    basic_one
  ]

  equip vials
end
```

This file can be generated using the included command line interface:

    $ bandoleer craft basic_bandoleer
          create  basic_bandoleer.rb

If you want to add namespaces, use `/` as a delimiter. Running `bandoleer craft namespace/basic_bandoleer` will create a file that looks like this:

```ruby
require 'bandoleer'

module Namespace
  module BasicBandoleer
    # ...
  end
end
```

### Resolving

You can resolve equipped vials using the slice method:

```ruby
BasicBandoleer[:basic_one]
=> BasicOne
```

Or with named methods:

```ruby
BasicBandoleer.basic_one
=> BasicOne
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JC-Morph/bandoleer.
