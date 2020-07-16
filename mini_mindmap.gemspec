require_relative 'lib/mini_mindmap/version'

Gem::Specification.new do |spec|
  spec.name          = "mini_mindmap"
  spec.version       = MiniMindmap::VERSION
  spec.authors       = ["Mark24"]
  spec.email         = ["mark.zhangyoung@gmail.com"]

  spec.summary       = %q{A kind of DSL to generate mindmap.}
  spec.description   = %q{[Experimenting!] A kind of DSL to generate mindmap. Depend on Graphviz.}
  spec.homepage      = "https://github.com/Mark24Code/mini_mindmap"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Mark24Code/mini_mindmap"
  spec.metadata["changelog_uri"] = "https://github.com/Mark24Code/mini_mindmap/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
