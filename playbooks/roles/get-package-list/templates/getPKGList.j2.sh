# {{ ansible_managed }}
#!/bin/bash

#rpm -qa | sort > /tmp/rpmlist_{{ ansible_host }}.log

list=$(rpm -qa | grep '^{{ getPKGList_target }}' |sort) 

if [ -z ${list} ];then
   echo no package!
   exit 0 
fi

for i in ${list}
do
    min=13
    rpmdev-vercmp ${i} {{ getPKGList_correct_target }} > /dev/null
    if [ $? -lt $min ];then
       min=$?
    fi
done

if [ $min -eq 0 ];then
   echo current!
elif [ $min -eq 11 ];then
   echo new!
else
   echo old!
fi
