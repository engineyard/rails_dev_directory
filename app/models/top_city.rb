class TopCity < ActiveRecord::Base
  def self.order(ids)
    update_all(
      ['position = FIND_IN_SET(id, ?)', ids.join(',')],
      { :id => ids }
    )
  end
end
