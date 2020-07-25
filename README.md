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

## Syntax

PlantUML Mindmap Syntax

```

* Subject
** Foo
** Bar

```

Suppo Annotation with //

```

// one line annotation

** Foo // you can add annotation here too

```

## Usage

DSL Example

```ruby
require "mini_mindmap"

name = 'mindmap' # filename

# support add attrs http://www.graphviz.org/doc/info/attrs.html
config = {
  rankdir: "LR",# "TB", "LR", "BT", "RL", 分别对应于从上到下，从左到右，从下到上和从右到左绘制的有向图
  node: {
    fontname: "wqy-microhei",
    fontcolor: "black"
  },
  edge: {
    fontname: "wqy-microhei"
  }
}
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
  ** 汉字测试
}

demo = MiniMindmap::Mindmap.new(name,dsl,output=output,config=config)

demo.export # export files to dir

```
output img

![demo.png](https://wx2.sbimg.cn/2020/07/16/CiWr6.png)

## Q&A

### Chinese charset code problem

1. To check fonts. Run `fc-list` or go to `/etc/fonts` to check if you have correct fonts.

2. You may need to install fonts, for example : Chinese font —— 文泉驿。 Run `sudo apt list fonts-wqy-zenhei`
3. Make config with correct font name

> 
```ruby
config = {
  rankdir: "LR",# "TB", "LR", "BT", "RL" direction
  node: {
    fontname: "wqy-microhei"
  },
  edge: {
    fontname: "wqy-microhei"
  }
}

demo = MiniMindmap::Mindmap.new(name,dsl,output=output,config=config)

```
## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
