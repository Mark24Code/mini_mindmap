require "mini_mindmap/version"

module MiniMindmap
  class Error < StandardError; end

  class Mindmap
    def initialize(name, dsl)
      @name = name
      @dsl = dsl

      yield(self) if block_given?

      # self.compile
    end

    attr_accessor(:name, :dsl, :output, :nodes)

    def node(code)
    	# TODO  增加拓展语法支持 label等自定义
    	# 同步Test也要更新
      node_express = /^(\*+)\s+([^\s]+.*)$/
      node_express =~ code.strip

      level_prefix = $1
      content = $2
      level = level_prefix.length
      node = [level, content]
    end

    def dsl_to_nodes
      nodes = []
      stack = []
      dsl = @dsl.split("\n")
      dsl.each_with_index do |code, current_index|
        current = self.node(code)
        unless stack.empty?
          top = stack.pop
          if (current[0] > top[0])
            (nodes << "#{top[1]} -> #{current[1]}")
            stack.push(top)
          else
            while (current[0] <= top[0]) and (not stack.empty?)
              top = stack.pop
            end
            (nodes << "#{top[1]} -> #{current[1]}") if (current[0] > top[0])
          end
        end
        stack.push(current)
      end
      @nodes = nodes
    end

    def package_nodes
      "digraph #{@name} {\n#{@nodes.join("\n")}\n}"
    end

    def nodes_to_doc
      File.open("#{@name}.dot", "w") { |f| f.write(package_nodes) }
    end

    def compile
      self.dsl_to_nodes
      self.package_nodes
      self.nodes_to_doc
    end

    def export_cmd
      "dot #{@name}.dot -T #{@output[:format]} -o #{@name}.#{@output[:format]}"
    end

    def export
      export = self.export_cmd
      puts("[command]: #{export}")
      `#{export}`
    end
  end
end
