!#bin/sh

# setup editor

# add emacs26 repo bcs 25 has weird key issues
sudo add-apt-repository ppa:kelleyk/emacs

# update repo and install emacs26
sudo apt update

sudo apt install emacs26

# git clone spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# setup dotfiles

# Create alias to ensure that the git bare repository works without problem
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"' >> $HOME/.bashrc
# Reload the shell setting to use that alias.
source ~/.bashrc
# Add .dotfiles.git directory to .gitignore to prevent recursion issues.
echo ".dotfiles.git" >> .gitignore
# Clone the repo.
git clone --bare https://www.github.com/late-night-coffee/dotfiles.git $HOME/.dotfiles.git
# Check if it works fine. If you already have configuration files with identical names, 
# checkout will fail. Back up and remove those files. Delete if unneeded.

#Create backup folder and move offending files there
mkdir -p .dotfiles-backup && \
dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .dotfiles-backup/{}

#checkout
dotfiles checkout
# Prevent untracked files from showing up on dotfiles status.
dotfiles config --local status.showUntrackedFiles no

#change to develop branch of spacemacs
cd ~/.emacs.d/ 
git checkout develop

#ocassionally do a git pull to get the latest updates
git pull
