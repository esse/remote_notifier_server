class UserClientAccessesController < ApplicationController
  def create
    z = User.find_by_email(params[:email])
    client = current_user.clients.find(params[:client_id])
    (flash[:error] = "Can't find user with provided email." and redirect_to :back and return) unless z
    (flash[:error] = 'User already have access to that client.' and redirect_to :back and return) if z.all_clients.include? client
    z.accessing_clients << client
    flash[:notice] = "Access added."
    redirect_to :back
  end
  
  def destroy
    client = current_user.clients.find(params[:client_id])
    client.user_client_accesses.find(params[:id]).destroy
    flash[:notice] = 'Access revoked.'
    redirect_to :back
  end
end