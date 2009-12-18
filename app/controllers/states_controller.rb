class StatesController < ApplicationController
  def show
    @providers = Provider.active.from_state(State.from_slug(params[:state]).code)
  end
end
