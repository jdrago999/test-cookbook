#
# Cookbook Name:: test-cookbook
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

file '/tmp/hello.txt' do
  content "hello world -- #{node['test-cookbook']['foo']} -- updated...again!\n"
end

include_recipe  'apt'
package  'build-essential'
package 'ruby2.0'
package 'ruby2.0-dev'
package 'libxml2-dev'
package 'libxslt-dev'
package 'libssl-dev'
package 'libcrypto++-dev'

bash 'make ruby2.0 the default' do
  not_if 'ruby --version | grep "ruby 2."'
  code 'ln -sf /usr/bin/ruby2.0 /usr/bin/ruby && ln -sf /usr/bin/gem2.0 /usr/bin/gem'
end

bash 'install bundler gem' do
  code 'gem install bundler'
end

# bash 'bundle install' do
#   cwd '/var/www/simple-app'
#   user 'ubuntu'
#   code 'bundle install'
# end

service 'nginx' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

template '/etc/nginx/sites-available/default' do
  source 'nginx.conf.erb'
  notifies :reload, 'service[nginx]'
end

