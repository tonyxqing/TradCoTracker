# frozen_string_literal: true

class PointsController < ApplicationController
  def index
    # retrieves the current user from the session
    @user = User.find(session[:user_id])
    redirect_to(point_path(session[:user_id])) unless @user.isOfficer
    @points = Point.order('id ASC')
    @current_user = User.find_by(id: session[:user_id])
  end

  def show
    @current_user = User.find_by(id: session[:user_id])
    @id = session[:user_id]
    @points = Point.order('id ASC').where(userID: session[:user_id])
    @business_sum = Point.where(eventType: 'Business', userID: session[:user_id]).sum(:pointAmount)
    @speaking_sum = Point.where(eventType: 'Speaking', userID: session[:user_id]).sum(:pointAmount)
  end

  def new
    @current_user = User.find_by(id: session[:user_id])
    @id = session[:user_id]
    @point = Point.new
  end

  def create
    # Instantiate a new object using form parameters
    @id = session[:user_id]
    @user = User.find(@id)
    @point = Point.new(point_params)
    @point.userID = @user.id
    # Save the object
    if @point.save
      # If save succeeds, redirect to the index action
      redirect_to(point_path(session[:user_id]))
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def editSHOW
    @current_user = User.find_by(id: session[:user_id])
    @point = Point.find(params[:id])
  end

  def editINDEX
    @current_user = User.find_by(id: session[:user_id])
    @point = Point.find(params[:id])
  end

  def updateINDEX
    @point = Point.find(params[:id])
    if @point.update(point_params)
      redirect_to(points_path)
    else
      render('edit')
    end
  end

  def update
    @point = Point.find(params[:id])
    if @point.update(point_params)
      redirect_to()
    else
      render('edit')
    end
  end

  def deleteSHOW
    @point = Point.find(params[:id])
    @point.destroy
    redirect_to(point_path(session[:user_id]))
  end

  def deleteINDEX
    @point = Point.find(params[:id])
    @point.destroy
    redirect_to(points_path)
  end

  def destroyUSER
    Point.where(:userID => params[:id]).destroy_all
    redirect_to(portal_view_members_path)
  end

  private

  def point_params
    params.require(:point).permit(:eventName, :eventType, :pointAmount, :submissionDate)
  end
end
