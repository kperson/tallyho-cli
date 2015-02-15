require 'optparse'

require_relative '../util/struct'

module TH

  class JoinParse

    @@proj_id = '--project_name <project_name>'

    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = 'Usage: th join [options]'

        opts.on(@@project_name, String, 'the project id') do |project_name|
          options.proj_id = proj_id
        end

      end

      opt_parser.parse!(args)
      self.validate(options)
      options
    end

    def self.validate(options)
      raise '%s required' % [@@project_name] if options[:project_name].nil?
    end

  end



end
