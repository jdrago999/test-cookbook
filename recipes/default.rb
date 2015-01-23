#
# Cookbook Name:: test-cookbook
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

file '/tmp/hello.txt' do
  content "hello world -- #{node['test-cookbook']['foo']}\n"
end
ruby_version = '2.0.0-p576'
node.default['rbenv']['user_installs'] = [
  user: 'vagrant',
  rubies: [ruby_version],
  global: ruby_version,
  gems: {
    ruby_version: [
      {name: 'bundler'}
    ]
  }
]


include_recipe  "apt"
include_recipe  "build-essential"
include_recipe  "ruby_build"
include_recipe 'rbenv'



#package 'libxml2-dev'
#package 'libxslt-dev'

# ruby_version = '2.0.0-p576'

# rbenv_ruby ruby_version
# rbenv_global ruby_version

__END__

bash 'install rbenv ruby, dammit' do
  not_if "rbenv versions | grep '#{ruby_version}'"
  code "rbenv install #{ruby_version} && rbenv global #{ruby_version} && rbenv rehash"
end

bash 'install bundler' do
  not_if 'bundle --version'
  code 'gem install bundler'
end

bash 'chown rbenv shims' do
  code 'chown vagrant:vagrant -R /home/vagrant/.rbenv'
end

bash 'rbenv rehash' do
  user 'vagrant'
  code 'rbenv rehash'
end
