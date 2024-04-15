DESKTOP=0
PYENV=0
NVIM=1
COPY=1
DEBIAN=0

smart_pipe_to() {
	grep -qxF $2 $1 || echo $2 >> $1;
}

for arg in "$@"
do
	if [ "$arg" == "-h" ]; then
		echo "Usage:"
		echo "./script.sh FLAGS"
		echo ""
		echo "Flags possible"
		echo "desktop \t - installs i3 [ don't care to implement yet ]"
		echo "pyenv   \t - installs miniconda to manage linux environment"
		echo "debian  \t - configures debian"
		echo "nonvim  \t - does not install neovim"
		echo "nocopy  \t - does not copy configs"
		exit
	elif [ "$arg" == "desktop" ]; then
		DESKTOP=1
	elif [ "$arg" == "pyenv" ]; then
		PYENV=1
	elif [ "$arg" == "debian" ]; then
		DEBIAN=1
	elif [ "$arg" == "nonvim" ]; then
		NVIM=0
	elif [ "$arg" == "nocopy" ]; then
		COPY=0
	fi
done

install_list="cmake build-essential python3-dev python3-pip npm i3"
localbin=$HOME/.local/bin
mkdir -p "$localbin"
smart_pipe_to $HOME/.bashrc 'export PATH="$PATH:'$localbin'"'

if [ $COPY == 1 ]; then
	cp -r .config/ .fonts/ .local/ ~/
	cp .vimrc ~/
	sudo apt install $install_list
fi

if [ $NVIM == 1 ]; then
	sudo apt purge neovim
	curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o "${localbin}/nvim"
	chmod +x "${localbin}/nvim"
	# pip3 install neovim
	sudo apt install python3-neovim
fi

if [ $PYENV == 1 ]; then
	echo "Installing miniconda"
	wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
	bash https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
fi

if [ $DEBIAN == 1 ]; then
	sudo apt install bash-completion
	smart_pipe_to /etc/bash.bashrc "if [ -f /etc/bash_completion ]; then . /etc/bash_completion ; fi"
fi
