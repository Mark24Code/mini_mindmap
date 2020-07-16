react_mind = RubyMindmap::Mindmap.new do |m|
  m.name = 'React'
  m.output = {
    format: 'png',
    dir: './out'
  }


  m.dsl = <<-Mindmap
    * React
    ** 生命周期
    *** ComponentDidMount
    **** ComponentWillMount
    ***** AAAComponentWillMount
    ** BBBB
    *** CCCCC
    **** DDDD
    ***** FFFF
    ******* KK
    ** OPLL
    * GO
    ** Woker
    *** KKKKKLLL
    * CASIO
    * KO
  Mindmap
end

react_mind.export