require 'etcd'
module Etcd

  class Operation
    attr_reader :name
    def initialize(name)
      @name = name
    end

    def directory_only?
      %w'mkdir rmdir ls setdir updatedir'.include? name
    end
  end

  class Completion
    attr_reader :client

    def initialize(opts={})
      @client = Etcd.client(opts)
    end

    def node_name(prefix)
      if (prefix == '/')
        '/' 
      else
        index = prefix.rindex('/')
        if index.nil?
          '/' 
        else
          prefix[0..index]
        end
      end
    end

    def filter(nodes, prefix) 
      nodes.select do |n|
        n.key.start_with?(prefix)
      end
    end

    def matches(prefix)
      node = client.get(node_name(prefix)).node
      if (node.directory?)
        nodes = [node] + node.children
      else
        nodes = [node] 
      end
      nodes = filter(nodes, prefix)

      if nodes.size == 1  
        if nodes[0].directory?
          nodes += client.get(nodes[0].key).node.children
        end
      end

      nodes
    end 
  end
end
