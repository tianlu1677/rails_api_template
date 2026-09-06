# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin dashboard', openapi: false do
  it 'renders the Tailwind-enhanced dashboard for an admin' do
    sign_in create(:admin_user)

    get admin_root_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('aa:bg-indigo-50')
    expect(response.body).to match(%r{/assets/tailwind-[a-f0-9]+\.css})
  end
end
