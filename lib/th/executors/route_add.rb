require 'json'

require_relative '../util/rest'
require_relative '../util/user_context'
require_relative '../util/file_io'

module TH

  include Rest
  include UserContext
  include FileIO

  class RouteAdd

    def initialize(branch, host, app, port, publickey, privatekey)
      @branch = branch
      @host = host
      @app = app
      @port = port
      @publickey = publickey
      @privatekey = privatekey
    end

    def run
      url = File.join(user_host, 'route')
      post_data = { :projectName => project_name, :branch => @branch, :host => @host, :app => @app, :containerPort => @port }

      if @publickey && @privatekey
        post_data[:ssl] = { :privateKey => file_at(@privatekey), :cert => file_at(@publickey) }
      end

      body = JSON.generate(post_data)
      send_headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'X-TOKEN' => user_token }
      data = http_request(url, 'POST', { }, send_headers, body)
      req = JSON.load(data)
      if !req['error'].nil?
        raise req['error']
      end
    end

  end

end
