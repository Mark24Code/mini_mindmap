require "test_helper"



describe "Mindmap Basic Attrs Test" do
	it "test that it has a version number" do 
		refute_nil ::MiniMindmap::VERSION
	end
end


describe "Mindmap Methods Test" do
	before do
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

  it "test node method normal code" do
		assert_equal @mindmap.node("** test"), [2,"test"]
  end

  it "test node method long code" do
		assert_equal @mindmap.node("** test long expression"), [2,"test long expression"]
  end

  it "test node method code with white space1" do
		assert_equal @mindmap.node("** test long expression   "), [2,"test long expression"]
  end

  it "test node method code with white space2" do
		assert_equal @mindmap.node("   ** test long expression   "), [2,"test long expression"]
  end


  it "test nodes write and read" do
  	mock_nodes = [[1,"A"],[2,"B"]]
  	@mindmap.nodes = mock_nodes
    assert_equal   @mindmap.nodes, mock_nodes
  end

end