require_relative "helper.rb"
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
  # MiniMindmap
  ## name [color=red]
  ** DSL // this is annotion
  ** output
  *** dir
  *** format
  ** 汉字测试
}

demo = MiniMindmap::Mindmap.new(name,dsl,output=output,config=config)

demo.export # export files to dir