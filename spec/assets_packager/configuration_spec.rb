require 'spec_helper'

describe AssetsPackager::Configuration do
  before :each do
    AssetsPackager::Cleaner.clear!
  end

  it "should write configuration" do
    AssetsPackager::Configuration.write!
    File.exist?(File.join(AssetsPackager::Configuration.file_path)).should be_true
  end
end