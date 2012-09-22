#
# Cookbook Name:: conf-pseudo
# Recipe:: prepare
#
# Copyright 2011-2012, Happy-Camper Street
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

directory "/var/chef-solo/data_bags" do
  mode "0755"
  recursive true
end

directory "/var/chef-solo/data_bags/node" do
  mode "0755"
  recursive true
end

cookbook_file "/var/chef-solo/data_bags/node/localhost.json" do
  source "localhost.json"
  mode "0644"
end

directory "/var/chef-solo/roles" do
  mode "0755"
  recursive true
end

git "/var/chef-solo/chef-solo-search" do
  repository "git://github.com/edelight/chef-solo-search.git"
  reference "master"
  action :sync
end

%w{zookeeper hadoop hbase}.each do |dir|
  directory "/var/chef-solo/cookbooks/#{dir}/libraries" do
    mode "0755"
    recursive true
  end

  execute "chef-solo-search.rb" do
    command "cp /var/chef-solo/chef-solo-search/libraries/* /var/chef-solo/cookbooks/#{dir}/libraries"
    creates "/var/chef-solo/cookbooks/#{dir}/chef-solo-search.rb"
  end
end

cookbook_file "/var/chef-solo/roles/ZooKeeper.rb" do
  source "ZooKeeper.rb"
  mode "0644"
end
