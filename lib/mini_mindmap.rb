require "mini_mindmap/version"
require "mini_mindmap/utils/deep_merge"
require "fileutils"

module MiniMindmap
  class Error < StandardError; end

  class Mindmap
    @@compiles_meta = {
      basic: {
        id: "basic",
        description: "basic expression",
        syntax: /^([\*|\#]+)\s+([^\s]*[^\[\]]*)\s*(\[.*\])*\s*(\/\/.*)*\s*$/,
        processor: "basic_processor",
      },
      annotation: {
        id: "annotation",
        description: "annotation expression",
        syntax: /^\s*\/\/.*\s*/,
        processor: "annotation_processor",
      }
    }
    def self.compiles_meta
      @@compiles_meta
    end

    def initialize(name, dsl,output={},config={})

      @name = name
      @dsl = dsl
      @config =  {
        rankdir: 'LR', # "TB", "LR", "BT", "RL", 分别对应于从上到下，从左到右，从下到上和从右到左绘制的有向图
        node: {},
        edge: {}
      }.deep_merge(config)
      @output = {
        dir: Dir.home,
        format: "png"
      }.deep_merge(output) 

      yield(self) if block_given?
    end

    attr_accessor(:name, :dsl, :config, :output, :nodes, :declares)

    def compile(code)
    	# TODO  增加拓展语法支持 label等自定义
      case code.strip
      when @@compiles_meta[:basic][:syntax]
        level_prefix = $1
        content = $2
        config = $3
        level = level_prefix.length
        node = [@@compiles_meta[:basic][:id],level, content]

        if config
          node.push(config)
        end
      
        return node
      when @@compiles_meta[:annotation][:syntax]
        # pass annotation  
      else
        # rest pass
      end
    end

    def basic_processor
      declares = [];
      nodes = []
      stack = []
      dsl = @dsl.split("\n")
      dsl.each_with_index do |code, current_index|

        if not code.strip.empty?
          current_id = current_index
          current = self.compile(code)
          if not current
            next
          end
          current.unshift(current_id)
          # [id, type_id, level, content, config]

    
          current_declare = "node#{current_id}[label=\"#{current[3]}\"]";
          declares.push(current_declare)

          unless stack.empty?
            top = stack.pop
            if current[2] > top[2]
              node_line = "node#{top[0]} -> node#{current[0]}"
              if current.length >=5
                node_line += " #{current[4]}"
              end
              nodes << node_line 
              stack.push(top)
            else
              while (current[2] <= top[2]) and (not stack.empty?)
                top = stack.pop
              end
              if current[2] > top[2]
                node_line = "node#{top[0]} -> node#{current[0]}"
                if current.length >=5
                  node_line += " #{current[4]}"
                end
                nodes << node_line 
                stack.push top
              end
              
            end
          end
          stack.push(current)
        end
      end
      @declares = declares
      @nodes = nodes
    end

    def processor
      self.send @@compiles_meta[:basic][:processor]  
    end

    def package_nodes
      node_config = @config[:node].map {|k,v| "#{k}=\"#{v}\""}.join(",")
      edge_config = @config[:edge].map {|k,v| "#{k}=\"#{v}\""}.join(",")
      "digraph \"#{@name}\" {\nrankdir = #{@config[:rankdir]};\nnode [#{node_config}];\nedge [#{edge_config}];\n#{@declares.join("\n")}\n#{@nodes.join("\n")}\n}"
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
