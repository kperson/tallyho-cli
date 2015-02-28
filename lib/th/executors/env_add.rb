require_relative '../util/rest'
require_relative '../util/user_context'

require 'json'

module TH

  class EnvAdd

    def initialize(branch, options)
      @branch = branch
      @options = options
    end

    def run
      if @options.keys.length != @options.values.length
        raise 'keys and values must be the same length'
      else
        kv_array = @options.keys.zip(@options.values)

        url = File.join(user_host, 'env')
        send_headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'X-TOKEN' => user_token }
        kv_array.each { |x|
          body = JSON.generate({ :projectName => project_name, :branch => @branch, :env => { :key => x[0], :value => x[1] } })
          req = JSON.load(http_request(url, 'POST', { }, send_headers, body))

          if !req['error'].nil?
            raise req['error']
          end
        }
      end
    end

  end

end
