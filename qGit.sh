#!/bin/bash
# -----------------------------------------------
#This is a little application for interacting with GIT and Github
#via the shell.
#If you are not working on a machine where you want to work with eclipse
#or if you simply need to do some scripting on a server, this might be
#the solution that can make your work a bit more easy
#
#Start this in another shell, and interact when you need to change or do #stuff
# -----------------------------------------------





while :
do
 clear
 echo "************ ConfiGit ************"
 echo ""
 echo "0. Commit Changes to your Project"
 echo "1. Add file to Git(staging area)"
 echo "2. Push changes to Master repo"
 echo "3. Initialize new Github Project"
 echo "4. Initialize existing Github Project"
 echo "5. Setup Git & configure Github"
 echo "6. Important!  Please read"
 echo "7. Exit"
 echo -n "Please enter option [1 - 7]:"
 read opt

 case $opt in
  0) echo "************ Commit Changes to your Project *************";
     echo -n "Name of repository:";
     read RepoName;
     echo -n "Commit comment:";
     read comment;
     (cd $RepoName/ && git commit -m \'$comment\' );;

  1) echo "************ Add file *************";
     echo -n "Name of repository:";
     read RepoName;
     echo -n "Filename:";
     read filename;
     (cd $RepoName/ && git add $filename);;

  2) echo "************ Pushing changes to master repo*************";
     echo -n "Name of repository:";
     read RepoName;
     (cd $RepoName/ && git push -u origin master);
     echo "Press [enter] key to continue. . .";
     read enterKey;;


  3) echo "************ Initialize new GitHub Project *************";
     echo "Please go to GitHub and create a new repository first!(include a Readme.md)"
     echo -n "New repository name:";
     read RepoName;
     echo -n "GitHub Username, Case sensitive!:";
     read Username;
     mkdir $RepoName;
     (cd $RepoName/ && git init);
     (cd $RepoName/ && git add $filename);
     (cd $RepoName/ && git remote add origin git@github.com:$Username/$RepoName.git);
     (cd $RepoName/ && git pull origin master);
     echo "New repository Initialized";
     echo "Press [enter] key to continue. . .";
     read enterKey;;


  4) echo "************ Initialize existing Github Project *************";  
     echo -n "Name of repository:";
     read RepoName;
     echo -n "GitHub Username, Case sensitive!:";
     read Username;
     mkdir $RepoName;
     (cd $RepoName/ && git init);
     (cd $RepoName/ && git add $filename);
     (cd $RepoName/ && git remote add origin git@github.com:$Username/$RepoName.git);
     (cd $RepoName/ && git pull origin master);
     echo "Existing repository Initialized";
     echo "Press [enter] key to continue. . .";
     read enterKey;;


  5) echo "************ Setup Git & configure Github *************";
     echo "You are in $(pwd) directory";   
     echo "Press [enter] key to continue. . .";
     read enterKey;;	


  6) echo "************ IMPORTANT *************";
     echo "Please put this file in the directory where you have all your GitHub Projects";
     echo "";
     echo "--->Project-Directory\\ConfiGit.sh";
     echo "--->Project-Directory\\Project1\\";
     echo "--->Project-Directory\\Project2\\";
     echo "--->Project-Directory\\Project3\\";
     echo "";
     echo "";
     echo "";
     echo "Press [enter] key to continue. . .";
     read enterKey;;


  7) echo "Bye $USER";
     exit 1;;
  *) echo "$opt is an invaild option. Please select option between 1-6 only";
     echo "Press [enter] key to continue. . .";
     read enterKey;;
esac
done
