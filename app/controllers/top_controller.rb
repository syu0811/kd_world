class TopController < ApplicationController
  before_action :sign_in_required, only: [:index]
end
