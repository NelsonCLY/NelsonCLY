# ipmitool fru strsss 43200 sec (12Hours)
test_fail=0
start_time=$(date +%s)
ipmitool -I lanplus -H $1 -U root -P root fru list > fru_read.txt  
for (( i=0 ; $[$(date +%s)-$start_time] < 43200; i++ ))
	do
        echo -e "Test Loop $i.\r\c" 
		ipmitool -I lanplus -H $1 -U root -P root fru list > fru_read_new.txt 
        if [ "`diff fru_read.txt fru_read_new.txt`" != "" ]; then 
                test_fail=$($test_fail+1)
                cat fru_read_new.txt | tee fru_read_$i.txt
        fi
	done
if [ "$test_fail" -eq "0" ]; then 
	echo All test is PASS and Total Test Case : $i     
else 
	echo Total Test Case : $i  Total FAIL Test Case : $test_fail
fi
echo end test `date`

