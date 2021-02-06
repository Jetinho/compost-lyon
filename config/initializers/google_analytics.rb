# frozen_string_literal: true
module GoogleAnalytics
  TRACKING_ID = Rails.application.credentials.dig :google_analytics, Rails.env.to_sym, :tracking_id
  GA4_TRACKING_ID = Rails.application.credentials.dig :ga4_google_analytics, Rails.env.to_sym, :tracking_id
  JS_URL = "https://www.googletagmanager.com/gtag/js?id=#{GoogleAnalytics::TRACKING_ID}"
  GA4_JS_URL = "https://www.googletagmanager.com/gtag/js?id=#{GoogleAnalytics::GA4_TRACKING_ID}"
end
