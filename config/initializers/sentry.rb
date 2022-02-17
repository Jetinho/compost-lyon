Sentry.init do |config|
  config.dsn = 'https://45de8dea94ca4e539ab22526eb7f19c5@o564195.ingest.sentry.io/5704802'
  config.breadcrumbs_logger = [:active_support_logger]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  if Rails.env.production?
    config.traces_sample_rate = 0.2
  else
    config.traces_sample_rate = 0
  end
end
