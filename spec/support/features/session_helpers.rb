# spec/support/features/session_helpers.rb
module Features
  module SessionHelpers
    def sign_up_with(email, password)
      visit new_user_registration_path
      fill_in 'Courriel', with: email
      fill_in 'Mot de passe', with: password
      fill_in 'Confirmer le mot de passe', with: password
      click_button 'Inscription'
    end

    def sign_in_existing_user_with_correct_password
      user = create(:user, email: 'testing@gmail.com', password: 'password')
      sign_in_with(email: user.email, password: user.password)
    end

    def sign_in_existing_user_with_wrong_password
      user = create(:user, email: 'testing@gmail.com', password: 'password')
      sign_in_with(email: user.email, password: 'wrong password')
    end

    def sign_in_existing_user_with_wrong_email
      user = create(:user, email: 'testing@gmail.com', password: 'password')
      sign_in_with(email: 'wrong_email@gmail.com', password: user.password)
    end

    def sign_in_with(email:, password:)
      visit new_user_session_path
      fill_in 'Courriel', with: email
      fill_in 'Mot de passe', with: password
      click_button 'Connexion'
    end

  end
end
