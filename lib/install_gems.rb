def install_gems(&block)
  yield
rescue LoadError => e

  gem_name = e.message.split('--').last.strip
  install_command = 'gem install ' + gem_name

  # install missing gems
  puts "Cannot find gem: " + gem_name + "."
  puts "Should it be installed? y/n"
  exit(1) unless (gets.strip == ('y' || 'Y'))
  system(install_command) || exit(1)

  # retry running the script
  Gem.clear_paths
  puts 'Restarting'
  require gem_name
  retry
end
