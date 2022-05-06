class ApplicationController < ActionController::Base
  
  private
  
    def user_params
      params.require(:user).permit(:name, :introduction, :is_deleted)
    end
  
    def post_params
      params.require(:post).permit(:body, :trail_place)
    end
    
end
