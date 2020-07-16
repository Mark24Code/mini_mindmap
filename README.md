# MiniMindmap

## Prepare

You need install graphviz first.

[graphviz download](http://www.graphviz.org/download/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mini_mindmap'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mini_mindmap

## Usage

DSL Example

```ruby
require "mini_mindmap"

name = 'mindmap' # filename

output = {
  format: 'png',
  dir: "#{Dir.home}/mindmap" # output dir
}

# online

dsl = %Q{
  * MiniMindmap
  ** name
  ** DSL
  ** output
  *** dir
  *** format
}

demo = MiniMindmap::Mindmap.new(name,dsl,output)

demo.export # export files to dir

```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mark24code/mini_mindmap. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/mark24code/mini_mindmap/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MiniMindmap project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mark24code/mini_mindmap/blob/master/CODE_OF_CONDUCT.md).
