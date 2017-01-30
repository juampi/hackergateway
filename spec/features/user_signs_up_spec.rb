require 'rails_helper'

RSpec.feature "User signs up", type: :feature do
  scenario "without entering username" do
    user = FactoryGirl.build(:user)
    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
    expect(page).to have_content("Username can't be blank")
  end

  scenario "without entering email" do
    user = FactoryGirl.build(:user)
    visit new_user_registration_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
    expect(page).to have_content("Email can't be blank")
  end

  scenario "without entering password" do
    user = FactoryGirl.build(:user)
    visit new_user_registration_path
    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    click_button 'Sign up'
    expect(page).to have_content("Password can't be blank")
  end

  scenario "with matching passwords" do
    user = FactoryGirl.build(:user)
    visit new_user_registration_path
    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
    expect(page).to have_current_path(root_path)
    expect(page).to have_content('activate your account')
  end

  scenario "with non-matching passwords" do
    user = FactoryGirl.build(:user)
    visit new_user_registration_path
    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password.concat('x')
    click_button 'Sign up'
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
