class MultiRubyRunner

  # Abstract class for ruby version managers like rbenv and rvm (or none)
  class VersionManager

    # Detects if and which ruby version manager is present.
    def self.detect
      which_ruby = `which ruby`
      case which_ruby
      when /\/\.rbenv\//
        Rbenv.new(which_ruby)
      when /\/\.rvm\//
        Rvm.new(which_ruby)
      else
        None.new(which_ruby)
      end
    end

    # Instantiates a new VersionManager.
    # @param ruby_path [String] path to ruby executable, as returned by `which ruby`
    def initialize(ruby_executable_path)
      @ruby_executable_path = ruby_executable_path
    end

    def activation_string
      raise "Implement #activation_string in subclasses!"
    end

  end

end
