require 'optparse'

require_relative '../util/struct'

module TH

  class BranchAddParse

    @@branch = '--branch <branch>'
    @@host = '--host <host>'
    @@app = '--app <app>'
    @@port = '--port <port>'

    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = 'Usage: th branch-add [options]'

        opts.on(@@branch, String, 'name of branch') do |name|
          options.branch = name
        end

        opts.on(@@host, String, 'name of the host') do |name|
          options.host = name
        end

        opts.on(@@app, String, 'name of the app') do |name|
          options.app = name
        end

        opts.on(@@port, String, 'the port to map') do |port|
          options.port = port.to_i
        end

      end

      opt_parser.parse!(args)
      self.validate(options)

      options

    end

    def self.validate(options)
      raise '%s required' % [@@branch] if options[:branch].nil?
      raise '%s required' % [@@host] if options[:host].nil?
      raise '%s required' % [@@port] if options[:port].nil?
      raise '%s required' % [@@app] if options[:app].nil?
    end

  end



end
