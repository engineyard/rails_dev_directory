class ProvidedService < ActiveRecord::Base
  belongs_to :provider
  belongs_to :technology_type
end
