# lita-meme_generate

[![Build Status](https://travis-ci.org/titanfat/lita-meme_generate.png?branch=master)](https://andrewdev.tk)
[![Coverage Status](https://coveralls.io/repos/titanfat/lita-meme_generate/badge.png)](https://t.me/make_memebot)



## Installation

Add lita-meme_generate to your Lita instance's Gemfile:

``` ruby
gem "lita-meme_generate"
```

## Configuration

``` ruby
# setup telegram adapter, gem 'lita-telegram-plus', add telegram token environments
  config.robot.adapter = :telegram_plus
  config.adapters.telegram_plus.token = ENV['TELEGRAM_TOKEN']
  # Register Imgflip to indicate the specify your login details to the API, and add to the surroundings
  config.handlers.meme_generate.api_user = ENV['IMGFLIP_USERNAME']
  config.handlers.meme_generate.api_password = ENV['IMGFLIP_PASSWORD']
```

## Usage

Adding meme templates

``` ruby
add_meme( template_id: template id add, pattern:  regular expression for route add,
								 help: {'help command text' => 'description'})
```
