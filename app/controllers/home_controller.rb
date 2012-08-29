class HomeController < ApplicationController
  
  skip_before_filter :authenticate_user!
  
  
  def unlogged
    render layout: 'unlogged'
  end
  
  def logged
  end
  
end