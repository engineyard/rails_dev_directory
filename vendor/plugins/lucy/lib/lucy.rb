module Lucy

  JAVASCRIPT_DIR = File.join(File.dirname(__FILE__), "..", "..", "..", "..", "public", "javascripts")
  DEFAULT_NAMESPACE = "Lucy"
  DEFAULT_GLOBAL = "window"


  def self.generate(key, content=nil, path=nil)
    File.open(path || File.join(JAVASCRIPT_DIR, "#{key}.js"), "w") do |f|
      g = JavascriptGenerator.new
      if block_given?
        yield g
      else
        g.write key, content
      end
      f.write g.to_js
    end
  end

  def self.file(src_path, dest_path=nil)
    File.cp(src_path, dest_path || JAVASCRIPT_DIR)
  end


  class JavascriptGenerator

    attr_writer :namespace, :global, :init_namespace

    def initialize
      @keyed = []
      @raw = []
      yield self if block_given?
    end

    def write(key, obj)
      @keyed << [key, ActiveSupport::JSON.encode(obj)]
    end
    alias []= write

    def write_raw(data)
      @raw << data
    end
    alias << write_raw

    def to_a
      (init_namespace? ? [init_namespace] : []) + @keyed.map do |key, value|
        "#{namespace}.#{[key].flatten.join('.')} = #{value};"
      end + @raw
    end

    def to_js
      to_a.join("\n\n")
    end

    def namespace
      @namespace || DEFAULT_NAMESPACE
    end

    def global
      @global || DEFAULT_GLOBAL
    end

    def init_namespace
      "if (!#{global}.#{namespace}) { #{namespace} = {}; }"
    end

    def init_namespace?
      @init_namespace.nil? ? true : @init_namespace
    end

  end


end
