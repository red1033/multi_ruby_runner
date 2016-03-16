class MultiRubyRunner
  class VersionManager

    # Represents the [rvm](https://rvm.io/) ruby version manager.
    class Rvm < VersionManager

      # Returns the string to be executed in shell to activate self in a shell.
      # @return [String]
      def activation_string
        # Given the @ruby_executable_path, we can compute the rvm script path
        # that needs to be sourced:
        # /Users/uname/.rvm/rubies/ruby-2.2.3/bin/ruby
        #            ~/.rvm/scripts/rvm
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
