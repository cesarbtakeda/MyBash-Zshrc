# ~/.zshrc

# ========== CONFIGURAÇÕES BÁSICAS ==========
autoload -U compinit && compinit
autoload -U colors && colors
setopt autocd extendedglob nocaseglob prompt_subst interactivecomments
setopt magicequalsubst nonomatch notify numericglobsort
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # history expansion on space
bindkey '^U' backward-kill-line                   # ctrl + U
bindkey '^[[3;5~' kill-word                       # ctrl + Delete
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo

# Completion settings
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory sharehistory incappendhistory hist_expire_dups_first hist_ignore_dups hist_ignore_space hist_verify

# Hide EOL sign ('%')
PROMPT_EOL_MARK=""

# ========== FUNÇÃO IP DINÂMICO (LOCAL OU PÚBLICO) ==========
get_ip() {
  local ip
  # Tenta pegar o IP local primeiro
  ip=$(ip -o -4 addr show scope global | awk '{print $4}' | cut -d'/' -f1 | head -n1 2>/dev/null) ||
  ip=$(hostname -I | awk '{print $1}' 2>/dev/null) ||
  # Se não houver IP local, tenta pegar o IP público
  ip=$(curl -s https://api.ipify.org 2>/dev/null) ||
  ip="sem IP"
  echo $ip
}

# ========== EMOJIS PERSONALIZADOS ==========
local user_emoji="💀"      # Emoji para usuário normal
local root_emoji="👑"      # Emoji para root
local dir_emoji="📁"       # Emoji de diretório
local ip_emoji="🌐"        # Emoji para IP

# ========== PROMPT DINÂMICO ==========
PROMPT=$'%F{blue}┌──[%F{red}%(#.${root_emoji}.${user_emoji}) (%n)%F{white}${$(get_ip):+-(${ip_emoji} %B$(get_ip)%b)}%F{blue}]\n%F{blue}├─[%F{yellow}${dir_emoji} %B(%~)%b%F{blue}]\n%F{blue}└─%B%(#.%F{red}#.%F{white}$)%b%f '
RPROMPT=''
ZLE_RPROMPT_INDENT=0

# ========== PATH E ALIASES ==========
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.local/bin:$PATH"
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias ipa='ip -color -brief a'
alias update='sudo apt update && sudo apt full-upgrade -y'
alias history="history 0"

# ========== PLUGINS ==========
# Autosuggestions
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
elif [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
fi

# Syntax highlighting
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi


# ========== CONFIGURAÇÕES DE TERMINAL ==========
export TERM="xterm-256color"
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:"
fi

# ========== MENSAGEM INICIAL (OPCIONAL) ==========
# echo "Bem-vindo ao Zsh! Configuração carregada com sucesso."
