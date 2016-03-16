# -*- coding: utf-8 -*-

require_relative '../spec_helper'

class MultiRubyRunner
  describe VersionManager do

    it "responds to .detect" do
      VersionManager.respond_to?(:detect).must_equal(true)
    end

  end
end
