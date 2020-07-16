require "test_helper"



describe "Mindmap Basic Attrs Test" do
	it "test that it has a version number" do 
		refute_nil ::MiniMindmap::VERSION
	end
end


describe "Mindmap Attrs Test" do
	before do
    # const
    @basic_syntax_id = MiniMindmap::Mindmap.compiles_meta[:basic][:id]
    @code_compiled = [@basic_syntax_id, 2,"test long expression"]
	 	@demo_dsl = %Q{
	 	* A
	 	** B
	 	}

	 	@name = "demo"
    @mindmap = MiniMindmap::Mindmap.new(@name, @demo_dsl)
  end

  it "test name write and read" do
     assert_equal   @mindmap.name, @name
  end

  it "test dsl write and read" do
  	assert_equal @mindmap.dsl, @demo_dsl
  end

  it "test nodes write and read" do
  	mock_nodes = @code_compiled
  	@mindmap.nodes = mock_nodes
    assert_equal   @mindmap.nodes, mock_nodes
  end
end

describe "Mindmap Compile Test" do
	before do
    # const
    @basic_syntax_id = MiniMindmap::Mindmap.compiles_meta[:basic][:id]
    @code_compiled = [@basic_syntax_id, 2,"test long expression"]
	 	@demo_dsl = %Q{
	 	* A
	 	** B
	 	}

	 	@name = "demo"
    @mindmap = MiniMindmap::Mindmap.new(@name, @demo_dsl)
  end

  it "test compile: normal code" do
		assert_equal @mindmap.compile("** test"), [@basic_syntax_id, 2,"test"]
  end

  it "test compile: long code" do
		assert_equal @mindmap.compile("** test long expression"), @code_compiled
  end

  it "test compile: code with white space1" do
		assert_equal @mindmap.compile("** test long expression   "), @code_compiled
  end

  it "test compile: code with more white space" do
		assert_equal @mindmap.compile("   ** test long expression   "), @code_compiled
  end
end


describe "Mindmap Processtor Test" do
	before do
    # const
    @basic_syntax_id = MiniMindmap::Mindmap.compiles_meta[:basic][:id]
    @code_compiled = [@basic_syntax_id, 2,"test long expression"]
	 	@demo_dsl = %Q{
	 	* A
	 	** B
	 	}

	 	@name = "demo"
    @mindmap = MiniMindmap::Mindmap.new(@name, @demo_dsl)
  end

  it "test basic processor" do
  	nodes = @mindmap.basic_processor
    assert_equal   @mindmap.nodes, ["node1 -> node2"]
  end

  it "test basic processor" do
  	m = @mindmap
  	m.dsl = %Q{
		 	* A
		 	** B
		 	*** C
		 	**** D
	 	}
	 	m.basic_processor
    assert_equal   m.nodes, ["node1 -> node2", "node2 -> node3", "node3 -> node4"]
  end

  it "test basic processor" do
  	m = @mindmap
  	m.dsl = %Q{
		 	* A
		 	** B
		 	*** C
		 	* D
		 	** E
		 	*** F
	 	}
	 	m.basic_processor
    assert_equal   m.nodes, ["node1 -> node2", "node2 -> node3", "node4 -> node5", "node5 -> node6"]

  end

  it "test basic processor" do
    m = @mindmap
    m.dsl = %Q{
      * MiniMindmap
      ** name
      ** DSL
      ** output
      *** dir
      *** format
    }
    m.basic_processor
    assert_equal   m.nodes, ["node1 -> node2", "node1 -> node3", "node1 -> node4", "node4 -> node5", "node4 -> node6"]
  end

end


describe "Mindmap Package Nodes Test" do
	before do
    # const
    @basic_syntax_id = MiniMindmap::Mindmap.compiles_meta[:basic][:id]
    @code_compiled = [@basic_syntax_id, 2,"test long expression"]
	 	@demo_dsl = %Q{
	 	* A
	 	** B
	 	}

	 	@name = "demo"
    @mindmap = MiniMindmap::Mindmap.new(@name, @demo_dsl)
  end

  it "test pkg nodes" do
  	@mindmap.processor
  	pkg_nodes = @mindmap.package_nodes
    assert_equal   pkg_nodes, "digraph demo {\nnode1[label=\"A\"]\nnode2[label=\"B\"]\nnode1 -> node2\n}"
  end

end


describe "Mindmap Export Command Test" do
	before do
    # const
	 	@demo_dsl = %Q{
	 	* A
	 	** B
	 	}

	 	@name = "demo"
    @mindmap = MiniMindmap::Mindmap.new(@name, @demo_dsl)
  end

  it "test export cmd" do
    output_dir = File.expand_path(@mindmap.output[:dir], 'lib')
    output_file = File.join(output_dir, "#{@name}.#{@mindmap.output[:format]}")

    output_dotfile = File.join(output_dir, "#{@name}.dot")

    assert_equal   @mindmap.export_cmd, "dot #{output_dotfile} -T #{@mindmap.output[:format]} -o #{output_file}"
  end

end