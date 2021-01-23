require 'dotenv/load'
require './handlers/meme_generate.rb'

Lita.configure do |config|
  # The name your robot will use.
  config.robot.name = "Lita"

  # The locale code for the language to use.
  # config.robot.locale = :en

  # The severity of messages to log. Options are:
  # :debug, :info, :warn, :error, :fatal
  # Messages at the selected level and above will be logged.
  config.robot.log_level = :info

  config.robot.adapter = :telegram_plus
  config.adapters.telegram_plus.token = ENV['TELEGRAM_TOKEN']
  config.handlers.meme_generate.api_user = ENV
  config.handlers.meme_generate.api_password = ENV

  ## Example: Set configuration for any loaded handlers. See the handler's
  ## documentation for options.
  # config.handlers.some_handler.some_config_key = "value"
end
