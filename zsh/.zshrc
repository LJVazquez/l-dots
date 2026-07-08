alias ls="eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias tree="eza --tree --level=2"
alias ll="eza --all --long --header --git --icons=always"
eval "$(zoxide init zsh)"

# ~/dotfiles/zsh/.zshrc

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

# Mantener el path limpio para ejecutables locales
export PATH="$HOME/.local/bin:$PATH"
