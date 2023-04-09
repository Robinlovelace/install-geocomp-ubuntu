Create a new group called staff and giving all members of the group read and write, but not execute rights, withse steps:

Create a new group called staff by running the following command:

sudo groupadd staff

Change the ownership of the folder to the root user and the staff group by running the following command:

bash

sudo chown -R root:staff /mnt/diskname/data

Set the permissions of the folder to allow read and write access to the staff group, but not execute access, by running the following command:

bash

sudo chmod -R 660 /mnt/diskname/data

This command sets the permissions of the folder to 660, which means that the owner and members of the staff group can read and write files within the folder, but not execute them.

Add the users that need access to the staff group by running the following command:

css

sudo usermod -a -G staff username

Replace username with the name of the user you want to add to the staff group.

To make these changes permanent, you can add an entry to the /etc/fstab file. Open the file using the following command:

bash

sudo nano /etc/fstab

Add the following line at the end of the file to mount the disk at boot time with the desired permissions:

bash

/dev/<partition> /mnt/diskname/data <filesystem-type> defaults,nofail,uid=0,gid=50,umask=007 0 0

Replace <partition> with the partition name of the disk, <filesystem-type> with the type of the filesystem used, and <uid> and <gid> with the user and group IDs of the default user on the system. The umask=007 option sets the default permissions for new files and folders within the directory to allow read and write access to the owner and members of the staff group, but not execute access.

Save the file and exit the text editor.

To mount the disk with the new permissions, run the following command:

css

    sudo mount -a

    This command will apply the changes made in /etc/fstab without having to reboot.

After following these steps, the folder /mnt/diskname/data should be available with read and write access to the owner and members of the staff group, but not execute access.