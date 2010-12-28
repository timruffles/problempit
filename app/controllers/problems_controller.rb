class ProblemsController < ApplicationController
  
  def index
  end
  
  def new
    @problem = Problem.new
  end
  
  def create
    unless Problem.create(params[:problem])
      render :new
    end
  end
  
  def show
  end
  
end
