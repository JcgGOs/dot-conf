DIR=$(realpath .)
echo " DIR:$DIR"

declare -a all_components
all_components=(
    ohmyzsh
    tmux
    zshrc
    vim
)
install(){
    case $1 in 
        all)
            for comp in $all_components; do
                install $comp
            done
            ;;
        ohmyzsh)
            if [ -d "~/.oh-my-zsh" ]; then
                sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
            fi
            ;;
        tmux)
           get $1 
            ;;
        *)
            echo "install soft:$1"
            ;;
    esac

}

get(){
    NAME=$(uname)
    case $NAME in 
        Darwin)
            brew install $1
            ;;
        Linux)
            NAME=$(lsb_release -i -s)
            case $NAME in
                CentOS)
                    yum install $1
                    ;;
                Ubuntu)
                    apt install $1
                    ;;
                Debian)
                    apt install $1
                    ;;
                *)
                    echo "OS:$name"
                    ;;
            esac
            ;;
        *)
            echo "get software:$1"
            ;;
    esac
}

link(){
    case $1 in
        all)
            for comp in $all_components; do
                link $comp
            done
            ;;
        ohmyzsh)
            install $1
            backup ~/.oh-my-zsh/custom
            ln -s $DIR/oh-my-zsh/ ~/.oh-my-zsh/custom
            ;;
        tmux)
            backup ~/.tmux.conf
            ln -s $DIR/tmux/tmux.conf ~/tmux.conf
            ;;
        zshrc)
            backup ~/.zshrc
            ln -s $DIR/zsh/zshrc ~/.zshrc
            ;;
        *)
            echo "backup ~/.$1"
            backup ~/.$1
            echo "ln -s $DIR/$1 ~/.$1"
            ln -s $DIR/$1 ~/.$1
            ;;
    esac
}

clean(){
    case $1 in
        all)
            for comp in $all_components; do
                clean $comp
            done
            ;;
        ohmyzsh)
            rm -rf ~/.oh-my-zsh
            ;;
        tmux)
            rm -rf ~/.tmux.conf
            ;;
        zshrc)
            rm -rf  ~/.zshrc
            ;;
        *)
            rm -rf ~/.$1
            ;;
    esac
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

help(){
    echo "./ctl.sh install all"    
    echo "./ctl.sh install vim"    
}
echo "$1 $2"
case $1 in 
    link)
        link $2
        ;;
     get)
        get $2
        ;;
    clean)
        clean $2
        ;;
    *)
        help
        ;;
esac
