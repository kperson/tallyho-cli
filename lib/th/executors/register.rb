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

  class Register

    def initialize(host, invitecode)
      @invitecode = invitecode
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

      print_prompt 'Email:'
      email = STDIN.gets.chomp()

      begin
        `stty -echo`
        print_prompt 'Password:'
        password = STDIN.gets.chomp()
      ensure
        `stty echo`
        puts ""
      end

      begin
        `stty -echo`
        print_prompt 'Confirm Password:'
        confirm_password = STDIN.gets.chomp()
      ensure
        `stty echo`
         puts ""
      end
      if password == confirm_password
        register_user(username, password, email)
      else
        raise 'passwords do not match'
      end
    end

    def register_user(username, password, email)
      url = File.join(@host, '/user')
      request_method = 'POST'
      post_data = { 'username' => username, 'email' => email, 'password' => password }
      if @invitecode
        post_data['inviteCode'] = @invitecode
      end
      body = JSON.generate(post_data)
      send_headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      req = JSON.load(http_request(url , 'POST', { }, send_headers, body))
      if !req['error'].nil?
        raise req['error']
      else
        data = user_context
        data['host'] = @host
        write_file_at('.th', JSON.generate(data))
      end
    end

  end

end
