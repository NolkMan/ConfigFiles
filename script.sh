DESKTOP=0
PYENV=0
NVIM=1

for arg in "$@"
do
	if [ "$arg" == "-h" ]; then
		echo "Usage:"
		echo "./script.sh [desktop] [pyenv] [nonvim]"
		echo ""
		echo "desktop \t - installs i3 [ don't care to implement yet ]"
		echo "pyenv   \t - installs miniconda to manage linux environment"
		echo "nonvim  \t - does not install neovim"
		exit
	elif [ "$arg" == "desktop" ]; then
		DESKTOP=1
	elif [ "$arg" == "pyenv" ]; then
		PYENV=1
	elif [ "$arg" == "nonvim" ]; then
		NVIM=0
	fi
done

install_list="cmake build-essential python3-dev npm i3"

cp -r .config/ .fonts/ .local/ ~/
cp .vimrc ~/
sudo apt install $install_list

localbin=$HOME/.local/bin
mkdir -r "$localbin"
echo '' >> $HOME/.bashrc
echo 'export PATH="$PATH:'$localbin >> $HOME/.bashrc

if [ $NVIM == 1 ]; then
	sudo apt purge neovim
	curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o "${localbin}/nvim"
	pip3 install neovim
fi

if [ $PYENV == 1 ]; then
	echo "Installing miniconda"
	wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
	bash https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
fi
