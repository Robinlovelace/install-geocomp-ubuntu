
To move the home directory to a hard disk mounted on /mnt in Ubuntu, you can follow these steps:

Boot into Ubuntu as the root user or with root privileges.

Create a new directory on the mounted hard disk using the following command:

```bash
sudo mkdir /mnt/newhome
```

Copy the contents of the current home directory to the new directory using the following command:

```bash
sudo rsync -avx /home/ /mnt/newhome/
```

The -a option preserves the file permissions, ownership, and timestamps, while the -v option shows the progress of the copy process, and the -x option ensures that the copy process does not cross file system boundaries.

Rename the original home directory to a different name using the following command:

```bash
sudo mv /home /old_home
```

Create a new empty home directory using the following command:

```
sudo mkdir /home
```

Mount the new home directory on the hard disk using the following command:

```bash
sudo mount /dev/<your hard disk partition> /home
```

Replace <your hard disk partition> with the actual partition name of the hard disk where you want to move your home directory.

Add an entry to the /etc/fstab file to ensure that the new home directory is mounted automatically at boot time. Edit the file using the following command:

```bash
sudo nano /etc/fstab
```

Add the following line at the end of the file:

```bash
/dev/<your hard disk partition> /home ext4 defaults 0 2
```

Again, replace <your hard disk partition> with the actual partition name of the hard disk where you want to move your home directory.

Reboot the system for the changes to take effect.

After the reboot, your home directory should be mounted on the hard disk mounted on /mnt.