class TopCity < ActiveRecord::Base
  
  validates_presence_of :city, :country, :slug
  
  before_validation :set_slug
  
  def self.order(ids)
    update_all(
      ['position = FIND_IN_SET(id, ?)', ids.join(',')],
      { :id => ids }
    )
  end
  
private
  def set_slug
    self.slug = city.downcase.gsub(/[^a-z]/, '-') if self.slug.blank?
  end
end