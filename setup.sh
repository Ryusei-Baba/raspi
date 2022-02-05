#! /bin/bash

# 必要なパッケージを追加
sudo bash -c 'apt update && apt upgrade -y;
apt install -y language-pack-ja;
apt install -y gnome-terminal uim uim-xim uim-anthy;
apt install -y fonts-ipafont;
apt install -y fonts-ricty-diminished;
apt install -y gedit;
apt install -y build-essential;
apt install -y libglib2.0-bin ;
apt install -y language-pack-gnome-ja;
apt install -y dbus-x11;
'

# .bashrcに設定を追加
grep -q LC_MESSAGES ${HOME}/.bashrc
if [ $? = 1 ]; then
cat << EOF >> ${HOME}/.bashrc
export LC_MESSAGES=ja_JP.UTF-8
export LC_IDENTIFICATION=ja_JP.UTF-8
export LC_COLLATE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export LC_MEASUREMENT=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LC_TIME=ja_JP.UTF-8
export LC_NAME=ja_JP.UTF-8
#
export DISPLAY=localhost:0.0
export XIM=uim
export XMODIFIERS=@im=uim
export UIM_CANDWIN_PROG=uim-candwin-gtk
#export UIM_CANDWIN_PROG=uim-candwin-qt
export GTK_IM_MODULE=uim
export QT_IM_MODULE=uim
export NO_AT_BRIDGE=1
EOF
fi

# .uimに設定を追加
cat << EOF > ${HOME}/.uim
(define default-im-name 'anthy)
(define-key generic-on-key? '("Henkan_Mode" "zenkaku-hankaku" "<Control> " "<Control>\\\\"))
(define-key generic-off-key? '("Muhenkan" "zenkaku-hankaku" "<Control> " "<Control>\\\\"))
(define-key anthy-extend-segment-key? '("<Control>o"))
(define-key anthy-shrink-segment-key? '("<Control>i"))
EOF

# machine-id を設定 
dbus-uuidgen |sudo tee /etc/machine-id
