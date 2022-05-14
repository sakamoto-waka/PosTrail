# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController

  # before_action :customer_state, only:


  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path
    flash[:notice] = "ゲストユーザーでログインしました"
  end

  protected

    # def customer_state
    #   @customer = Customer.find_by(email: params[:customer][:email])
    #   return if !@customer
    #   if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted
    #     redirect_to new_customer_registration_path
    #   end
    # end
end
