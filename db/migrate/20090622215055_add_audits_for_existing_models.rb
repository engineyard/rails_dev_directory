class AddAuditsForExistingModels < ActiveRecord::Migration
  
  class Recommendation < ActiveRecord::Base; end

  def self.up
    Provider.all.each do |p|
      Audit.create(:auditable => p, :action => 'create', :created_at => p.created_at, :updated_at => p.created_at)
    end
    Rfp.all.each do |p|
      Audit.create(:auditable => p, :action => 'create', :created_at => p.created_at, :updated_at => p.created_at)
    end
    Request.all.each do |p|
      Audit.create(:auditable => p, :action => 'create', :created_at => p.created_at, :updated_at => p.created_at)
    end
    Recommendation.all.each do |p|
      Audit.create(:auditable => p, :action => 'create', :created_at => p.created_at, :updated_at => p.created_at)
    end
  end

  def self.down
  end
end
