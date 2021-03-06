require 'json'

require_relative '../util/rest'
require_relative '../util/user_context'
require_relative '../util/file_io'

module TH

  include Rest
  include UserContext
  include FileIO

  class BranchAdd

    def initialize(branch)
      @branch = branch
    end

    def run
      url = File.join(user_host, 'branch')
      post_data = { :projectName => project_name, :branch => @branch }

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
