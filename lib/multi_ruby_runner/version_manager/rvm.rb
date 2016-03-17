class MultiRubyRunner
  class VersionManager

    # Represents the [rvm](https://rvm.io/) ruby version manager.
    class Rvm < VersionManager

      # See MultiRubyRunner#execute_command_in_directory
      # @return [Hash]
      #     {
      #       entire_command: includes shell invocation,
      #                       ruby version manager activation and command
      #       blocking: Boolean
      #       environment_overrides: {}
      #     }
      def compute_process_args(command_string, directory, options)
        {
          entire_command: [
            options[:shell_invocation],
            %('#{ shell_command_string(command_string, directory) }')
          ].join(' '),
          blocking: options[:blocking],
          environment_overrides: {},
        }
      end

      # Returns the command string to be passed to the shell
      def shell_command_string(command_string, directory)
        [
          activation_string, # activate rvm
          "cd #{ directory }", # cd into the directory containing .ruby-version file
          command_string, # execute command
        ].join('; ')
      end

      # Returns the string to be executed in shell to activate rvm in a shell.
      # @return [String]
      def activation_string
        # Given the @ruby_executable_path, we can compute the rvm script path
        # that needs to be sourced:
        # /Users/username/.rvm/rubies/ruby-2.2.3/bin/ruby
        #               ~/.rvm/scripts/rvm
        script_path = @ruby_executable_path.match(
          /^.+(#{ Regexp.escape("/.rvm/") })(?=rubies)/
        )[0]
        if script_path.nil?
          raise RuntimeError.new("Could not detect rvm script path! (#{ @ruby_executable_path.inspect }")
        end
        script_path << 'scripts/rvm'
        # Rvm requires sourcing of script_path:
        "source #{ script_path }"
      end

    end

  end
end
