Chef cookbooks
==============

Hadoopクラスタ管理に使っているChefのレシピを公開しています。


環境
----

- CentOS 5.6
- Chef 0.9.8-2.el5


How to use
----------

cookbookをChefサーバーに追加してください。

各cookbookの `attributes/defalut.rb` を編集することで設定をカスタマイズすることが可能です。
また、各Nodeの設定でAttributesを設定することでNode個別のカスタマイズも可能です。

### Roleの設定 ###

各サーバーに対するRoleの設定を行います。
Roleの設定で、`Run List`に下記で指定のrecipeを追加してください。

Role名は大文字小文字を区別します。

#### Ganglia 3.0.7 #####

##### `GangliaMetaNode` #####

- ganglia::gmetad

クラスタ内でこのRoleを設定できるのは1台のみです。

##### `GangliaMoniteringNode` #####

- ganglia::gmond


#### Hadoop 0.20.2+923.21 (cdh3u0) ####

ファイルディスクリプタやswappinessの設定は行いませんので、個別に設定しておいてください。
また、JDKのインストールも行いませんので、予めインストールしておいてください。

LZOのインストールに ant 1.7, ant-nodeps 1.7, gcc が必要です。

##### `NameNode` #####

- hadoop::namenode

クラスタ内でこのRoleを設定できるのは1台のみです。

##### `SecondaryNameNode` #####

- hadoop::secondarynamenode

##### `DataNode` #####

- hadoop::datanode

##### `JobTracker` #####

- hadoop::jobtracker

クラスタ内でこのRoleを設定できるのは1台のみです。

##### `TaskTracker` #####

- hadoop::tasktracker


#### ZooKeeper 3.3.3+12.1 (cdh3u0) ####

##### `ZooKeeper` ####

- zookeeper::server

このRoleを設定したNodeには、必ず Attribute `"zookeeper":{"myid":0}` を設定してください。
myidは同じ値にならないようにしてください。

#### HBase 0.90.1+15.18 (cdh3u0) ####

HadoopとZooKeeperのcookbookが必要です。

##### `HMaster` #####

- zookeeper::client
- hbase::hmaster

##### `RegionServer` #####

- zookeeper::client
- hbase::regionserver


#### Flume 0.9.3+15.3 (cdh3u0) ####

HadoopとZooKeeperのcookbookが必要です。

##### `FlumeMaster` #####

- zookeeper::client
- flume::master

このRoleを設定したNodeには、必ず Attribute `"flume":{"master":{"serverid":0}}` を設定してください。
serveridは同じ値にならないようにしてください。

##### `FlumeNode` #####

- zookeeper::client
- flume::node


### 各Nodeの設定 ###

各Nodeに、上記で設定したRoleを割り当てていきます。
依存するRoleがある場合には、必ずそのRoleを上位に設定するようにしてください。

Node上で、

    # chef-client

コマンドを実行すると設定が反映されます。


License
-------

Apache License, Version 2.0


Author
------

Takuya UESHIN (ueshin@happy-camper.st) 
