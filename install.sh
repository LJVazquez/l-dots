#!/usr/bin/env bash

# Detener el script si ocurre algún error
set -e

echo "🚀 Despegando GOATVIM Setup..."

# 1. Detectar Sistema Operativo
OS="$(uname)"
if [ "$OS" == "Darwin" ]; then
    echo "🍏 Sistema operativo detectado: macOS"
elif [ "$OS" == "Linux" ]; then
    echo "🐧 Sistema operativo detectado: Linux"
else
    echo "❌ Sistema operativo no soportado por este script."
    exit 1
fi

# 2. Instalar Homebrew si no existe
if ! command -v brew &> /dev/null; then
    echo "🍺 Instalanado Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Agregar Homebrew al PATH provisionalmente para Linux/macOS ARM
    if [ -d "/home/linuxbrew/.linuxbrew" ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    elif [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "🍺 Homebrew ya está instalado. Actualizando..."
    brew update
fi

# 3. Instalar paquetes desde el Brewfile
echo "📦 Instalando paquetes desde el Brewfile..."
brew trust anomalyco/tap
brew bundle --file="$HOME/l-dots/Brewfile"

# 4. Instalar Kitty y FiraMono Nerd Font (Requerida por tu Kitty y Neovim)
echo "🔤 Configurando Kitty y Fuentes (FiraMono Nerd Font Mono)..."
if [ "$OS" == "Darwin" ]; then
    # Usar el cask nativo de macOS mediante Homebrew
    brew install --cask kitty || echo "Kitty ya podría estar instalado." 
    brew install --cask font-fira-mono-nerd-font || echo "La fuente ya podría estar instalada."
else
  PACKAGES_TO_INSTALL=()

    if ! command -v kitty &> /dev/null; then
        PACKAGES_TO_INSTALL+=("kitty")
    fi

    if ! command -v zsh &> /dev/null; then
        PACKAGES_TO_INSTALL+=("zsh")
    fi

    if [ ${#PACKAGES_TO_INSTALL[@]} -ne 0 ]; then
        echo "📥 Instalando paquetes del sistema: ${PACKAGES_TO_INSTALL[*]}..."
        if command -v apt-get &> /dev/null; then
            sudo apt-get update && sudo apt-get install -y "${PACKAGES_TO_INSTALL[@]}"
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y "${PACKAGES_TO_INSTALL[@]}"
        else
            echo "⚠️ No se detectó un gestor de paquetes conocido (apt/dnf). Por favor, instala manualmente: ${PACKAGES_TO_INSTALL[*]}"
        fi
    else
        echo "✅ Kitty y Zsh ya están instalados de forma nativa."
    fi

    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"
    if [ ! -f "$FONT_DIR/FiraMonoNerdFontMono-Regular.otf" ]; then
        echo "📥 Descargando FiraMono para Linux..."
        curl -fLo "$FONT_DIR/FiraMonoNerdFontMono-Regular.otf" \
            "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraMono/Regular/FiraMonoNerdFontMono-Regular.otf"
        curl -fLo "$FONT_DIR/FiraMonoNerdFontMono-Bold.otf" \
            "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraMono/Bold/FiraMonoNerdFontMono-Bold.otf"
        fc-cache -f -v

	fc-cache -f "$FONT_DIR" || true
    fi
fi

# 5. Instalar Oh My Zsh si no existe
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🐚 Instalando Oh My Zsh..."
    # Corremos el instalador de OMZ sin que cambie la shell por defecto interactivamente para no trabar el script
    KEEP_ZSHRC=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# 5b. Instalar Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "🎨 Instalando Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# 6. Aplicar Enlaces Simbólicos con GNU Stow
echo "🔗 Aplicando configuraciones con GNU Stow..."
cd "$HOME/l-dots"

# Remover archivos por defecto que bloqueen a Stow
rm -f "$HOME/.zshrc"
rm -f "$HOME/.tmux.conf"

# Asegurar que existan los directorios base en el target de Stow
mkdir -p "$HOME/.config/kitty"
mkdir -p "$HOME/.config/nvim"

# Ejecutar Stow por cada módulo
stow kitty
stow nvim
stow tmux
stow zsh

# 7. Instalar vtsls (TypeScript Language Server) vía npm
if command -v npm &> /dev/null; then
    echo "📦 Instalando vtsls (TypeScript Language Server)..."
    npm install -g @vtsls/language-server
else
    echo "⚠️ npm no encontrado. Instala Node.js vía nvm (brew install nvm) y luego ejecuta: npm install -g @vtsls/language-server"
fi

echo "✨ ¡Flujo de instalación completado con éxito!"
echo "🔄 Por favor, reinicia tu terminal o ejecuta: source ~/.zshrc"
