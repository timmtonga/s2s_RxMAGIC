class UserController < ApplicationController
  def index
    @users = User.where("voided = ?", false)
  end

  def new
    @user = User.new
    @targeturl = "/users"
    render :layout => "touch"
  end

  def create

    @user = User.new({:username => params[:user][:username], :password => params[:user][:password],:role =>params[:user][:user_role],
                      :first_name => params[:user][:first_name], :middle_name => params[:user][:middle_name],
                      :fathers_name => params[:user][:fathers_name], :mothers_name => params[:user][:mothers_name]})

    if @user.save
      redirect_to "/user" and return
    else
      render 'new', :layout => "touch"
    end

  end

  def show
    @user = User.find(params[:id])
    @targeturl = "/users"
    render :layout => "menu"
  end

  def edit

    if request.post?
      user = User.find(params[:user_id])
      case params[:section]
        when "language_preference"
          user.update_attributes(:language => params[:language_preference])
          if user.save
            flash[:message] = "User language preference successfully updated"
          else
            flash[:message] = t("messages.invalid_credentials")
          end
        when "password"
          user.update_attributes(:password => params[:user][:plain_password], :salt => nil)

          if user.save
            flash[:message] = "User password successfully updated"
          else
            flash[:message] = t("messages.invalid_credentials")
          end
        when "role"
          user.update_attributes(:role => params[:role])
          if user.save
            flash[:message] = "User role preference successfully updated"
          else
            flash[:message] = t("messages.invalid_credentials")
          end
      end
      redirect_to "/main/settings" and return
    else
      @user = User.find(params[:id])
      @edit_section = params[:section]
      render :layout =>  "touch"
    end

  end

  def destroy
    user = User.find(params[:id])
    user.update_attributes(voided: true)
    redirect_to "/user" and return
  end

  def login
    if request.post?
      state = User.authenticate(params['login'],params['password'])

      if state
        user = User.find_by_username(params['login'])
        session[:user_id] = user.id
        User.current = user
        flash[:message] = nil
        redirect_to root_path and return
      else
        flash[:message] = t("messages.invalid_credentials")
      end

    else
      session[:user_id] = nil
      User.current = nil
    end
    render :layout => "touch"
  end

  def logout
    session[:user_id] = nil
    User.current = nil
    redirect_to "/login"
  end

  def username_availability
    user = User.find_by_username(params[:search_str])
    render :text => user.blank? ? '' : 'N/A' and return
  end

  def query
    results = []

    users = User.page((params[:page].to_i rescue 1)).per((params[:size].to_i rescue 20)).each

    users.each do |user|

      record = {
          "username" => "#{user.username}",
          "name" => "#{user.fullname}",
          "roles" => "#{user.role}",
          "active" => (user.active rescue false),
          "id" => user.id
      }

      results << record

    end

    render :text => results.to_json

  end

  private

  def user_params
    params.require(:user).permit(:username,:first_name, :middle_name, :role, :fathers_name, :mothers_name,:password)
  end
end
