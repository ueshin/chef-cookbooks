#
# Cookbook Name:: hadoop
# Recipe:: hdfs
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

include_recipe "hadoop"

namenode = search(:node, 'role:NameNode')[0]

template "/etc/hadoop/conf/core-site.xml" do
  source "core-site.xml.erb"
  mode "0644"

  variables( :namenode      => namenode,
             :hadooptmpdir  => node[:hadoop][:core][:tmp][:dir],
             :namenodeport  => node[:hadoop][:core][:namenodeport],
             :checkpointdir => node[:hadoop][:core][:checkpoint][:dir] )
end

template "/etc/hadoop/conf/hdfs-site.xml" do
  source "hdfs-site.xml.erb"
  mode "0644"

  variables( :namenode => namenode,
             :namedir  => node[:hadoop][:hdfs][:name][:dir],
             :datadir  => node[:hadoop][:hdfs][:data][:dir] )
end

template "/etc/hadoop/conf/masters" do
  source "masters.erb"
  mode "0644"

  variables( :secondarynamenodes => search(:node, 'role:SecondaryNameNode').sort_by { |snn| snn[:hostname] } )
end

template "/etc/hadoop/conf/slaves" do
  source "slaves.erb"
  mode "0644"

  variables( :datanodes => search(:node, 'role:DataNode').sort_by { |dn| dn[:hostname] } )
end
