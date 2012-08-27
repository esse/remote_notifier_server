class HomeController < ApplicationController
  
  def unlogged
    render layout: 'unlogged'
  end
  
  def logged
  end
  
end