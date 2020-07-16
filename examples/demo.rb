require_relative "helper.rb"
require "mini_mindmap"

name = 'React'
output = {
  format: 'png',
  dir: "#{Dir.home}/mindmap_test/work"
}


dsl = %Q{
  * MiniMindmap
  ** name
  ** DSL
  ** output
  *** dir
  *** format
}

demo = MiniMindmap::Mindmap.new(name,dsl,output)

demo.export