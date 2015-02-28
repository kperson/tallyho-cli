require 'json'
require 'uri'

require_relative '../util/rest'
require_relative '../util/user_context'
require_relative '../util/file_io'
require_relative '../util/git_utils'

module TH

  include Rest
  include UserContext
  include FileIO


  class Join

    def initialize(project_name)
      @project_name = project_name
    end

    def run
      raise 'please register or login' if user_token.nil? || user_host.nil?
      url = File.join(user_host, 'project', @project_name)
      send_headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'X-TOKEN' => user_token }
      req = JSON.load(http_request(url, 'GET', { }, send_headers))
      if !req['error'].nil?
        raise req['error']
      else
        add_to_project(req['gitUrl'])
        data = user_context
        data['project_name'] = req['project']['name']
        write_file_at('.th', JSON.generate(data))
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
