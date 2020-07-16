require "test_helper"

class MiniMindmapTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MiniMindmap::VERSION
  end

  def test_it_has_a_author
  	assert_equal "Mark24",::MiniMindmap::AUTHOR
  end
end
