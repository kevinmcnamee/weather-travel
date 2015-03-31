ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  VCR.configure do |config|
    config.cassette_library_dir = "fixtures/cassettes"
    config.hook_into :typhoeus
    config.allow_http_connections_when_no_cassette = false
  end
end
