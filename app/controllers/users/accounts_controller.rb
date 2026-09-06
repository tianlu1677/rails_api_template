# frozen_string_literal: true

module Users
  class AccountsController < ApplicationController
    before_action :authenticate_user!

    def show; end
  end
end
