require 'optparse'

require_relative '../util/struct'

module TH

  class RouteAddParse

    @@branch = '--branch <branch>'
    @@host = '--host <host>'
    @@app = '--app <app>'
    @@port = '--port <port>'
    @@publickey = '--publickey --<key>'
    @@privatekey = '--privatekey --<key>'


    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: th route-add [options]\n('see https://gist.github.com/ipedrazas/6d6c31144636d586dcc3 for SSL key gen')"

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

        opts.on(@@publickey, String, 'the public key file') do |key|
          options.publickey = key
        end

        opts.on(@@privatekey, String, 'the private key file') do |key|
          options.privatekey = key
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

      if !options[:publickey].nil?
        if File.exist?(options[:publickey])
          raise '%s required' % [@@privatekey] if options[:privatekey].nil?
        else
          raise '%s does not exist' % [options[:publickey]]
        end
      end

      if !options[:privatekey].nil?
        if File.exist?(options[:privatekey])
          raise '%s required' % [@@publickey] if options[:publickey].nil?
        else
          raise '%s does not exist' % [options[:privatekey]]
        end
      end

    end

  end



end
