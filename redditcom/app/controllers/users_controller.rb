class UsersController < ApplicationController
    before_action :require_logged_in, only: [:index, :show, :edit, :update, :destroy]
    before_action :require_logged_out, only: [:new, :create]

    def index
        @users = User.all
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login(user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
        render :edit
    end

    def update
        @user = User.find(id: params[:id])
        if @user && @user.update(user_params)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ['U messed up']
    end

    def destroy
        @user = User.find(id: params[:id])
        if @user && @user.delete
            redirect_to new_session_url
        else
            flash.now[:errors] = ['U messed up']
        end
    end

    private
    def user_params
        params.require[:user].permit(:username, :password)
    end

end
