# config/initializer/active_storage.rb
Rails.configuration.to_prepare do
  ActiveStorage::Blob.class_eval do
    before_create :generate_key_with_prefix

    def generate_key_with_prefix
      self.key = if prefix
        File.join prefix, self.class.generate_unique_secure_token
      else
        self.class.generate_unique_secure_token
      end
    end

    def prefix
      if self.service_name = ENV["AMAZON_SERVICE_NAME"]
        ENV["PREFIX_FOR_S3_PHOTOS"]
      end
    end
  end
end