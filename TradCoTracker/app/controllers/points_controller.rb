class PointsController < ApplicationController
  def index
    #retrieves the current user from the session
    @user = User.find(session[:user_id])
    if !@user.isOfficer 
      redirect_to(point_path(session[:user_id]))
    end
    @points = Point.order('id ASC')
  end
  
  def show
    @id = session[:user_id]
    @points = Point.order('id ASC').where(userID: session[:user_id])
    @business_sum = Point.where(eventType: 'Business', userID: session[:user_id]).sum(:points)
    @speaking_sum = Point.where(eventType: 'Speaking', userID: session[:user_id]).sum(:points)
  end
  
  def new
    @id = session[:user_id]
    @point = Point.new
    @business = Business.new
    @speaking = Speaking.new
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
  
  def edit
    @point = Point.find(params[:id])
  end
  
  def update
    @point = Point.find(params[:id])
    if @point.update(point_params)
      redirect_to(point_path(@point))
    else
      render('edit')
    end
  end
  
  def delete
    @point = Point.find(params[:id])
  end
  
  def destroy
    @point = Point.find(params[:id])
    @point.destroy
    redirect_to(points_path)
  end
  
  private
    def point_params
      params.require(:point).permit(:events, :eventType, :points)
    end
end
