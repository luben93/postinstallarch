#!/bin/bash
# post install for arch linux + awesome wm desktop, requires git


graphical (){
    #unless grap exists
    yaourt -S --noconfirm xbindkeys spotify google-chrome intellij-idea-ultimate-edition playerctl  \
    lain-git gloobus-preview redshift onboard jdk8-openjdk   \
    lightdm-gtk-greeter lightdm mpc pulseaudio pulseaudio-alsa pulseaudio-ctl screenfetch vlc       \
    transmission-qt
    #touch grap
}

conf (){
    mkdir -P ~/.config
    git clone https://github.com/luben93/awesome-copycats ~/.config/awesome
    ln ~/.config/awesome/rc.lua.powerarrow-darker.luben ~/.config/awesome/rc.lua 
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
    #echo alias open=gloobus-preview ~/.zshrc
    #echo "PROMPT+='%{$fg_bold[blue]%} %D %T % %{$reset_color%}'" >> ~/.zshrc

}

rooted(){
    #unless rooted exists
    chmod +x rooted.sh
    sudo bash -c ./rooted.sh 
    #touch rooted
}

headless (){
    #unless head exists
    yaourt -S --noconfirm dex htop-temperature atop cmatrix cowsay dialog openssh iw curl \
        linux-headers ntfs-3g unzip transmission-cli wpa_supplicant hfsprogs  atop cmatrix cowsay dialog openssh 
    #touch head
}

# TODO laptop, fonts


rooted
headless 
graphical 
#conf # not working
