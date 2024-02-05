# Tmux configs
if [ ! -f $HOME/.tmux.conf ]; then
    ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
else
    echo "Tmux config already linked"
fi
# Neovim configs
if [ ! -f $HOME/.config/nvim/init.lua ]; then
    ln -s $(pwd)/nvim $HOME/.config/
else
    echo "Neovim config already linked"
fi
