AssetsPackager.configure do |config|
  config.root_path = ::Rails.public_path
  config.file_path = ::Rails.root.join('config', 'assets.yml')
end
