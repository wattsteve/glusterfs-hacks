Multi-User setup instructions for Hortonworks RPM installation on GlusterFS
===============

0) Setup your RHS Volume

# Install RHS 2.1.1 on two nodes, run rhs-hadoop-install to configure your gluster volume. Run "mount" on both nodes to verify the volume is mounted and working.
# Make sure the mount includes acls, i.e. in /etc/fstab : localhost:/HadoopVol /mnt/glusterfs glusterfs acl,auto,transport=tcp 0 0
# Make sure the sudoers.d/20_gluster exists

1) Install the RPMs from Hortonworks

# add the repo:  wget -nv http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.0.6.0/hdp.repo -O /etc/yum.repos.d/hdp.repo  
# yum install the components:  yum -y install hadoop hadoop-yarn hadoop-mapreduce hadoop-client openssl
# copy the glusterfs-hadoop plugin to /usr/lib/hadoop/lib

# Download JDK7, Untar then: mkdir /usr/java;ln -s /opt/jdk1.7.0_45/ /usr/java/defaut;ln -s /usr/java/default/bin/java /usr/bin/java
# The RPMs don't put anything in the /etc/hadoop/conf dir. You need to manually create these and copy them in there. They provide examples which I used. Get these from my GIT repo.
# My conf is already setup to use the "grid" user as the yarn daemon and already has an edited container executor
# copy the start-all/stop-all scripts in GIT to /usr/lib/hadoop (not mandatory, but saves time)

2) Setup the YARN Daemon
  
  create a "hadoop" group : groupadd -g 500 hadoop
  create a new "grid" user: adduser --no-create-home --system --uid 1000 --gid 500 grid

3) Setup the Directories and the Permissions:

# Run rhs-setup-perms.sh
# Run post_install_dirs.sh
# chown -R root:hadoop /etc/hadoop

5) Add a new user:

# Create user dave, add him to hadoop group
# Add dave to the sudoers.d/20_gluster file
# Add dave to the container-executor.cfg whitelist
# Run test-container-executor as dave to verify the container-executor is working properly

6) Start Hadoop under the "grid" user:
# su grid
# start Hadoop by running "./start-all.sh" (from my git repo)

7) Test with the new user:
# su dave
# /usr/lib/hadoop/bin/hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples-2*.jar teragen 100 in-dir

FAILURES?
 
Dont forget to change the following properties:

# The value used to be org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor
<property>
<name>yarn.nodemanager.container-executor.class</name>
<value>org.apache.hadoop.yarn.server.nodemanager.LinuxContainerExecutor</value>
</property>

<property>
 <name>gluster.daemon.user</name>
 <value>grid</value>
</property>

