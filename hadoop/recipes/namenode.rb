#
# Cookbook Name:: hadoop
# Recipe:: namenode
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

include_recipe "hadoop::hdfs"

node[:hadoop][:hdfs][:name][:dir].each do |dir|
  directory File.dirname(dir) do
    mode "0755"
    recursive true
    not_if do
      File.exists?(File.dirname(dir))
    end
  end

  directory dir do
    owner "hdfs"
    group "hadoop"
    mode "0755"
  end
end

package "hadoop-0.20-namenode" do
  action :install
  notifies :run, "script[format-namenode]", :immediately
end

script "format-namenode" do
  interpreter "bash"
  user "hdfs"
  code "hadoop namenode -format"
  action :nothing
  notifies :start, "service[hadoop-0.20-namenode]", :immediately
  notifies :run, "script[create-hdfs-directories]", :immediately
end

service "hadoop-0.20-namenode" do
  supports :start => true, :stop => true, :status => true, :restart => true, :upgrade => true
end

script "create-hdfs-directories" do
  interpreter "bash"
  user "hdfs"
  flags "-e"
  code <<-EOH
  hadoop fs -mkdir #{node[:hadoop][:core][:tmp][:dir]}
  hadoop fs -chmod -R 1777 #{node[:hadoop][:core][:tmp][:dir]}
  hadoop fs -mkdir #{node[:hadoop][:mapred][:system][:dir]}
  hadoop fs -chown mapred:hadoop #{node[:hadoop][:mapred][:system][:dir]}
  EOH
  action :nothing
end
