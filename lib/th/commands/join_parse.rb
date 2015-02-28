require 'optparse'

require_relative '../util/struct'

module TH

  class JoinParse

    @@proj_id = '--project_name <project_name>'

    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = 'Usage: th join [options]'

        opts.on(@@proj_id, String, 'the project name') do |proj_id|
          options.proj_id = proj_id
        end

      end

      opt_parser.parse!(args)
      self.validate(options)
      options
    end

    def self.validate(options)
      raise '%s required' % [@@proj_id] if options[:proj_id].nil?
    end

  end



end
