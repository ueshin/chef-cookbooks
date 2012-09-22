#
# Cookbook Name:: hadoop
# Attributes:: default
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

default[:hadoop][:hdfs][:tmp][:dir]        = '/var/lib/hadoop-hdfs/cache/${user.name}'
default[:hadoop][:hdfs][:name][:dir]       = ['/var/lib/hadoop-hdfs/cache/${user.name}/dfs/name']
default[:hadoop][:hdfs][:checkpoint][:dir] = ['/var/lib/hadoop-hdfs/cache/${user.name}/dfs/namesecondary']
default[:hadoop][:hdfs][:data][:dir]       = ['/var/lib/hadoop-hdfs/cache/${user.name}/dfs/data']
default[:hadoop][:hdfs][:replication]      = 3

default[:hadoop][:yarn][:nodemanager][:localdirs]       = ['/var/lib/hadoop-yarn/cache/${user.name}/nm-local-dir']
default[:hadoop][:yarn][:nodemanager][:logdirs]         = ['/var/log/hadoop-yarn/containers']
default[:hadoop][:yarn][:nodemanager][:remoteapplogdir] = '/var/log/hadoop-yarn/apps'

default[:hadoop][:mapreduce][:task][:tmpdir] = '/var/lib/hadoop-mapreduce/cache/${user.name}/tasks'
