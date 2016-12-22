require "./config/environment"

require './app/models/WebhookEvent'
require './app/models/Repository'
require './app/services/repository_service'
require './app/webhook_server'

RSpec.configure do |config|


  config.before(:each) do
    $db = []
  end

  config.before do
  end

  config.after do
    Mongoid.purge!
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed
end
