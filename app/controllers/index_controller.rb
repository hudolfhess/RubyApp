class IndexController < ApplicationController
  def index
    redirect_to contacts_path
  end
end
