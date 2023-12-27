set -e

# Install Vscode.
sudo apt-get install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# Install Neovim.
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim

sudo apt-get install -y python3-dev python3-pip

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --set vi /usr/bin/nvim
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --set vim /usr/bin/nvim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --set editor /usr/bin/nvim

# Install NodeJS
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Install CFW
curl https://archive.org/download/clash_for_windows_pkg/Clash.for.Windows-0.20.39-x64-linux.tar.gz | tar -xz
mv Clash\ for\ Windows-*-x64-linux/ cfw
# sudo rm -rf /etc/cfw
# sudo rm /usr/local/bin/cfw
sudo mv cfw /etc/cfw
sudo ln -s /etc/cfw/cfw /usr/local/bin/cfw

sudo apt autoremove -y

# Use apt mirror
UBUNTU_DISTRO=$(lsb_release -cs)
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ ${UBUNTU_DISTRO} main restricted universe multiverse" > /etc/apt/sources.list
sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ ${UBUNTU_DISTRO}-updates main restricted universe multiverse" >> /etc/apt/sources.list
sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ ${UBUNTU_DISTRO}-backports main restricted universe multiverse" >> /etc/apt/sources.list
sudo echo "deb http://security.ubuntu.com/ubuntu/ ${UBUNTU_DISTRO}-security main restricted universe multiverse" >> /etc/apt/sources.list

# Use pip mirror
python3 -m pip install --upgrade pip
python3 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
