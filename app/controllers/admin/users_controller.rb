class Admin::UsersController < Admin::AdminController
  load_and_authorize_resource through: :promotion, shallow: true

  def index
    if params.has_key? "promotion_id"
      @promotion = Promotion.find(params["promotion_id"]) || current_user.promotion
    else
      @promotion = current_user.promotion
    end

    @users = @promotion.try(:students) || User.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
    params[:user][:promotion] = Promotion.find(params[:user][:promotion])
    @user.update_attributes params[:user]
    respond_with :admin, @user
  end

  def create
    @user.save
    respond_with @user, location: new_admin_user_path
  end

  def destroy
    @user.destroy
    respond_with @user, location: admin_users_path
  end

  protected
end
