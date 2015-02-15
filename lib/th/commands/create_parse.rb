require 'optparse'

require_relative '../util/struct'

module TH

  class CreateParse

    @@project_name = '--name <project_name>'
    @@docker_project = '--docker <docker_project>'

    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = 'Usage: th create [options]'

        opts.on(@@project_name, String, 'name of project') do |name|
          options.name = name
        end

        opts.on(@@docker_project, String, 'name of docker push point') do |name|
          options.docker_project = name
        end


      end

      opt_parser.parse!(args)

      self.validate(options)

      options

    end

    def self.validate(options)
      raise '%s required' % [@@project_name] if options[:name].nil?
    end

  end



end
