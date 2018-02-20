class MultiRubyRunner
  class VersionManager

    # Represents a ruby environment without a version manager.
    # In this case the Ruby engine invocation must be given via the
    # options[:ruby_engine_invocation_override]. Example: "jruby -S"
    class None < VersionManager

      # See MultiRubyRunner#execute_command_in_directory
      # @return [Hash]
      #     {
      #       entire_command: includes shell invocation, ruby engine invocation,
      #                       and command
      #       blocking: Boolean
      #       environment_overrides: {}
      #     }
      def compute_process_args(command_string, directory, options)
        if '' == options[:ruby_engine_invocation_override].to_s.strip
          raise "No :ruby_engine_invocation_override given!"
        end
        ruby_command = [
          options[:ruby_engine_invocation_override], # Example: "jruby -S"
          command_string, # execute command
        ].join(' ')
        shell_command_string = ["cd #{ directory }", ruby_command].join('; ')
        {
          entire_command: [
            options[:shell_invocation],
            shell_command_string,
          ].join(' '),
          blocking: options[:blocking],
          environment_overrides: {},
        }
      end

    end

  end
end
