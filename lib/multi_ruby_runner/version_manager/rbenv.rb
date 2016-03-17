class MultiRubyRunner
  class VersionManager

    # Represents the [rbenv](https://github.com/rbenv/rbenv) ruby version manager.
    class Rbenv < VersionManager

      # See MultiRubyRunner#execute_command_in_directory
      # @return [Hash]
      #     {
      #       entire_command: includes shell invocation,
      #                       ruby version manager activation and command
      #       blocking: Boolean
      #       environment_overrides: {}
      #     }
      def compute_process_args(command_string, directory, options)
        shell_command_string = [
          "cd #{ directory }", # cd into the directory containing .ruby-version file
          %(eval "$(rbenv init -)"), # let rbenv update the environment (particularly PATH)
          command_string, # execute command
        ].join('; ')
        # For rbenv we just have to reset RBENV_VERSION and override RBENV_DIR
        # to get the ruby environment specified in `.ruby-version` in directory.
        {
          entire_command: [
            options[:shell_invocation],
            shell_command_string,
          ].join(' '),
          blocking: options[:blocking],
          environment_overrides: {
            'RBENV_VERSION' => nil,
            'RBENV_DIR' => directory,
          },
        }
      end

    end

  end
end
