#
# Cookbook Name:: test-cookbook
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

file '/tmp/hello.txt' do
  content "hello world -- #{node['test-cookbook']['foo']}\n"
end

include_recipe  'apt'
package  'build-essential'
package 'ruby2.0'
package 'ruby2.0-dev'
package 'libxml2-dev'
package 'libxslt-dev'

bash 'make ruby2.0 the default' do
  not_if 'ruby --version | grep "ruby 2."'
  code 'ln -sf /usr/bin/ruby2.0 /usr/bin/ruby && ln -sf /usr/bin/gem2.0 /usr/bin/gem'
end

bash 'install bundler gem' do
  code 'gem install bundler'
end
