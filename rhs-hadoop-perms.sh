#!/bin/sh

# First add the repo, then yum install the components
# yum -y install hadoop hadoop-yarn hadoop-mapreduce hadoop-client openssl
# copy the glusterfs-hadoop plugin to /usr/lib/hadoop/lib
# check that my 2 node gluster mount is working
# Download JDK7, Untar then mkdir /usr/java;ln -s /opt/jdk1.7.0_45/ /usr/java/defaut;ln -s /usr/java/default/bin/java /usr/bin/java
# The RPMs don't put anything in the /etc/hadoop/conf dir. You need to manually create these and copy them in there. They provide examples which I used. Hope it matches Ambari.
# The examples contain MANY ToDOs. They need to be replaced with values. They are - 
# Replace the /etc/hadoop/conf/container-executor.cfg with Brads one
# copy the start-all/stop-all scripts to /usr/lib/hadoop and run them after changing it from yarn-daemon.sh to hadoop-daemon.sh


# Specify the user and group to own the directories
YARN_USER="grid"
MAPRED_USER="grid"
HADOOP_GROUP="hadoop"

# Directory to store the Hadoop configuration files.
HADOOP_CONF_DIR="/etc/hadoop/conf";

# Hadoop Service - YARN 

# Space separated list of directories where YARN will store temporary data. For example, /grid/hadoop/yarn/local /grid1/hadoop/yarn/local /grid2/hadoop/yarn/local
YARN_LOCAL_DIR="/grid/hadoop/yarn/local";

# Directory to store the YARN logs.
YARN_LOG_DIR="/var/log/hadoop/yarn"; 

# Space separated list of directories where YARN will store container log data. For example, /grid/hadoop/yarn/logs /grid1/hadoop/yarn/logs /grid2/hadoop/yarn/logs
YARN_LOCAL_LOG_DIR="/grid/hadoop/yarn/logs";

# Directory to store the YARN process ID.
YARN_PID_DIR="/var/run/hadoop/yarn";

# Hadoop Service - MAPREDUCE

# Directory to store the MapReduce daemon logs.
MAPRED_LOG_DIR="/var/log/hadoop/mapred";

# Directory to store the mapreduce jobhistory process ID.
MAPRED_PID_DIR="/var/run/hadoop/mapred";

export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec

# YARN Temporary Data
mkdir -p $YARN_LOCAL_DIR;
chown -R $YARN_USER:$HADOOP_GROUP $YARN_LOCAL_DIR;
chmod -R 755 $YARN_LOCAL_DIR;

# YARN Container Log Data
mkdir -p $YARN_LOCAL_LOG_DIR;
chown -R $YARN_USER:$HADOOP_GROUP $YARN_LOCAL_LOG_DIR;
chmod -R 755 $YARN_LOCAL_LOG_DIR;

# YARN Log Data
mkdir -p $YARN_LOG_DIR;
chown -R $YARN_USER:$HADOOP_GROUP $YARN_LOG_DIR;
chmod -R 755 $YARN_LOG_DIR;

# YARN PID Dir
mkdir -p $YARN_PID_DIR;
chown -R $YARN_USER:$HADOOP_GROUP $YARN_PID_DIR;
chmod -R 755 $YARN_PID_DIR;

# MapRed Log Dir
mkdir -p $MAPRED_LOG_DIR;
chown -R $MAPRED_USER:$HADOOP_GROUP $MAPRED_LOG_DIR;
chmod -R 755 $MAPRED_LOG_DIR;

# MapRed JobHistoryServer PID Dir
mkdir -p $MAPRED_PID_DIR;
chown -R $MAPRED_USER:$HADOOP_GROUP $MAPRED_PID_DIR;
chmod -R 755 $MAPRED_PID_DIR;

