class ShopsController < ApplicationController
  before_action :authenticate_user!

  layout "shops"
end
