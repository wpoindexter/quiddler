require 'database_cleaner'
require 'simplecov'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  if ENV['COVERAGE']
    SimpleCov.start 'rails' do
      add_group 'Serializers', 'app/serializers'
    end
    all_files = Dir['**/*.rb']
    base_result = {}
    all_files.each do |file|
      absolute = File.expand_path(file)
      lines = File.readlines(absolute, encoding: 'UTF-8')
      base_result[absolute] = lines.map do |l|
        l.strip!
        l.empty? || l =~ /^else$/ || l =~ /^end$/ || l[0] == '#' ? nil : 0
      end
    end
    
    SimpleCov.at_exit do
      merged = SimpleCov::Result.new(Coverage.result).original_result.merge_resultset(base_result)
      result = SimpleCov::Result.new(merged)
      result.format!
    end
  end
end
