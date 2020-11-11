class ApplicationDecorator < Draper::Decorator
   include ActionView::Helpers
   include Rails.application.routes.url_helpers
   
  # Define methods for all decorated objects.
  # Helpers are accessed through `helpers` (aka `h`). For example:
  #
  #   def percent_amount
  #     h.number_to_percentage object.amount, precision: 2
  #   end
end
