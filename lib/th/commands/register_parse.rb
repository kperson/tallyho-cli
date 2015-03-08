require 'optparse'

require_relative '../util/struct'

module TH

  class RegisterParse

    @@host_name = '--host <host_url>'
    @@invitecode = '--invitecode <invitecode>'

    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = 'Usage: th register [options]'

        opts.on(@@host_name, String, 'the th host') do |name|
          options.host = name
        end

        opts.on(@@invitecode, String, 'the invite code (optional for first user)') do |code|
          options.invitecode = code
        end

      end

      opt_parser.parse!(args)
      self.validate(options)
      options
    end

    def self.validate(options)
      raise '%s required' % [@@host_name] if options[:host].nil?
    end

  end



end
