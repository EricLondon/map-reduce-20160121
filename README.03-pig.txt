brew install pig

export PIG_HOME=/usr/local/Cellar/pig/0.15.0

➜  Sample Data Files-selected  pwd
/Users/eric/Downloads/Sample Data Files-selected
➜  Sample Data Files-selected  ls
all_data_M_2014.xlsx     datathon_maint.csv       datathon_result.csv
datathon_appointment.csv datathon_order.csv       datathon_vitals.csv
datathon_assessment.csv  datathon_patient.csv
datathon_encounter.csv   datathon_problem.csv

# push CSVs to hdfs
$HADOOP_HOME/bin/hdfs dfs -put *.csv /user/eric/input

# view files:
hdfs dfs -ls /user/eric/input

pig
datathon_patient = LOAD 'input/datathon_patient.csv' USING PigStorage(',');
describe datathon_patient;
