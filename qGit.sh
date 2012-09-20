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
gitCheck()
{
	command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it's not installed. .";
	     while :
		do
		clear
		echo "would you like to install Git ?";
		echo -n "Press 1 for Yes, 2 for NO:";
		read InstallGit
			case $InstallGit in
			1) 	sudo apt-get install git; 
				clear;
				break;;
			2)
				echo "You gotta install Git, if you dont want me to do it, well do it your self :)"
				exit 1;;
		esac
		done
	}
}



while :
do
 clear
 echo "********** ConfiGit **********"
 echo "         welcome $USER"
 echo ""
 echo "0. Commit Changes to your Project"
 echo "1. Add file to Git(staging area)"
 echo "2. Push changes to Master repo"
 echo "3. Initialize new Github Project"
 echo "4. Initialize existing Github Project"
 echo "5. Configure Git / Github and misc"
 echo "6. Important!  Please read"
 echo "7. Exit"
 echo -n "Please enter option [0 - 7]:"
 read opt

 case $opt in
  0) echo "************ Commit Changes to your Project *************";
	gitCheck;
     echo -n "Name of repository:";
     read RepoName;
     echo -n "Commit comment:";
     read comment;
     (cd $RepoName/ && git commit -m "$comment" );;

  1) echo "************ Add file *************";
	gitCheck;
     echo -n "Name of repository:";
     read RepoName;
     echo -n "Filename:";
     read filename;

     while :
	do
	clear
	echo "would you like to also create the file?";
	echo -n "Press 1 for NO, 2 for yes:"
	read createfileQ
		case $createfileQ in
		1)(cd $RepoName/ && git add $filename);
		 break;;
		2)(cd $RepoName/ && touch $filename);
		(cd $RepoName/ && git add $filename);
		break;;
	esac
	done;;
  2) echo "************ Pushing changes to master repo*************";
	gitCheck;
     echo -n "Name of repository:";
     read RepoName;
     (cd $RepoName/ && git push -u origin master);
     echo "Press [enter] key to continue. . .";
     read enterKey;;


  3) echo "************ Initialize new GitHub Project *************";
	gitCheck;
     echo "Please go to GitHub and create a new repository first!(include a Readme.md)"
     echo -n "New repository name:";
     read RepoName;
     echo -n "GitHub Username, Case sensitive!:";
     read Username;
     echo -n "Email Github commits[public project email]:";
     read Email;

     mkdir $RepoName;
     (cd $RepoName/ && git init);
     (cd $RepoName/ && git add $filename);
     (cd $RepoName/ && git remote add origin git@github.com:$Username/$RepoName.git);
     (cd $RepoName/ && git config --global user.email "$Email");
     (cd $RepoName/ && git pull origin master);
     echo "New repository Initialized";
     echo "Press [enter] key to continue. . .";
     read enterKey;;


  4) echo "************ Initialize existing Github Project *************";
	gitCheck;
     echo -n "Name of repository:";
     read RepoName;
     echo -n "GitHub Username, Case sensitive!:";
     read Username;
     echo -n "Email Github commits[public project email]:";
     read Email;

     mkdir $RepoName;
     (cd $RepoName/ && git init);
     (cd $RepoName/ && git add $filename);
     (cd $RepoName/ && git remote add origin git@github.com:$Username/$RepoName.git);
     (cd $RepoName/ && git config --global user.email "$Email");
     (cd $RepoName/ && git pull origin master);
     echo "Existing repository Initialized";
     echo "Press [enter] key to continue. . .";
     read enterKey;;



  5) echo "************ Setup Git & configure Github *************";
	gitCheck;
	echo "hello and welcome to the configuration thingy guide stuff thing";
	     while :
		do
		clear;

		if [ -f ~/.ssh/id_rsa.pub ]
		then
    			echo "Press 1 if you would like to use your current rsa_id key.";
			echo "Press 2 if you would like to generate new keys.";
			echo "Press 3 to exit";
			echo -n "Press 1 for Yes, 2 for NO:";
		else
			echo "It seems like you dont have any id_rsa.pub in ~/.ssh/";
			echo "";
			echo -n "Press 2 if you would like to generate new keys, press 3 to exit:";
		fi

		
		read rsa_choice

			case $rsa_choice in
			1) 	
				echo "This is your Key, please copy paste it to your github account now!"
				echo "";
				cat ~/.ssh/id_rsa.pub;
				echo "";
				echo "The key can now be posted on https://github.com/settings/ssh";
				echo "";

				echo -n "Press enter when you have posted the key to github:";
				read enterKey;
				echo "";

				echo "Lets connect to gitssh and see if you have access";
				echo "When asked if you wanna continue, write yes and press Enter";
				ssh -T git@github.com;

				echo "If you where successfully authenticated, well yay for you.  If not..uhmmm bad luck";
				echo "Press [enter] key to continue. . .";

     				read enterKey;
				break;;

			2)
				if [ -d ~/.ssh ]
				then
					echo "I will now make a backup of your current keys.";
					echo "they will be located in in ~/.ssh/id_rsa_backup/";
					mkdir ~/.ssh/backup_id_rsa;
					cp ~/.ssh/id_rsa* ~/.ssh/backup_id_rsa/;
					rm ~/.ssh/id_rsa*;
				fi

				echo "";
				echo "We will now generate your new keys";
				echo -n "What email have you associated with your github?:";
				read Email;

				echo "Thanks.  we will now generate your the Password less ssh keys.";
				echo "When asked for password, please just press \"Enter\"";
				ssh-keygen -t rsa -C "$Email";
				echo "";
				
				echo "This is your Key, please copy paste it to your github account now!"
				echo "";
				cat ~/.ssh/id_rsa.pub;
				echo "";
				echo "The key can now be posted on https://github.com/settings/ssh";
				echo "";

				echo -n "Press enter when you have posted the key to github:";
				read enterKey;
				echo "";

				echo "Lets connect to gitssh and see if you have access";
				echo "When asked if you wanna continue, write yes and press Enter";
				ssh -T git@github.com;

				echo "If you where successfully authenticated, well yay for you.  If not..uhmmm bad luck";
				echo "Press [enter] key to continue. . .";

     				read enterKey;
				break;;

			3)
				break;;

				
		esac
		done;;


  6) echo "************ IMPORTANT *************";
     echo "Hey $USER"
     echo "Please put this file in the directory where you have all your GitHub Projects";
     echo "";
     echo "--->Project-Directory\\ConfiGit.sh";
     echo "--->Project-Directory\\Project1\\";
     echo "--->Project-Directory\\Project2\\";
     echo "--->Project-Directory\\Project3\\";
     echo "";
     echo "Now, ";
     echo "";
     echo "Press [enter] key to continue. . .";
     read enterKey;;


  7) echo "Bye $USER";
     exit 1;;
  *) echo "$opt is an invaild option. Please select option between 0-7 only";
     echo "Press [enter] key to continue. . .";
     read enterKey;;
esac
done
