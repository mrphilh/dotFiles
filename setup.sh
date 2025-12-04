# Install system dependecies
sudo pacman -S --noconfirm tmux waybar
# Install Dependencies for neovim
sudo pacman -S  --noconfirm neovim make fzf

# hypraland configs
echo -n "Linking HYPERLAND config: "
if [ ! -f ${HOME}/.config/hypr/hyprland.conf ]; then
    ln -s $(pwd)/hypr ${HOME}/.config/
    echo "DONE"
else
    echo "SKIPPED"
fi
# Setup Waybar
echo -n "Linking WAYBAR config: "
if [ ! -d "${HOME}/.config/waybar" ]; then
    ln -s $(pwd)/waybar ${HOME}/.config/
    echo "DONE"
else
    echo "SKIPPED"
fi
# Setup ZSH configs
echo "Linking ZSH config: "
for ZSH_FILE in ${HOME}/repos/dotFiles/zsh/* ; do
    if [ -f "$ZSH_FILE" ]; then
        CONF_FILE=".$(basename ${ZSH_FILE})"
        echo -en "\t [${CONF_FILE}]: "
        if [ ! -f ${HOME}/${CONF_FILE} ]; then
            ln -s ${ZSH_FILE} ${HOME}/${CONF_FILE}
            echo "DONE"
        else
            echo "SKIPPED"
        fi
    fi
done
# Setup OH-MY-ZSH
echo -n "Cloning OH-MY-ZSH config: "
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
    echo "DONE"
else
    echo "SKIPPED"
fi
# Tmux configs
echo -n "Linking TMUX config: "
if [ ! -f ${HOME}/.tmux.conf ]; then
    ln -s $(pwd)/tmux.conf ${HOME}/.tmux.conf
    ln -s $(pwd)/tmux ${HOME}/.config/
    echo "DONE"
else
    echo "SKIPPED"
fi
# Neovim configs
echo -n "Linking NEOVIM config: "
if [ ! -f ${HOME}/.config/nvim/init.lua ]; then
    ln -s $(pwd)/nvim ${HOME}/.config/
    echo "DONE"
else
    echo "SKIPPED"
fi

