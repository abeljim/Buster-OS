repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch
#repo --name=updates-testing --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-testing-f$releasever&arch=$basearch
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch

repo --install --name=alunux-budgie-git --baseurl=https://copr-be.cloud.fedoraproject.org/results/alunux/budgie-desktop-git/fedora-$releasever-$basearch/
repo --install --name=antergos-lightdm-webkit2-greeter --baseurl=https://copr-be.cloud.fedoraproject.org/results/antergos/lightdm-webkit2-greeter/fedora-$releasever-$basearch/

repo --name=code --baseurl=https://packages.microsoft.com/yumrepos/vscode --install

# rpm fusion
repo --name=rpmfusion-free-updates --install --metalink=https://mirrors.rpmfusion.org/metalink?repo=free-fedora-updates-released-$releasever&arch=$basearch
repo --name=rpmfusion-free --install --metalink=https://mirrors.rpmfusion.org/metalink?repo=free-fedora-$releasever&arch=$basearch
repo --name=rpmfusion-nonfree-updates --install --metalink=https://mirrors.rpmfusion.org/metalink?repo=nonfree-fedora-updates-released-$releasever&arch=$basearch
repo --name=rpmfusion-nonfree --install --metalink=https://mirrors.rpmfusion.org/metalink?repo=nonfree-fedora-$releasever&arch=$basearch
