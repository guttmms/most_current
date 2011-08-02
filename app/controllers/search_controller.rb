class SearchController < ApplicationController
  def index
    user = current_user
    user.start
  end
end
