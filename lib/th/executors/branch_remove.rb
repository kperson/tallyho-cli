require 'json'

require_relative '../util/rest'
require_relative '../util/user_context'
require_relative '../util/file_io'

module TH

  include Rest
  include UserContext
  include FileIO

  class BranchRemove

    def initialize(branch)
      @branch = branch
    end

    def run
      req = JSON.load(http_request('%s/%s' % [user_host, '/branch/'], 'DELETE', { :branch => @branch, :project_id => project_id }))
      if !req['error'].nil?
        raise req['error']
      end
    end

  end

end
