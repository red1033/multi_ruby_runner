# -*- coding: utf-8 -*-

require "multi_ruby_runner/version"
require 'multi_ruby_runner'
require 'multi_ruby_runner/version_manager'
require 'multi_ruby_runner/version_manager/none'
require 'multi_ruby_runner/version_manager/rbenv'
require 'multi_ruby_runner/version_manager/rvm'

# Allows calling of Ruby code in various Ruby environments.
class MultiRubyRunner

  def initialize
  end

  # Executes a blocking command in a directory.
  # Command will be executed in the ruby environment specified in .ruby-version
  # file in the directory.
  # Example command:
  # `/bin/bash -c 'source /Users/johund/.rvm/scripts/rvm; cd /Users/johund/development/vgr-table-export; ruby -v'`
  # @param command_string [String] the command to run in directory
  # @param directory [String] the dir containing the ".ruby-version" file and the ruby project to run
  # @param options [Hash, optional]
  # @option options [String, optional] shell_invocation what shell to use, defaults to bash
  # @option options [Boolean, optional] blocking, defaults to true.
  # @return [String] STDOUT output
  def execute_command_in_directory(command_string, directory, options = {})
    shell_path = ENV['SHELL'] || '/bin/bash'
    options = {
      blocking: true,
      shell_invocation: "#{ shell_path } -c",
    }.merge(options)
    shell_command_string = [
      ruby_version_manager.activation_string, # e.g., "source ~/.rvm/scripts/rvm"
      "cd #{ directory }",
      command_string
    ].join('; ')
    entire_command = "#{ options[:shell_invocation] } '#{ shell_command_string }'"

    # Bundler.with_clean_env avoids spilling over of any bundler environment
    # e.g., BUNDLE_BIN_PATH, BUNDLE_GEMFILE, and RUBYOPT
    if options[:blocking]
      # Wait for command to complete
      Bundler.with_clean_env do
        `#{ entire_command }`
      end
    else
      # Fork new process, execute command there and return immediately to caller.
      fork do
        Bundler.with_clean_env do
          `#{ entire_command }`
        end
      end
    end
  end

  # Returns the ruby version manager used
  # @return [MultiRubyRunner::VersionManager] 'rbenv', 'rvm', 'none'
  def ruby_version_manager
    VersionManager.detect
  end

end
