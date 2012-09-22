#
# Cookbook Name:: zookeeper
# Recipe:: default
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

group "zookeeper" do
  gid 200
end

user "zookeeper" do
  uid "200"
  gid "zookeeper"
  comment "ZooKeeper"
  home "/var/run/zookeeper"
  shell "/sbin/nologin"
end

package "zookeeper" do
  action [ :install, :upgrade ]
end

template "/etc/zookeeper/conf/zoo.cfg" do
  source "zoo.cfg.erb"
  mode "0644"
  owner "zookeeper"
  group "zookeeper"

  variables( :zookeepers => search(:node, 'role:ZooKeeper').sort_by { |zk| zk[:hostname] } )
end
