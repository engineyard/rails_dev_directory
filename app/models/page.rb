require 'open-uri'
require 'nokogiri'
class Page < ActiveRecord::Base
  
  validates_presence_of :title, :url
  
  acts_as_textiled :content
  xss_terminate :except => [:title, :content, :url]
  
  def self.find(*args)
    if args.not.many? and args.first.kind_of?(String) and args.first.not.match(/\d+/)
      find_by_url(args) || (raise ActiveRecord::RecordNotFound)
    else
      super(*args)
    end
  end
  
  def self.open_url(value)
    open(value)
  end
  
  def url=(value)
    if value[0,4] == 'http'
      doc = Nokogiri::HTML(Page.open_url(value))
      inline_url = doc.css("meta[name='page']").first['content']
      super(inline_url)
    else
      super
    end
  end
  
  def robots
    out = []
    out << 'noindex' if noindex?
    out << 'nofollow' if nofollow?
    out.join(', ')
  end
  
  def to_param
    url
  end
end
