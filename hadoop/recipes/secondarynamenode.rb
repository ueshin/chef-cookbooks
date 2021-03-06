#
# Cookbook Name:: hadoop
# Recipe:: secondarynamenode
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

node[:hadoop][:core][:checkpoint][:dir].each do |dir|
  directory File.dirname(dir) do
    mode "0755"
    recursive true
  end

  directory dir do
    owner "hdfs"
    group "hadoop"
    mode "0755"
  end
end

package "hadoop-0.20-secondarynamenode" do
  version node[:hadoop][:version]
end

service "hadoop-0.20-secondarynamenode" do
  supports :start => true, :stop => true, :status => true, :restart => true
end
