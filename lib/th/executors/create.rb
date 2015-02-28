require 'json'

require_relative '../util/rest'
require_relative '../util/user_context'
require_relative '../util/file_io'
require_relative 'join'

module TH

  include Rest
  include UserContext
  include FileIO

  class Create

    def initialize(name)
      @name = name
    end

    def run
      body = JSON.generate({ :name => @name })
      url = File.join(user_host, 'project')
      send_headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'X-TOKEN' => user_token }
      req = JSON.load(http_request(url, 'POST', { }, send_headers, body))
      if !req['error'].nil?
        raise req['error']
      else
        Join.new(@name).run
      end
    end

    def add_to_project(git_url)
      if has_git_remote('th')
        system 'git remote remove th'
      end
      command = 'git remote add th %s' % [git_url]
      system command
      puts 'Remote added'
    end

  end

end
