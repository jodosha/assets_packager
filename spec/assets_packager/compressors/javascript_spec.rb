require 'spec_helper'

describe AssetsPackager::Compressors::Javascript do
  before :each do
    AssetsPackager::Configuration.write!
    AssetsPackager::Mergers::Javascript.merge!
  end

  it "should compress merged assets" do
    expect {
      AssetsPackager::Compressors::Javascript.compress!
    }.to change_file_lines(AssetsPackager::Compressors::Javascript.file)
  end
end