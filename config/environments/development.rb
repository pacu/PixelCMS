PixelCMS::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true


  CarrierWave.configure do |c|
    c.fog_credentials = {
        :provider => 'AWS', # required
        :aws_access_key_id => 'xxx', # required
        :aws_secret_access_key => 'yyy', # required
        :port => 10001,
        :host => 'http://fakes3.com', # optional, defaults to nil
        :scheme => 'http',
        :endpoint => 'http://fakes3.com:10001',
        :region => 'us-east-1'


    }

    c.fog_directory = 'pixelpublishers' # required
    c.fog_public = false # optional, defaults to true
                         #c.fog_attributes = {'Cache-Control' => 'max-age=315576000'} # optional, defaults to {}
  end

  require 'cancan'
  require 'fog/aws/models/storage/files'
  class Fog::Storage::AWS::Files
    def normalise_headers(headers)
      headers['Last-Modified'] = Time.parse(headers['Last-Modified']) if headers['Last-Modified']
      headers['ETag'].gsub!('"', '') if headers['ETag']
    end
  end

end
