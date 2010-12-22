class ApplicationController < ActionController::Base
  protect_from_forgery
  load_and_authorize_resource
  
end
