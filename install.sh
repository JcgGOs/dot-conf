DIR=$(realpath .)
echo "install path:$DIR"
install_ohmyzsh(){
	echo "install zsh"
    backup ~/.oh-my-zsh/custom
	ln -s $DIR/oh-my-zsh/ ~/.oh-my-zsh/custom
}

install_tmux(){
	echo "install tmux"
    backup ~/.tmux.conf
	ln -s $DIR/tmux/tmux.conf ~/.tmux.conf
}

install_zshrc(){
	echo "install zshrc"
    backup ~/.zshrc
	ln -s $DIR/zsh/zshrc ~/.zshrc
}

install_vim(){
	echo "install vim"
    backup ~/.vim
	ln -s $DIR/vim ~/.vim
}

backup(){
    # soft link
    if [ -h "$1" ]; then
        rm "$1"
    fi
    # file
    if [ -e "$1" ]; then
        echo "backup file/folder to $1_$(date '+%Y%m%d')"
        mv "$1" "$1_$(date '+%Y%m%d')"
    fi
}

if [ -d "~/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	install_ohmyzsh
	else
	install_ohmyzsh		
fi
install_zshrc
install_tmux
install_vim
