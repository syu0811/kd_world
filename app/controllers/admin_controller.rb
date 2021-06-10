class AdminController < ApplicationCntroller
  before_action :authenticate_admin!, only: [:index]
end
