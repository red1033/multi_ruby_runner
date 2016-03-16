class MultiRubyRunner
  class VersionManager

    # Represents the [rbenv](https://github.com/rbenv/rbenv) ruby version manager.
    class Rbenv < VersionManager

      # Returns the string to be executed in shell to activate self in a shell.
      # @return [String]
      def activation_string
        %(eval "$(rbenv init -)")
      end

      # This is what `rbenv init -` returns:

      # export PATH="/home/deploy/.rbenv/shims:${PATH}"
      # export RBENV_SHELL=bash
      # source '/home/deploy/.rbenv/libexec/../completions/rbenv.bash'
      # command rbenv rehash 2>/dev/null
      # rbenv() {
      #   local command
      #   command="$1"
      #   if [ "$#" -gt 0 ]; then
      #     shift
      #   fi

      #   case "$command" in
      #   rehash|shell)
      #     eval "$(rbenv "sh-$command" "$@")";;
      #   *)
      #     command rbenv "$command" "$@";;
      #   esac
      # }

    end

  end
end
