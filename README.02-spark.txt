brew install apache-spark scala

##################################################

Linux equivalent:

# how many lines in the file:
wc -l /usr/share/dict/words
  235886 /usr/share/dict/words

# how many times "eric" is present:
grep eric /usr/share/dict/words | wc -l
     559

# longest word:
cat /usr/share/dict/words | awk '{print length, $0}' | sort -nr | head -1
24 thyroparathyroidectomize

##################################################

hdfs dfs -ls input/words

spark-shell
scala> val textFile = sc.textFile("input/words")
scala> textFile.count()
res4: Long = 235886

scala> textFile.filter(line => line.contains("eric")).count()
res5: Long = 559

# longest word:
scala> textFile.map(line => line.size).reduce((a, b) => Math.max(a, b))
res6: Int = 24
