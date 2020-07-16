require_relative "helper.rb"
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
