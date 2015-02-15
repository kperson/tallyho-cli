require_relative '../util/file_io'
require_relative '../util/rest'
require_relative '../util/user_context'

module TH

  class KeyAdd

    include FileIO
    include Rest
    include UserContext

    def initialize(file, key_name)
      @key_name = key_name
      @file = file
    end

    def run
      ssh_file = File.expand_path(@file)
      if system('ssh-keygen -lf %s > /dev/null' % [ssh_file])
        contents = file_at(ssh_file)
        key_info = `ssh-keygen -lf #{ssh_file}`
        puts 'uploading key with fingerprint %s' % [key_info.split(' ')[1]]
        body = JSON.generate({ 'contents' => contents, 'name' => @key_name })
        send_headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'X-TOKEN' => user_token }
        req = JSON.load(http_request(File.join(user_host, '/git'), 'POST', { }, send_headers, body))
        raise req['error'] if !req['error'].nil?
      else
        raise '"%s" is not a valid public key' % [@file]
      end
    end

  end

end
