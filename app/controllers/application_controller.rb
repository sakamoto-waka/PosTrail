class ApplicationController < ActionController::Base
  
  private
    
    add_flash_types :success, :info, :warning, :danger
  
    def user_params
      params.require(:user).permit(:name, :introduction, :is_deleted, :account_image)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:body, :trail_place, :trail_image, :prefecture_id)
    end
    
end
