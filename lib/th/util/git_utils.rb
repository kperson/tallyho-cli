require 'fileutils'

require_relative 'file_io'
require_relative '../util/git_utils'

module GitUtils

  include FileIO

  # Returns if the current directory is a git repo
  #
  # @return [Fixnum] whether this directory is a git repo
  def is_git_repo
    system 'git rev-parse'
  end

  #Raises an error if the current directory is not a git repo
  def check_for_git_repo
    raise 'this is not a valid git repo' if !is_git_repo
  end


  def has_git_remote(branch_name)
    `git remote`.split("\n").include?(branch_name)
  end

  def prepare_git_ignore
    contents = File.exists?('.gitignore') ? file_at('.gitignore') : ''
    if !contents.split("\n").include?('.th')
      git_contents = contents + "\n.th"
      write_file_at('.gitignore', git_contents)
    end
  end


end
