CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

#set -e

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -e "ListExamples.java" ]]
    then 
        echo "ListExamples found"
    else 
        echo "ListExamples not found"
        exit 
fi 

cd .. 
cp student-submission/ListExamples.java .
#javac -cp 
javac -cp $CPATH *.java
javac ListExamples.java 

if [[ -e "ListExamples.class" ]]
    then 
        echo "ListExamples compiled" 
    else 
        echo "ListExamples didn't compile"
        exit 
fi 

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > output.txt

grep "Failures:" output.txt > grep.txt 
cat grep.txt 
#echo | tail -c 3
awk '{ print $NF }' grep.txt #NF is the number of files in the line. $NF is the value in the last field/column
# echo grep "Failures:" output.txt | tail -3