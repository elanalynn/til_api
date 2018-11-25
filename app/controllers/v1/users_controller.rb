module V1
  class UsersController < ApplicationController
    skip_before_action :authorize_request, only: :create
    before_action :set_user, only: :show

    def create
      user = User.create!(user_params)
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: Message.account_created, auth_token: auth_token, user: user }
      json_response(response, :created)
    end

    def show
      json_response(nil, :not_found) if @user.nil?
      json_response(@user)
    end

    private

    def user_params
      params.permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation
      )
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end
