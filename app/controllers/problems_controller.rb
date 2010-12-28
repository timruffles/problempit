class ProblemsController < ApplicationController
  
  def index
  end
  
  def new
    @problem = Problem.new
  end
  
  def create
    Problem.create(params[:problem])
  end
  
  def show
  end
  
end
