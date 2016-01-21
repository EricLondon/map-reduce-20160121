whoami
eric

java -version
java version "1.8.0_66"
Java(TM) SE Runtime Environment (build 1.8.0_66-b17)
Java HotSpot(TM) 64-Bit Server VM (build 25.66-b17, mixed mode)

brew install hadoop

# ~/.profile:
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
# /Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home
export HADOOP_HOME=/usr/local/Cellar/hadoop/2.7.1
export HADOOP_CONF_DIR=$HADOOP_HOME/libexec/etc/hadoop

$HADOOP_HOME/bin/hdfs namenode -format
$HADOOP_HOME/sbin/start-all.sh
jps

$HADOOP_HOME/bin/hdfs dfs -mkdir /user
$HADOOP_HOME/bin/hdfs dfs -mkdir /user/eric
$HADOOP_HOME/bin/hdfs dfs -mkdir /user/eric/input

$HADOOP_HOME/bin/hdfs dfs -put /usr/share/dict/words /user/eric/input
$HADOOP_HOME/bin/hadoop dfs -ls /user/eric/input
$HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/libexec/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar grep input output 'eric'
$HADOOP_HOME/bin/hadoop dfs -ls /user/eric/output

hdfs dfs -cat output/part-r-00000
559 eric

##################################################

cat /usr/share/dict/words | bin/main.rb --map | sort | bin/main.rb --reduce
a 199554
b 40433
c 103440
d 68191
e 235331
f 24165
g 47094
h 64356
i 201032
j 3167
k 16158
l 130463
m 70680
n 158743
o 170692
p 78163
q 3734
r 160985
s 139542
t 152831
u 87353
v 20177
w 13864
x 6932
y 51681
z 8460

##################################################

# trying above on local hadoop:

# clean up output dir
hdfs dfs -ls output
hdfs dfs -rmr output

hadoop jar $HADOOP_HOME/libexec/share/hadoop/tools/lib/hadoop-streaming-2.7.1.jar -mapper 'bin/main.rb --map' -reducer 'bin/main.rb --reduce' -input input -output output

hdfs dfs -cat output/part-00000
a 199554
b 40433
c 103440
d 68191
e 235331
f 24165
g 47094
h 64356
i 201032
j 3167
k 16158
l 130463
m 70680
n 158743
o 170692
p 78163
q 3734
r 160985
s 139542
t 152831
u 87353
v 20177
w 13864
x 6932
y 51681
z 8460
