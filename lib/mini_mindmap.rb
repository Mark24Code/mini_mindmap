require "mini_mindmap/version"
require "fileutils"

module MiniMindmap
  class Error < StandardError; end

  class Mindmap
    @@compiles_meta = {
      basic: {
        id: "basic",
        description: "basic expression",
        syntax: /^(\*+)\s+([^\s]+.*)$/,
        processor: "basic_processor",
      }
    }
    def self.compiles_meta
      @@compiles_meta
    end

    def initialize(name, dsl, output=nil)

      @name = name
      @dsl = dsl
      @output = output || {
        dir: Dir.home,
        format: "png"
      }

      yield(self) if block_given?
    end

    attr_accessor(:name, :dsl, :output, :nodes)

    def compile(code)
    	# TODO  增加拓展语法支持 label等自定义
      case code.strip
      when @@compiles_meta[:basic][:syntax]
        level_prefix = $1
        content = $2
        level = level_prefix.length
        node = [@@compiles_meta[:basic][:id],level, content]
      else
        # pass
      end
    end

    def basic_processor
      nodes = []
      stack = []
      dsl = @dsl.split("\n")
      dsl.each_with_index do |code, current_index|

        if not code.strip.empty?
          current = self.compile(code)

          unless stack.empty?
            top = stack.pop
            if current[1] > top[1]
              nodes << "#{top[2]} -> #{current[2]}"
              stack.push(top)
            else
              while (current[1] <= top[1]) and (not stack.empty?)
                top = stack.pop
              end
              if current[1] > top[1]
                nodes << "#{top[2]} -> #{current[2]}"
                stack.push top
              end
              
            end
          end
          stack.push(current)
        end
      end
      @nodes = nodes
    end

    def processor
      self.send @@compiles_meta[:basic][:processor]  
    end

    def package_nodes
      "digraph #{@name} {\n#{@nodes.join("\n")}\n}"
    end

    def nodes_to_doc
      output_dir = File.absolute_path(@output[:dir])
      FileUtils::mkdir_p output_dir
      output_file = File.join(output_dir, "#{@name}.dot")

      File.open("#{output_file}", "w") { |f| f.write(package_nodes) }
    end

    def run_tasks
      self.processor
      self.package_nodes
      self.nodes_to_doc
    end

    def export_cmd
      output_dir = @output[:dir]
      output_file = File.join(output_dir, "#{@name}.#{@output[:format]}")

      output_dotfile = File.join(output_dir, "#{@name}.dot")
      "dot #{output_dotfile} -T #{@output[:format]} -o #{output_file}"
    end

    def export
      self.run_tasks
      export = self.export_cmd

      puts("[command]: #{export}")
      `#{export}`
    end
  end
end
