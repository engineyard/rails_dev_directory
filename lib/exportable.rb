require "fastercsv"

class ActiveRecord::Base
  def self.to_csv(*args)
    find(:all).to_csv(*args)
  end
  
  def export_columns(format = nil, methods = nil)
    methods.to_a + self.class.content_columns.map(&:name) - ['created_at', 'updated_at', 'avatar']
  end
  
  def to_row(format = nil, methods = nil)
    export_columns(format, methods).map { |c| self.send(c) }
  end
end

class Array
  def to_csv(options = {})
    if all? { |e| e.respond_to?(:to_row) }
      header_row = first.export_columns(options[:format], options[:methods]).to_csv
      content_rows = map { |e| e.to_row(options[:format], options[:methods]) }.map(&:to_csv)
      ([header_row] + content_rows).join
    else
      FasterCSV.generate_line(self, options)
    end
  end
end