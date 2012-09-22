#
# Cookbook Name:: hadoop
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

include_recipe "zookeeper"

directory "/usr/lib/hadoop" do
  mode "0755"
end

group "hadoop" do
  gid 210
end

user "hadoop" do
  uid "210"
  gid "hadoop"
  comment "Hadoop"
  home "/usr/lib/hadoop"
end

remote_file "/etc/yum.repos.d/cloudera-cdh4.repo" do
  action :create_if_missing
  source "http://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/cloudera-cdh4.repo"
  mode "0644"
end

package "hadoop" do
  action [ :install, :upgrade ]
end

template "/etc/hadoop/conf/core-site.xml" do
  source "core-site.xml.erb"
  mode "0644"

  variables( :namenode => search(:node, 'role:NameNode')[0] )
end
