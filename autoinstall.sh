#!/bin/bash
# post install for arch linux + awesome wm desktop, requires git


graphical (){
    yay -S --noconfirm spotify firefox intellij-idea-community-edition  \
    gloobus-preview redshift onboard  cool-retro-term gendesk xclip playerctl light-locker lightdm-gtk-greeter lightdm \
    pulseaudio pulseaudio-alsa pulseaudio-ctl screenfetch vlc transmission-qt alsa-utils pavucontrol nitrogen \
    thunderbird arandr lastpass qemu libvirt ovmf virt-manager arandr slack-desktop darktable gdb calibre eog #evince-no-gnome
    touch grap  
}

gnome (){
    yay -S --noconfirm gnome-shell-extension-pixel-saver gnome gnome-shell-extension-audio-output-switcher-git gnome-tweak-tool
    #tweaktools and activate
    # set mouse to lazy switching
    gsettings set org.gnome.desktop.lockdown disable-lock-screen true #in gnome 

}

sway (){
    yay -S --noconfirm sway swaybg swayidle swaylock-blur j4-dmenu-desktop i3status-rust-git
    touch sway
}

conf (){
    touch confed

    mkdir -P ~/.config
    git clone --recursive https://github.com/copycat-killer/awesome-copycats.git ~/.config/awesome
    mv rc.lua ~/.config/awesome/rc.lua
    # git clone https://github.com/luben93/awesome-copycats ~/.config/awesome
    # ln ~/.config/awesome/rc.lua.powerarrow-darker.luben ~/.config/awesome/rc.lua 
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo " set-option -g mouse on
    set -g @continuum-restore 'on'
    
    # List of plugins
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'
    set -g @plugin 'nhdaly/tmux-scroll-copy-mode'
    set -g @plugin 'tmux-plugins/tmux-resurrect'
    set -g @plugin 'tmux-plugins/tmux-continuum'
    
    run '~/.tmux/plugins/tpm/tpm'" >> ~/.tmux.conf 
    ~/.tmux/plugins/tpm/bindings/install_plugins 

    curl http://j.mp/spf13-vim3 -L -o - | sh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
    echo "alias open=gloobus-preview" >> ~/.zshrc
    echo 'alias lock="light-locker-command -l"' >> ~/.zshrc
    echo "PROMPT+='%{\$fg_bold[blue]%} %T % %{\$reset_color%}'" >> ~/.zshrc
    #echo "greeter-session=lightdm-gtk-greeter" >> /etc/lightdm/lightdm.conf # not tested
    git clone git@github.com:wertarbyte/autorandr.git
    cp autorandr/autorandr /bin/autorandr
    cp -r .config ~/.config
}

enable(){
    #systemctl enable lightdm
    systemctl enable docker
    systemctl enable fstrim.timer
    touch enabled
}

autostart(){
    gendesk --pkgname thunderbird 
    #gendesk --pkgname spotify 
    gendesk --pkgname slack-desktop
    #gendesk --pkgname google-chrome-stable 
    #nitrogen --restore
    #xscreensaver -no-splash
    #Exec=sh /home/luben/.screenlayout/default.sh #(save with arandr)
    touch started
}

rooted(){
        chmod +x rooted.sh
        sudo bash -c ./rooted.sh 
        touch rooted
}

headless (){
    yaourt -S --noconfirm dex htop-temperature atop cmatrix cowsay dialog openssh iw curl docker docker-compose vim-fakeclip \
    linux-headers ntfs-3g unzip transmission-cli wpa_supplicant hfsprogs  atop cmatrix cowsay dialog openssh jdk8-openjdk
    touch head
}

# TODO laptop, fonts

if [ ! -e rooted ] ; then 
    rooted ; fi
if [ ! -e head ] ; then 
    headless ; fi
if [ ! -e grap ] ; then 
    graphical ; fi
if [ ! -e confed ] ; then 
    conf ; fi
#if [ ! -e enabled ] ; then 
  # sudo enable ;  fi
#if [ ! -e started ] ; then 
  #  autostart ;  fi
if [ ! -e sway ] ; then
    sway ; fi

