#
# Cookbook Name:: flume
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

group "flume" do
  gid 205
end

user "flume" do
  uid "205"
  gid "flume"
  comment "Flume"
  home "/var/run/flume"
end

group "hadoop" do
  members ["flume"]
  append true
end

package "flume" do
  version node[:flume][:version]
end

template "/etc/flume/conf/flume-site.xml" do
  source "flume-site.xml.erb"
  mode "0644"
  owner "flume"
  group "flume"

  variables( :serverid     => node[:flume][:master][:serverid],
             :flumemasters => search(:node, 'role:FlumeMaster').sort_by { |fm| fm[:hostname] },
             :zookeepers   => search(:node, 'role:ZooKeeper'  ).sort_by { |zk| zk[:hostname] } )
end


link "/usr/lib/flume/lib/hadoop-lzo-#{node[:hadoop][:lzo][:version]}.jar" do
  to "/usr/lib/hadoop-0.20/lib/hadoop-lzo-#{node[:hadoop][:lzo][:version]}.jar"
  only_if "test -f /usr/lib/hadoop-0.20/lib/hadoop-lzo-#{node[:hadoop][:lzo][:version]}.jar"
end

%w{
  libgplcompression.a
  libgplcompression.la
  libgplcompression.so
  libgplcompression.so.0
  libgplcompression.so.0.0.0
}.each do |file|
  link "/usr/lib/flume/lib/#{file}" do
    to "/usr/lib/hadoop-0.20/lib/native/Linux-amd64-64/#{file}"
    only_if "test -f /usr/lib/hadoop-0.20/lib/native/Linux-amd64-64/#{file}"
  end
end
