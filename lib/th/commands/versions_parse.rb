require 'optparse'

require_relative '../util/struct'

module TH

  class VersionsParse

    @@branch = '--branch <branch>'

    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = 'Usage: th deploy [options]'

        opts.on(@@branch, String, 'name of branch') do |branch|
          options.branch = branch
        end

      end

      opt_parser.parse!(args)
      self.validate(options)
      options
    end

    def self.validate(options)
      raise '%s required' % [@@branch] if options[:branch].nil?
    end

  end



end
