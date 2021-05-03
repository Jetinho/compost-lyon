# spec/features/visitor_signs_up_spec.rb
require 'rails_helper'

feature 'User signs in' do
  scenario 'successfuly with correct password' do
    sign_in_existing_user_with_correct_password
    expect(page).to have_content('Deconnexion')
  end
  scenario 'with wrong password gets error message' do
    sign_in_existing_user_with_wrong_password
    expect(page).to have_content('Courriel ou mot de passe incorrect')
  end
  scenario 'with wrong email gets error message' do
    sign_in_existing_user_with_wrong_email
    expect(page).to have_content('Courriel ou mot de passe incorrect')
  end
end
