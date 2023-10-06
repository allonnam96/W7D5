class SessionsController < ActionController::Base
    before_action :require_logged_in, only: [:destroy]
    before_action :require_logged_out, only: [:new, :create]

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(
        params[:user][:username],
        params[:user][:password]
        )

        if @user
            login(@user)
            redirect_to users_url
        else
            @user = User.new(
                params[:user][:username]
            )
            flash.now[:errors] = ['Invalid Username or Password']
            render :new
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end