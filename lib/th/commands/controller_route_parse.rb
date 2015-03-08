require 'optparse'

require_relative '../util/struct'

module TH

  class ControllerRouteParse

    @@host = '--host <host>'
    @@publickey = '--publickey --<key>'
    @@privatekey = '--privatekey --<key>'

    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: th controller-route [options]\n('see https://gist.github.com/ipedrazas/6d6c31144636d586dcc3 for SSL key gen')"

        opts.on(@@host, String, 'name of the host') do |name|
          options.host = name
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
      raise '%s required' % [@@host] if options[:host].nil?

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
