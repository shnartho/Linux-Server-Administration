# journalctl -f
kernel: [sdb] 15667200 512-byte logical blocks:
 (8.02 GB/7.47 GiB)
Feb 11 21:55:59 cnegus kernel: sd 7:0:0:0:
 [sdb] Write Protect is off
Feb 11 21:55:59 cnegus kernel: [sdb] Assuming
 drive cache: write through
Feb 11 21:55:59 cnegus kernel: [sdb] Assuming
 drive cache: write through
 
 # PATH="/sbin:$PATH"
# command -v fdisk

# fdisk -c -u -l /dev/sdb

To list partitions on a RHEL 7, RHEL 8, or Fedora system, enter the following:
# fdisk -l /dev/sdb


3. Delete all the partitions on your USB flash drive, save the changes, and make sure the changes were made both on
the disk’s partition table and in the Linux kernel.
To delete partitions on the USB flash drive, assuming device /dev/sdb, do the following:
# fdisk /dev/sdb
Command (m for help): d
Partition number (1-6): 6
Command (m for help): d
Partition number (1-5): 5
Command (m for help): d
Partition number (1-5): 4
Command (m for help): d
Partition number (1-4): 3
Command (m for help): d
Partition number (1-4): 2
Command (m for help): d
Selected partition 1
Command (m for help): w
# partprobe /dev/sdb



To add a 100MB Linux partition, 200MB swap partition, and 500MB LVM partition to the USB flash drive, enter
the following:
# fdisk /dev/sdb
Command (m for help): n
Command action
 e extended
 p primary partition (1-4)
p
Partition number (1-4): 1
First sector (2048-15667199, default 2048): <ENTER>
Last sector, +sectors or +size{K,M,G} (default 15667199): +100M
Command (m for help): n
Command action
 e extended
 p primary partition (1-4)
p
Partition number (1-4): 2
First sector (616448-8342527, default 616448): <ENTER>
Last sector, +sectors or +size{K,M,G} (default 15667199): +200M
Command (m for help): n
3 | P a g e
Command action
 e extended
 p primary partition (1-4)
p
Partition number (1-4): 3
First sector (616448-15667199, default 616448): <ENTER>
Using default value 616448
Last sector, +sectors or +size{K,M,G} (default 15667199): +500M
Command (m for help): t
Partition number (1-4): 2
Hex code (type L to list codes): 82
Changed system type of partition 2 to 82 (Linux swap / Solaris)
Command (m for help): t
Partition number (1-4): 3
Hex code (type L to list codes): 8e
Changed system type of partition 3 to 8e (Linux LVM)
Command (m for help): w
# partprobe /dev/sdb
# grep sdb /proc/partitions
 8 16 7833600 sdb
 8 17 102400 sdb1
 8 18 204800 sdb2
 8 19 512000 sdb3
#ls /dev/sdb*

# dd if=/dev/zero of=/dev/sdb1 bs=512 count=10000
# mkfs -t ext4 -L data /dev/sdb1

# mkdir /mnt/mypart
# mount -t ext4 /dev/sdb1 /mnt/mypart

#su -
# mkswap /dev/sdb2
# swapon /dev/sdb2

# pvcreate /dev/sdb3
# vgcreate abc /dev/sdb3



# lvextend -L +100M /dev/mapper/abc-data
# resize2fs -p /dev/mapper/abc-d


# umount /dev/sdb1
# swapoff /dev/sdb2
# umount /mnt/test
# lvremove /dev/mapper/abc-data
# vgremove abc
# pvremove /dev/sdb3
# lvcreate -n data -L 200M abc
# mkfs -t vfat /dev/mapper/abc-data
# mkdir /mnt/test
# mount /dev/mapper/abc-data /mnt/test
