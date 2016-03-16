# -*- coding: utf-8 -*-

require_relative './spec_helper'

describe MultiRubyRunner do

  it "responds to #execute_command_in_directory" do
    mrr = MultiRubyRunner.new
    mrr.respond_to?(:execute_command_in_directory).must_equal(true)
  end

  it "responds to #ruby_version_manager" do
    mrr = MultiRubyRunner.new
    mrr.respond_to?(:ruby_version_manager).must_equal(true)
  end

end
