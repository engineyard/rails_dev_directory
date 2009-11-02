class ProvidedService < ActiveRecord::Base
  belongs_to :provider
  belongs_to :service

  delegate :name, :name=, :category, :category=, :position, :to => :service
end
