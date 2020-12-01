# frozen_string_literal: true
module Emailing
  EMAILING_PASSWORD = Rails.application.credentials.dig :emailing, Rails.env.to_sym, :julien, :password
end
