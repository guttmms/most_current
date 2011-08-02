class ProfilesController < ApplicationController
    def edit
      @profile = Profile.find(params[:id])
    end

    def update
      @profile = Profile.find(params[:id])
      if @profile.update_attributes(params[:profile])
        redirect_to user_path, :notice => "Your profile has been updated"
      else
        render :action => 'edit'
      end
    end
  end

