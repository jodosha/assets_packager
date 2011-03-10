require 'spec_helper'

describe AssetsPackager::Mergers::Javascript do
  before :each do
    AssetsPackager::Configuration.write!
  end

  it "should merge all assets" do
    AssetsPackager::Mergers::Javascript.merge!
    File.exist?(AssetsPackager::Mergers::Javascript.path).should be_true
  end
end