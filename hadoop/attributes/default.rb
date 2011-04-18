#
# Cookbook Name:: hadoop
# Attributes:: default
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

default[:hadoop][:version] = "0.20.2+923"

default[:hadoop][:heapsize] = 1000

default[:hadoop][:core][:namenodeport]     = 9000
default[:hadoop][:mapred][:jobtrackerport] = 9001

default[:hadoop][:core][:tmp][:dir]        = "/var/lib/hadoop"

default[:hadoop][:core][:checkpoint][:dir] = [] #["#{default[:hadoop][:core][:tmp][:dir]}/dfs/namesecondary"]

default[:hadoop][:hdfs][:name][:dir]       = [] #["#{default[:hadoop][:core][:tmp][:dir]}/dfs/name"]
default[:hadoop][:hdfs][:data][:dir]       = [] #["#{default[:hadoop][:core][:tmp][:dir]}/dfs/data"]

default[:hadoop][:mapred][:local][:dir]    = []  #["#{default[:hadoop][:core][:tmp][:dir]}/mapred/local"]
default[:hadoop][:mapred][:system][:dir]   = nil # "#{default[:hadoop][:core][:tmp][:dir]}/mapred/system"
default[:hadoop][:mapred][:staging][:dir]  = nil # "#{default[:hadoop][:core][:tmp][:dir]}/mapred/staging"
default[:hadoop][:mapred][:temp][:dir]     = nil # "#{default[:hadoop][:core][:tmp][:dir]}/mapred/temp"

default[:hadoop][:mapred][:tasktracker][:map][:tasks][:maximum]    = 2
default[:hadoop][:mapred][:tasktracker][:reduce][:tasks][:maximum] = 2
default[:hadoop][:mapred][:child][:java][:opts]                    = nil #"-Xmx200m"


default[:hadoop][:lzo][:github]  = "https://github.com/kevinweil/hadoop-lzo/tarball/2ad6654f3e9cad97d13f716e51a0509253c0aabb"
default[:hadoop][:lzo][:archive] = "kevinweil-hadoop-lzo-2ad6654"
default[:hadoop][:lzo][:version] = "0.4.10"
