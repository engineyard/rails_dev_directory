class ProviderDirectoryController < ApplicationController
  def show
    @services = Service.ordered
  end
end
