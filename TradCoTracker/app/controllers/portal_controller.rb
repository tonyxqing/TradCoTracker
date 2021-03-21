# frozen_string_literal: true

class PortalController < ApplicationController
  #skip_before_action :authorized
  def index
    redirect_to(controller: 'points')
  end

  def view_members
    @users = User.order('id ASC')
    @current_user = User.find_by(id: session[:user_id])
  end

  def new; end

  # creates a new session when the username is in the database and has the same password
  def create
    @user = User.find_by(username: params[:username])
      # Sudo global variables
      session[:user_id] = @user.id
      session[:user_isOfficer] = @user.isOfficer
      redirect_to point_path(session[:user_id])

  end

  # destroys the session
  def destroy
    @_current_user = session[:user_id] = nil
    redirect_to root_path
  end
end
