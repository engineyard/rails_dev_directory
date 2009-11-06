class ProviderDirectoryController < ApplicationController
  def show
    @services = Service.all
  end
end
