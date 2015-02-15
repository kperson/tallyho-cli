require 'json'
require 'fileutils'

require_relative '../util/rest'
require_relative '../util/file_io'
require_relative '../util/git_utils'
require_relative '../util/user_context'

module TH

  include Rest
  include FileIO
  include GitUtils
  include UserContext

  class Login

    def initialize(host)
      @host = host
    end

    def print_prompt(message)
      prompt = '> '
      puts message
      print prompt
    end

    def validate
      check_for_git_repo
      prepare_git_ignore
    end

    def run
      validate
      print_prompt 'Username:'
      username = STDIN.gets.chomp()

      begin
        `stty -echo`
        print_prompt 'Password:'
        password = STDIN.gets.chomp()
      ensure
        `stty echo`
        puts ""
        login_user(username, password)
      end
    end

    def login_user(username, password)
      body = JSON.generate({ 'username' => username, 'password' => password })
      send_headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      req = JSON.load(http_request(File.join(@host, '/auth'), 'POST', { }, send_headers, body))
      if !req['error'].nil?
        raise req['error']
      else
        data = user_context
        data['host'] = @host
        data['token'] = req['token']
        write_file_at('.th', JSON.generate(data))
      end
    end

  end

end
