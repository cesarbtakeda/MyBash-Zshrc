# ~/.zshrc - Configuração Completa com Usuário Dinâmico e Emojis

# ========== CONFIGURAÇÕES BÁSICAS ==========
autoload -U compinit && compinit
autoload -U colors && colors
setopt autocd extendedglob nocaseglob correct prompt_subst

# ========== FUNÇÃO IP DINÂMICO (CONFIAVEL) ==========
get_ip() {
  local ip
  ip=$(ip -o -4 addr show scope global | awk '{print $4}' | cut -d'/' -f1 | head -n1 2>/dev/null) ||
  ip=$(hostname -I | awk '{print $1}' 2>/dev/null) ||
  ip="192.168.0.20"
  echo $ip
}

# ========== EMOJIS PERSONALIZADOS ==========
local user_emoji="💀"      # Emoji para usuário normal
local root_emoji="👑"      # Emoji para root (mais agressivo)
local dir_emoji="📁"       # Emoji de diretório
local ip_emoji="🌐"        # Emoji para IP

# ========== PROMPT DINÂMICO ==========
PROMPT=$'%F{blue}┌──[%F{red}%(#.${root_emoji}.${user_emoji}) (%n)%F{white}-(%F{cyan}${ip_emoji} %B$(get_ip)%b%F{white})%F{blue}]\n%F{blue}├─[%F{yellow}${dir_emoji} %B(%~)%b%F{blue}]\n%F{blue}└─%B%(#.%F{red}#.%F{white}$)%b%f '

# ========== CONFIGURAÇÕES EXTRAS ==========
RPROMPT=''
ZLE_RPROMPT_INDENT=0
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.local/bin:$PATH"

# ========== ALIASES ESSENCIAIS ==========
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias ipa='ip -color -brief a'
alias update='sudo apt update && sudo apt full-upgrade -y'

# ========== HISTÓRICO AVANÇADO ==========
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory sharehistory incappendhistory histignoredups histreduceblanks

# ========== COMPLETION INTELIGENTE ==========
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ========== PLUGINS (RECOMENDADO) ==========
# Instale com:
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
fi

if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ========== MENSAGEM INICIAL ==========

### echo "Coloque sua mensagem aqui"
