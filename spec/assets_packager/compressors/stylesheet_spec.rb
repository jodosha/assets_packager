require 'spec_helper'

describe AssetsPackager::Compressors::Stylesheet do
  before :each do
    AssetsPackager::Configuration.write!
    AssetsPackager::Mergers::Stylesheet.merge!
  end

  it "should compress merged assets" do
    expect {
      AssetsPackager::Compressors::Stylesheet.compress!
    }.to change_file_lines(AssetsPackager::Compressors::Stylesheet.file)
  end
end