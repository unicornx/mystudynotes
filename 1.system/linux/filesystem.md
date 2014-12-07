[super_block](http://lxr.free-electrons.com/source/include/linux/fs.h?v=2.6.34#L1319)  

[super_operations](http://lxr.free-electrons.com/source/include/linux/fs.h?v=2.6.34#L1558)  

inode
inode_operations
[理解inode](http://www.ruanyifeng.com/blog/2011/12/inode.html):不错，浅显易懂  
[Linux那些事儿之我是Sysfs(7)dentry与inode](http://blog.csdn.net/fudan_abc/article/details/1775313): 有个图还不错  

dentry
dentry_operations

file
file_operations

file_system_type -> 描述每种文件系统的功能和行为 <-1---*-> super_block, 每种文件系统 在一个OS系统中可以有多个实例，或者根本就没有安装，  
[register_filesystem](http://lxr.free-electrons.com/source/fs/filesystems.c?v=2.6.34#L69)  
[unregister_filesystem](http://lxr.free-electrons.com/source/fs/filesystems.c?v=2.6.34#L102)  
内核有一个全局变量链表file_systems(http://lxr.free-electrons.com/source/fs/filesystems.c?v=2.6.34#L32),注册就是加入该链表

[vfsmount](http://lxr.free-electrons.com/source/include/linux/mount.h?v=2.6.34#L50) 文件系统实例，一个具体的安装点  
[vfsmount.mnt_sb](http://lxr.free-electrons.com/source/include/linux/mount.h?v=2.6.34#L55) -->该文件系统的super_block  



[task_struct](http://lxr.free-electrons.com/source/include/linux/sched.h?v=2.6.34#L1169) {
    ...  
    /* filesystem information */  
    struct [fs_struct](http://lxr.free-electrons.com/source/include/linux/fs_struct.h?v=2.6.34#L6) *fs;  
    /* open file information */  
    struct [files_struct](http://lxr.free-electrons.com/source/include/linux/fdtable.h?v=2.6.34#L43) *files;  
    ...  
};  

files_struct

fs_struct

mnt_namespace


process 1--* vfsmount: a process contains a list of vfs mounted  
vfsmount 1--1 super_block: a vfs has one super_block  
super_block 1--* inode: a super_block manage a list of inodes  

process 1--1 fs_struct:  
        1--* files_struct:  
files_struct 1--* file: a process maintain a list of opend file descripter  

![process-fs-files](http://p.blog.csdn.net/images/p_blog_csdn_net/fudan_abc/fs.jpg)  

file 1--* dentry 1--1 inode  
file.f_path: a list of dentry which represent a while path such as /a/b/c, a, b and c are 3 dentry constructing a whole path  
every dentry entity points to a actual inode entiry  
![inode & dentry](http://hi.csdn.net/attachment/201012/6/0_1291637767J6uo.gif)
for exampple, if one FILE has two hard links(alias, e.g. "/filename1", "/filename2"), there should be one inode represent this FILE rawdata. When a process open this FILE by the two aliases like below:  
open("/filename1", rw)  
open("/filename2", rw)  

then this process should contains two "file" instances, file1 & file2  
file1.f_path contains two dentry entities: "/" & "filename1"  
file1.f_path contains two dentry entities: "/" & "filename2"  
"filename1" & "filename2" both point to the FILE inode  

[Linux 文件系统剖析](http://www.ibm.com/developerworks/cn/linux/l-linux-filesystem/)   可以结合代码看看，但没有涉及太多inode和file，进程之间的关系，更多关注了文件系统，挂载和超级块的关系，可以参考。  

[解析 Linux 中的 VFS 文件系统机制](http://www.ibm.com/developerworks/cn/linux/l-vfs/)  
更多使用rootfs来解释VFS  



[Robot Building for Teens](http://www.cengageptr.com/Topics/TitleDetail/1133948650)  

