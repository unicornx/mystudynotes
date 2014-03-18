Robot Building for Teens(http://www.cengageptr.com/Topics/TitleDetail/1133948650)


super_block(http://lxr.free-electrons.com/source/include/linux/fs.h?v=2.6.34#L1319)  

super_operations(http://lxr.free-electrons.com/source/include/linux/fs.h?v=2.6.34#L1558)  

inode
inode_operations

dentry
dentry_operations

file
file_operations

file_system_type -> 描述每种文件系统的功能和行为 <-1---*-> super_block, 每种文件系统 在一个OS系统中可以有多个实例，或者根本就没有安装，
register_filesystem(http://lxr.free-electrons.com/source/fs/filesystems.c?v=2.6.34#L69)
unregister_filesystem(http://lxr.free-electrons.com/source/fs/filesystems.c?v=2.6.34#L102)
内核有一个全局变量链表file_systems(http://lxr.free-electrons.com/source/fs/filesystems.c?v=2.6.34#L32),注册就是加入该链表

vfsmount(http://lxr.free-electrons.com/source/include/linux/mount.h?v=2.6.34#L50) 文件系统实例，一个具体的安装点
vfsmount.mnt_sb(http://lxr.free-electrons.com/source/include/linux/mount.h?v=2.6.34#L55) -->该文件系统的super_block




 

files_struct

fs_struct

mnt_namespace


Linux 文件系统剖析(http://www.ibm.com/developerworks/cn/linux/l-linux-filesystem/) 可以结合代码看看，但没有涉及太多inode和file，进程之间的关系，更多关注了文件系统，挂载和超级块的关系，可以参考。
