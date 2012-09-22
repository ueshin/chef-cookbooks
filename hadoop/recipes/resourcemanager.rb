#
# Cookbook Name:: hadoop
# Recipe:: resourcemanager
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

include_recipe "hadoop::yarn"

package "hadoop-yarn-resourcemanager" do
  action [ :install, :upgrade ]
end

service "hadoop-yarn-resourcemanager" do
  supports :status => true, :restart => true, :reload => false
  action [ :disable, :stop ]
end
