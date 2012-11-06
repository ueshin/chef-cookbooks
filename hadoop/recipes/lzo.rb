#
# Cookbook Name:: hadoop
# Recipe:: lzo
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

package "lzo"
package "lzo-devel"
package "lzop"

github  = node[:hadoop][:lzo][:github]
archive = node[:hadoop][:lzo][:archive]
version = node[:hadoop][:lzo][:version]

remote_file "/usr/local/src/#{archive}.tar.gz" do
  source github
  mode "0644"
end

execute "tar zxvf #{archive}.tar.gz" do
  cwd "/usr/local/src"
  creates "/usr/local/src/#{archive}"
end

execute "ant compile-native jar" do
  cwd "/usr/local/src/#{archive}"
  environment( 'CFLAGS' => '-m64', 'JAVA_HOME' => '/usr/java/default' )
  creates "/usr/local/src/#{archive}/build/hadoop-lzo-#{version}.jar"
end

execute "cp hadoop-lzo-#{node[:hadoop][:lzo][:version]}.jar /usr/lib/hadoop-0.20/lib" do
  cwd "/usr/local/src/#{node[:hadoop][:lzo][:archive]}/build"
  creates "/usr/lib/hadoop-0.20/lib/hadoop-lzo-#{node[:hadoop][:lzo][:version]}.jar"
end

directory "/usr/lib/hadoop-0.20/lib/native/Linux-amd64-64" do
  mode "0755"
  recursive true
end

execute "cp -d native/Linux-amd64-64/lib/* /usr/lib/hadoop-0.20/lib/native/Linux-amd64-64/" do
  cwd "/usr/local/src/#{node[:hadoop][:lzo][:archive]}/build"
  creates "/usr/lib/hadoop-0.20/lib/native/Linux-amd64-64/libgplcompression.so.0.0.0"
end
