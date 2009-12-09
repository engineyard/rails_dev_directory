class My::CodeSamplesController < ApplicationController
  before_filter :require_user
  before_filter :get_code_sample, :only => [:show, :review, :analyze]

  
  def index
    @code_samples = current_user.code_samples
  end
  
  def show
    if @code_sample.aasm_state.to_sym != :show
      redirect_to([@code_sample.aasm_state, :my, @code_sample])
    end
  end
  
  def analyze
    @code_sample.analyze!
    redirect_to [:my, @code_sample]
  end
  
  def new
    @code_sample = CodeSample.new
  end
  
  def create
    @code_sample = CodeSample.new(params[:code_sample])
    @code_sample.provider = current_user.provider
    if @code_sample.save
      redirect_to [:my, @code_sample]
    else
      render :new
    end
  end
  
  def edit
    @code_sample = CodeSample.find(params[:id])
  end
  
  def update
    @code_sample = CodeSample.find(params[:id])
    if @code_sample.update_attributes(params[:code_sample])
      redirect_to [:my, @code_sample]
    else
      render :edit
    end
  end
  
  def destroy
    @code_sample = CodeSample.find(params[:id])
    @code_sample.destroy
    redirect_to my_code_samples_path
  end

protected
  def get_code_sample
    @code_sample = current_user.code_samples.find(params[:id])
  end
  
end
