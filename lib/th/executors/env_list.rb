require_relative '../util/rest'
require_relative '../util/user_context'

require 'json'

module TH

  class EnvList

    def initialize(branch)
      @branch = branch
    end

    def run
      url = File.join(user_host, 'deployment', project_name)
      send_headers = { 'Accept' => 'application/json', 'X-TOKEN' => user_token }
      req = JSON.load(http_request(url, 'GET', { }, send_headers, ''))
      branch_data = req['branchDetails'].select { |x| x['branch'] == @branch }.first
      puts "Environmental variables for project = %s, branch = %s\n\n" % [project_name, @branch]
      branch_data['envs'].each do |k, v|
        puts "%s=%s" % [k, v]
      end
      puts ""
    end
  end

end
