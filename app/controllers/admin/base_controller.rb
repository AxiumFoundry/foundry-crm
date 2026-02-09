class Admin::BaseController < ApplicationController
  include Pagy::Method

  before_action :require_authentication
  layout "admin"
end
