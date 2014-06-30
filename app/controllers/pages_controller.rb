class PagesController < ApplicationController
	before_action :signed_in_user, only: [:estadisticas, :servicio3E]

  def home
  	if signed_in?
  		redirect_to current_user
  	end
  end

  def help
  end

  def estadisticas
  end

  def servicio3E  	
    @user = User.find(params[:user_id])
  end

  private    

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to root_url, notice: "Please sign in."
      end
    end
end
