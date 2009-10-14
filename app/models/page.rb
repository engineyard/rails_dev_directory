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
  
  def to_param
    url
  end
end
