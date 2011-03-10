require 'spec_helper'

describe AssetsPackager::Mergers::Stylesheet do
  before :each do
    AssetsPackager::Configuration.write!
  end

  it "should merge all assets" do
    AssetsPackager::Mergers::Stylesheet.merge!
    File.exist?(AssetsPackager::Mergers::Stylesheet.path).should be_true
  end
end