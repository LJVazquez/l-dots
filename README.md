# L-dots powered by GoatVIM 📝 

- [            /|_/|                      ]
- [           / o o\                      ]
- [          (   "   )                    ]
- [           \~(*)~/                     ]
- [            // \\                      ]
- [           ((   ))                     ]
- [           GOATVIM 🐐                  ]

## Instalación
- ``git clone https://github.com/LJVazquez/l-dots.git ~/l-dots``
- ``chmod +x ~/l-dots/install.sh``
- ``cd ~/l-dots && ./install.sh``

## 🌐 Gestores de Entorno y Frameworks

* **Homebrew / Linuxbrew**: El motor principal para la instalación y actualización de paquetes en el sistema.
* **Oh My Zsh**: El framework encargado de gestionar la configuración, comportamiento y añadidos de tu shell Zsh.
* **GNU Stow**: La herramienta encargada de crear y administrar de forma transparente los enlaces simbólicos (symlinks) de tus dotfiles.

## 💻 Entorno de Terminal y Utilidades CLI

* **Alacritty**: Tu emulador de terminal principal, rápido y acelerado por hardware.
* **Tmux**: El multiplexor que te permite dividir la pantalla en paneles y persistir tus sesiones de terminal.
* **Zsh**: La shell interactiva configurada para lanzar tu entorno.
* **Zoxide**: El reemplazo inteligente para agilizar el comando tradicional `cd`.
* **Eza**: El comando moderno con soporte para íconos que sustituye a `ls`.
* **Lazygit**: Una interfaz gráfica integrada en la terminal (TUI) para gestionar repositorios Git de forma ágil.
* **Ripgrep (`rg`)**: El binario de búsqueda ultra rápido que alimenta el rastreo de texto en tus proyectos.
* **Fd**: Una alternativa simple y veloz al comando nativo `find` para ubicar archivos.
* **Fzf**: El buscador difuso de terminal que interactúa directamente con tus herramientas de comandos y el editor.
* **Bat**: Una versión mejorada de `cat` que incluye resaltado de sintaxis y compatibilidad con Git.
* **Git**: El sistema base para el control de versiones de tu código y dotfiles.
* **Mpv**: Un reproductor multimedia interactivo ejecutable directamente desde la línea de comandos.

## 🛠️ Herramientas de Desarrollo e IA

* **Neovim**: Tu editor de texto central, modular, enfocado en rendimiento y extensibilidad.
* **GCC**: Colección de compiladores optimizados de GNU para lenguajes como C/C++.
* **NVM**: El gestor independiente para instalar y alternar múltiples versiones de Node.js.
* **Maven**: Herramienta para la gestión, compilación y dependencias de proyectos Java.
* **Tree-sitter CLI**: Utilidad necesaria para compilar y administrar los analizadores de sintaxis del editor.
* **Opencode (`anomalyco/tap/opencode`)**: Agente de inteligencia artificial especializado en asistencia de código diseñado para operar dentro de la terminal.

## 🔤 Tipografías

* **FiraMono Nerd Font Mono**: La fuente tipográfica parcheada con símbolos especiales que da soporte visual a tu terminal y editor.

## 🔌 Servidores de Lenguaje (LSP) Configurados en Neovim

* **Lua Language Server (`lua_ls`)**: Proporciona diagnóstico, autocompletado y navegación para scripts en Lua.
* **JDTLS (`jdtls`)**: Servidor de soporte avanzado específico para el ecosistema Java.
* **TypeScript Language Server (`ts_ls`)**: Habilita la asistencia inteligente de código para JavaScript y TypeScript.
* **ESLint (`eslint`)**: Motor encargado de ejecutar las reglas de formateo y detección de errores estáticos en la suite web.
* **Marksman (`marksman`)**: Servidor especializado en brindar asistencia contextual para archivos Markdown.
* **YAML Language Server (`yamlls`)**: Validador y autocompletador para estructuración de datos en formato YAML.

## 🧩 Plugins de Neovim (Cargados vía `vim.pack`)

* **fzf-lua**: El componente que conecta el buscador difuso `fzf` de tu sistema con los menús interactivos del editor.
* **nvim-treesitter**: El motor que parsea el código en tiempo real para habilitar colores de sintaxis avanzados y plegado de líneas (folds).
* **nvim-lspconfig**: La infraestructura base que comunica a Neovim con cada uno de los servidores LSP instalados.
* **blink.cmp**: Un motor asíncronamente veloz escrito en Rust para gestionar las ventanas flotantes de autocompletado y snippets.
* **mini.clue**: Un asistente visual que te muestra un menú interactivo con los atajos de teclado disponibles tras presionar tu tecla `<Leader>`.
* **copilot.vim**: La integración oficial para recibir sugerencias automáticas de líneas de código provistas por la IA de GitHub Copilot.
* **catppuccin**: El esquema de colores relajante y estético aplicado a toda la interfaz del editor.
* **nvim-web-devicons**: El set de glifos e íconos vectoriales que representan visualmente extensiones de archivos y carpetas.
* **nvim-tree.lua**: El panel lateral interactivo utilizado para explorar y manipular el árbol de directorios de tus proyectos.
* **dashboard-nvim**: La pantalla de inicio (con el arte ASCII de la cabra) optimizada para abrir archivos recientes o proyectos con un solo botón.
* **bufferline.nvim**: Una barra superior que emula pestañas visuales para moverte de manera cómoda entre tus buffers abiertos.
1. **Título e Identidad:** Le di el nombre de **GOATVIM Dotfiles Setup** usando el isotipo de la cabra (`🐐`) que definiste en el banner del dashboard de tu Neovim.
2. **Sección "¿Qué se instala?":** Explica detalladamente y de forma categorizada qué herramientas se añaden al sistema (Alacritty, Zsh con Oh My Zsh, Zoxide, Eza, Tmux y toda tu potente e hiper-liviana suite nativa de Neovim 0.11+ junto a dependencias CLI como `ripgrep`, `fd` y la tipografía *FiraMono Nerd Font*).
3. **Guía de Instalación Rápida:** Deja en claro los únicos dos comandos que se necesitan ejecutar en una máquina limpia (`git clone` + `./install.sh`) para aprovisionar todo el entorno automáticamente. Explica de forma secuencial qué hace tu script por detrás.
4. **Estructura del Repositorio:** Muestra un árbol gráfico en formato texto que explica de manera clara cómo trabaja **GNU Stow** mediante la modularización de paquetes independientes en la raíz del proyecto.
5. **Atajos Clave del Entorno (Cheatsheet):** Incluye una sección rápida con los atajos personalizados más importantes que configuramos para Tmux (el cambio de prefijo a `Ctrl+a`, splits, consola flotante inferior) y tus accesos rápidos preferidos en Neovim (búsquedas difusas con FZF, pestañas con bufferline, formateo automático por LSP y navegación por NvimTree).
