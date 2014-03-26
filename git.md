如何解决在家访问github很慢的方法:  
http://ruby-china.org/topics/17374  
我用了加一下hosts文件的方法，C:\WINDOWS\system32\drivers\etc\hosts  
  
    185.31.17.184 github.global.ssl.fastly.net

Gerrit commands: 

-------- 
    git checkout -b <branch-name> 
    git-add <file-to-add> 
 
 


How to roll back remote branch to a specific commit:  
  
    git checkout branch  
    git reset --hard commiid // roll back local branch to specific commit  
    git push origin branch -f // sync remote brnach to local branch, done!



---- 
    git push origin master # 提取我的master分支 并更新到远程仓库的master分支
    git push origin serverfix # 提取我的serverfix分支 并更新到远程仓库的serverfix分支  
    git push origin serverfix:remoteserverfix # 提取我的 serverfix分支 并更新到远程仓库的remoteserverfix分支 
    git push origin :serverfix # 删除远程分支 serverfix（在这里提取空白然后把它变成[远程分支]） 
 
------------------------------------------------------------------------- 
Windows GIT msysgit 
How to remove troubling "Local uncommitted changes, ...." 
There are sevearal reasons may cause this: 
1) file mode check "old mode 100755 new mode 100644" 
It's due to we clone the repo from UNIX and defaultly admin will set the filemode to true for evey repo 
After we copy them from unix machine to Windows machine, due to "old mode 100755 new mode 100644" problem, Git on Windows will report this change though we didn't change anything. 
To avoid this, "git config --add core.filemode false" 
2)  
 
 
 
 
git-add 
git-rm 
git-mv 
 
 
git-commit 
git 
compare: 
git status: show the all the status (index-current HEAD commit; working tree-index; working tree not tracked by git) 
git diff: diff working tree against index 
git diff --cached: diff index against local repro (latest commit) 
git diff HEAD: diff working tree against latest commit 
git log: show commit log 
 
 
git checkout -b branchname tag 
 
 
 
 
    git reset –-hard HEAD //–hard表示将working tree和index file都撤销到merge以前状态 
 
 
 
 
push and delete remote branches 
This is an action that many Git users need to do frequently, but many (including the author) have forgotten how to do so or simply don’t know how. Here’s the definitive guide if you’ve forgotten. 
So let’s say you have checked out a new branch, committed some awesome changes, but now you need to share this branch though with another developer. You can push the branch up to a remote very simply: 
git push origin newfeature 
Where origin is your remote name and newfeature is the name of the branch you want to push up.  
This is by far the easiest way, but there’s another way if you want a different option.  
Geoff Lane has created a great tutorial which goes over how to push a ref to a remote repository, fetch any updates, and then start tracking the branch. 
Deleting is also a pretty simple task (despite it feeling a bit kludgy): 
git push origin :newfeature 
That will delete the newfeature branch on the origin remote, but you’ll still need to delete the branch locally with git branch -d newfeature. 
There’s a script called git-publish-branch created by William Morgan that can easily automate this process if you find yourself performing these actions frequently. It also makes deleting remote branches feel a bit more natural. Know of better or easier ways to do the above tasks? Let us know in the comments or submit your own tip! 
 
 
 
 
 
 
 
 
git-checkout -b <branch_name> #create and checkout to the branch 
git-branch -D <branch_name> # delete a local branch ANYWAY 
git-commit -m <comment> 
 
 
git-checkout master 
git-merge <branch> 
git push origin master 
 
 
How to ignore some files in GIT repo:============================================================= 
If you want to ignore certain files when checking in, add them in .ignore file. I attached it here. This file ignores .obj, .pch, etc. 
 
 
If it is already indexed your ignore file won't work. You need to call git rm first to remove the files from index: 
git rm --cached *.plg, 
git rm --cached *.obj 
git rm --cached *.sbr 
etc to remove from index.  
 
 
After doing that, .ignore file should work. git status will not display the ignored files. 
 
 
How to tag: 
create remote tag: 
git tag -m "<comments>" <tag-name> 
git push origin <tag-name> 
 
 
