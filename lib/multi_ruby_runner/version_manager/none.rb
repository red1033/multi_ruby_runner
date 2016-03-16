class MultiRubyRunner
  class VersionManager

    # Represents a ruby environment without a version manager.
    # In this case MultiRubyRunner won't work and will raise errors instead.
    class None < VersionManager
    end

  end
end
