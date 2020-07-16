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
output img

![demo.png](https://wx2.sbimg.cn/2020/07/16/CiWr6.png)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
