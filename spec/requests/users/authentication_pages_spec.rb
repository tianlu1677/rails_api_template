# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User authentication pages' do
  it 'renders the Turbo-enabled sign-in page' do
    get new_user_session_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('turbo-frame id="user_authentication"')
    expect(response.body).to include('data-controller="form"')
  end

  it 'renders the Turbo-enabled registration page' do
    get new_user_registration_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('turbo-frame id="user_authentication"')
    expect(response.body).to include('data-controller="password"')
  end

  it 'protects the account page' do
    get account_path

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'signs in and redirects to the account page' do
    user = create(:user, password: 'Password123!')

    post user_session_path, params: { user: { email: user.email, password: 'Password123!' } }

    expect(response).to redirect_to(account_path)
  end

  it 'registers and redirects to the account page' do
    post user_registration_path,
         params: { user: { email: 'new-user@example.com', password: 'Password123!',
                           password_confirmation: 'Password123!' } }

    expect(response).to redirect_to(account_path)
  end
end
