# ~/dotfiles/zsh/.zshrc

if [ -d "/home/linuxbrew/.linuxbrew" ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -f "opt/homebrew/bin/brew" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Ruta a tu instalación de Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Configuración de Tema y Plugins de OMZ
ZSH_THEME="robbyrussell" 

plugins=(
  git
  fzf
)

# Cargar Oh My Zsh
source $ZSH/oh-my-zsh.sh

# --- CONFIGURACIONES PERSONALIZADAS ---

# Inicializar Zoxide 
eval "$(zoxide init zsh)"
alias cd="z"

# Alias para Eza (Reemplazo moderno de 'ls')
if command -v eza &> /dev/null; then
	alias ls="eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions"
	alias tree="eza --tree --level=2"
	alias ll="eza --all --long --header --git --icons=always"
fi

# Configuración de NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # Carga nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

# Alias

# pbcopy/pbpaste con xclip (clipboard X11)
if [[ "$OSTYPE" != darwin* ]]; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

# Mantener el path limpio para ejecutables locales
export PATH="$HOME/.local/bin:$PATH"

# Tmux
if [ -z "$TMUX" ] && [ -n "$PS1" ]; then
  exec tmux new-session -A -s main
fi
