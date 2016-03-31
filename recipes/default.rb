#
# Cookbook Name:: chef_example
# Recipe:: default
#
# Copyright (c) 2016 James Walton, All Rights Reserved.

node[:chef_example][:lwrp_dirs].each do |app|
  chef_example_dir app[:name] do
    type    app[:type]
    base    app[:base]
    action  :create
  end
end

chef_example_dir 'delete_me' do
  type    'docker'
  base    '/data'
  action  :delete
end
