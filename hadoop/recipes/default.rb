#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2011, Happy-Camper Street
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

include_recipe "hadoop::lzo"

directory "/usr/lib/hadoop-0.20" do
  mode "0755"
  recursive true
end

group "mapred" do
  gid 201
end

user "mapred" do
  uid "201"
  gid "mapred"
  comment "Hadoop MapReduce"
  home "/usr/lib/hadoop-0.20"
end

group "hdfs" do
  gid 202
end

user "hdfs" do
  uid "202"
  gid "hdfs"
  comment "Hadoop HDFS"
  home "/usr/lib/hadoop-0.20"
end

group "hadoop" do
  gid 200
  members ["mapred", "hdfs"]
end

user "hadoop" do
  uid "200"
  gid "hadoop"
  comment "Hadoop"
  home "/usr/lib/hadoop-0.20"
end

hadooptmpdir = node[:hadoop][:core][:tmp][:dir]

directory File.dirname(hadooptmpdir) do
  mode "0755"
  recursive true
  not_if do
    File.exists?(File.dirname(hadooptmpdir))
  end
end

directory hadooptmpdir do
  owner "hadoop"
  group "hadoop"
  mode "0777"
end

remote_file "/etc/yum.repos.d/cloudera-cdh3.repo" do
  source "http://archive.cloudera.com/redhat/cdh/cloudera-cdh3.repo"
  mode "0644"
end

package "hadoop-0.20" do
  version node[:hadoop][:version]
end

cookbook_file "/etc/hadoop/conf/hadoop-metrics.properties" do
  source "hadoop-metrics.properties"
  mode "0644"
end


execute "cp hadoop-lzo-#{node[:hadoop][:lzo][:version]}.jar /usr/lib/hadoop-0.20/lib"
  cwd "/usr/local/src/#{node[:hadoop][:lzo][:archive]}/build"
  creates "/usr/lib/hadoop-0.20/lib/hadoop-lzo-#{node[:hadoop][:lzo][:version]}.jar"
end

directory "/usr/lib/hadoop-0.20/lib/native/Linux-amd64-64" do
  mode "0755"
  recursive true
end

execute "cp -d native/Linux-amd64-64/lib/* /usr/lib/hadoop-0.20/lib/native/Linux-amd64-64/"
  cwd "/usr/local/src/#{node[:hadoop][:lzo][:archive]}/build"
  creates "/usr/lib/hadoop-0.20/lib/native/Linux-amd64-64/libgplcompression.so.0.0.0"
end
