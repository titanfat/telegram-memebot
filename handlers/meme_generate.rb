module Lita
  module Handlers
    class MemeGenerate < Handler
	    class ImgflipApiError < StandardError; end
	    class ConnectionError < StandardError; end

        config :api_user, default: ENV['USERNAME']
        config :api_password, default: ENV['PASSWORD']
			  API_URL = 'https://api.imgflip.com/caption_image'

			@@_templates = []

			def pull_img(template_id, line1, line2)
			  username = config.api_user
	      password = config.api_password
	  begin
	      result = http.post API_URL, {
		      template_id: template_id,
		      username: username,
		      password: password,
		      text0: line1,
		      text1: line2  }
	  rescue Faraday::Error => err
		  raise ConnectionError, err.message
	  end

	  parsed = JSON.parse(result.body)

	  if parsed.keys.include?('error_message')
		  raise(ImgflipApiError, parsed['error_message'])
	  end
	  parsed.fetch('data', {}).fetch('url')
			end

      def make_meme(message)
	      line1, line2 = extract_meme_text(message.match_data)
	     template = find_template(message.pattern)
	     begin
	     image = pull_img(template.fetch(:template_id), line1, line2)
	     rescue ConnectionError, ImgflipApiError => err
		     Lita.logger.error(err.message)
		     return message.reply 'Oops error'
	     end
	     message.reply image
      end

      def extract_meme_text(match_data)
	      _, line1, line2 = match_data.to_a
	      return line1, line2
      end

      def find_template(pattern)
	      templates = reg_templates.select do |t|
		      t.fetch(:pattern) == pattern
	      end
	      template = templates.first

	      template = reg_templates.select { |t| t.fetch(:pattern) == pattern }.first
	      raise ArgumentError if template.nil?
	      return template
      end

      def self.add_meme(template_id:, pattern:, help:)
        @@_templates << { template_id: template_id, pattern: pattern,
			  help: help }
		raise(ImgflipApiError, parsed['error_message']) if parsed.keys.include?('error_message')
	   image = parsed.fetch('data', {}).fetch('url')
      end

      def self.add_meme(template_id:, pattern:, help:)
	      @@_templates << { template_id: template_id, pattern: pattern,
			 help: help }
	      route pattern, :make_meme, help: help
      end

      def reg_templates
	      self.class.reg_templates
      end

      def self.reg_templates
	      @@_templates
      end

       add_meme( template_id: 101470, pattern: /^alien()\s+(.+)/i,
								 help: {'alien guy' => 'Ancient aliens guy'})
		   add_meme( template_id: 61579, pattern: /(нельзя просто) (.+)/i,
                 help: {'boromir mem' => 'one does not simply walk into mordor'})

   Lita.register_handler(self)  
    
    end
  end
end
