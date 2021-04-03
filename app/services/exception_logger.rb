class ExceptionLogger

  def self.send(exception, options = {})
    if Rails.env.production?
      Sentry.capture_exception(exception, extra: options)
    else
      msg = exception.try(:message) || exception.to_s
      Rails.logger.info "Sending exception to Sentry : #{msg} ;"
      Rails.logger.info options.to_yaml if options
    end
  end
end
