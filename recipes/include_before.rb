#
# Cookbook Name:: chef_example
# Recipe:: include_before
#
# Copyright (c) 2016 James Walton, All Rights Reserved.

new_example_dirs = [
  { name: 'app0', type: 'java', base: '/data' },
  { name: 'app1', type: 'tomcat', base: '/data' },
  { name: 'app2', type: 'docker', base: '/data' },
]

# Roles have a higher precendence for attribute values
# You must guarantee ANY recipe using include_recipe to call your
# loop of LWRP calls be in the run_list before any role doing the same.
# Ideally, you just use roles to handle this behavior.
node.default[:chef_example][:lwrp_dirs] = new_example_dirs

include_recipe 'chef_example::default'
