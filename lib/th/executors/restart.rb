require 'json'

require_relative '../util/rest'
require_relative '../util/user_context'
require_relative 'deploy'

module TH

  include Rest
  include UserContext

  class Restart

    def initialize(branch)
      @branch = branch
    end

    def run
      versions_url = '%s/versions/%s/%s/' % [user_host, project_id, @branch]
      req = JSON.load(http_request(versions_url, 'GET', { }))
      if !req['error'].nil?
        raise req['error']
      else
        current_version = req['response']['current_version']
        Deploy.new(@branch, current_version).run
      end
    end

  end

end
