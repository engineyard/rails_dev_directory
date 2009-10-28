class ProvidedService < ActiveRecord::Base
  belongs_to :provider
  belongs_to :service
end
