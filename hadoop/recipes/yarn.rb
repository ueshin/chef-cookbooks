#
# Cookbook Name:: hadoop
# Recipe:: yarn
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

include_recipe "hadoop"

directory "/usr/lib/hadoop-yarn" do
  mode "0755"
end

group "yarn" do
  gid 212
end

user "yarn" do
  uid "212"
  gid "yarn"
  comment "Hadoop Yarn"
  home "/var/lib/hadoop-yarn"
end

group "hadoop" do
  action :modify
  members ["yarn"]
  append true
end

package "hadoop-yarn" do
  version node[:hadoop][:version]
end
