require 'rails_helper'

RSpec.describe 'Profile Creation and Login', type: :system do
  let!(:user) { create(:user, email: 'user@example.com', password: 'password123') }

  it 'allows user to create a profile and view it after re-login' do
    sign_in user

    visit new_user_profile_path(user)
    fill_in 'Username', with: 'JohnDoe'
    fill_in 'Birthday date', with: '01-01-1990'
    click_button 'Create Profile'

    expect(page).to have_content('JohnDoe')
    expect(page).to have_content('1990-01-01')

    click_button 'Выйти'
    sign_in user

    visit user_profile_path(user)
    expect(page).to have_content('JohnDoe')
    expect(page).to have_content('1990-01-01')
  end
end
