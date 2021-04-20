# spec/features/visitor_signs_up_spec.rb
require 'rails_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'valid@example.com', 'password'

    expect(page).to have_content('Deconnexion')
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid_email', 'password'

    expect(page).to have_content('Me connecter')
  end

  scenario 'with blank password' do
    sign_up_with 'valid@example.com', ''

    expect(page).to have_content('Me connecter')
  end

  def sign_up_with(email, password)
    visit new_user_registration_path
    fill_in 'Courriel', with: email
    fill_in 'Mot de passe', with: password
    fill_in 'Confirmer le mot de passe', with: password
    click_button 'Inscription'
  end
end
