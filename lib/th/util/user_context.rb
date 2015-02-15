require 'json'
require 'fileutils'

require_relative 'file_io'

module UserContext

  include FileIO

  def user_context
    File.exist?('.th') ? JSON.load(file_at('.th')) : { }
  end

  def user_token
    user_context['token']
  end

  def user_host
    user_context['host']
  end

  def project_name
    user_context['project_name']
  end

end
